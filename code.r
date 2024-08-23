## Baixa e concatena os dados de candidatos
## Autor: Bianca Muniz
## Última atualização: 19/08/2024

####################################################################
### pacotes

library(tidyverse)
library(httr)
library(lubridate)
library(janitor)
library(utils)

### Definir a URL e o caminho do arquivo
url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/consulta_cand/consulta_cand_2024.zip"
destfile <- "consulta_cand_2024.zip"
extract_dir <- "consulta_cand_2024_files"


### Baixar o arquivo zip
GET(url, write_disk(destfile, overwrite = TRUE))
### Criar diretório para extrair os arquivos
dir.create(extract_dir, showWarnings = FALSE)
### Extrair o conteúdo do arquivo zip
unzip(destfile, exdir = extract_dir)
### Confirmar extração
cat("Arquivos extraídos para", extract_dir)
### Liste todos os arquivos CSV na pasta
file_list <- list.files(path = extract_dir, pattern = "\\.csv$", full.names = TRUE)
### Função para ler CSVs com encoding latin1 e converter colunas para tipos coerentes
read_and_convert <- function(file) {
  df <- read_csv2(file, locale = locale(encoding = "latin1"))
  ### Converte colunas para os tipos apropriados, ajustando conforme necessário
  df <- mutate(df, SG_UE = as.character(SG_UE))
  return(df)
}

### Leia e concatene todos os arquivos CSV em um único data frame
candidatos <- file_list %>%
  lapply(read_and_convert) %>%
  bind_rows() |> 
  distinct()


# Lista de termos para filtrar
termos <- c("APÓSTOLA", "APÓSTOLO", "BABALORIXÁ", "BISPA ", "BISPO ", "IRMÃ ", 
            "IRMÃO ", "MÃE ", "PAI ", "MISSIONÁRIA", "MISSIONÁRIO", "PADRE ", 
            "PASTOR", "PASTORA", "PRESBÍTERO", "PROFETA", "REVERENDO", 
            "YALORIXÁ", "IALORIXÁ")

# Filtrando e unindo os dataframes
df_urna <- termos |>
  map(~ candidatos |> filter(str_detect(NM_URNA_CANDIDATO, .x))) |>
  bind_rows()


df_religiosos <- candidatos |> filter(DS_OCUPACAO=="SACERDOTE OU MEMBRO DE ORDEM OU SEITA RELIGIOSA")

df <- rbind(df_urna, df_religiosos) %>%
  distinct()



###### salvei em csv pra retirada de nomes que não fazem parte do levantamento no Google sheets
write.csv2(df, "candidatos_religiosos_1908.csv")

#################### bens
### Definir a URL e o caminho do arquivo
url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/bem_candidato/bem_candidato_2024.zip"
destfile <- "bem_candidato_2024.zip"
extract_dir <- "bem_candidato_2024_files"


### Baixar o arquivo zip
GET(url, write_disk(destfile, overwrite = TRUE))
### Criar diretório para extrair os arquivos
dir.create(extract_dir, showWarnings = FALSE)
### Extrair o conteúdo do arquivo zip
unzip(destfile, exdir = extract_dir)
### Confirmar extração
cat("Arquivos extraídos para", extract_dir)
### Liste todos os arquivos CSV na pasta
file_list <- list.files(path = extract_dir, pattern = "\\.csv$", full.names = TRUE)
### Função para ler CSVs com encoding latin1 e converter colunas para tipos coerentes
read_and_convert <- function(file) {
  df <- read_csv2(file, locale = locale(encoding = "latin1"))
  ### Converte colunas para os tipos apropriados, ajustando conforme necessário
  df <- mutate(df, SG_UE = as.character(SG_UE))
  return(df)
}

### Leia e concatene todos os arquivos CSV em um único data frame
bens <- file_list %>%
  lapply(read_and_convert) %>%
  bind_rows() |> 
  distinct()

#################
candidatos <- read_csv("candidatos_religiosos_limpo.csv")


bens_filtrados <- bens %>%
  filter(SQ_CANDIDATO %in% candidatos$SQ_CANDIDATO)



bens_filtrados <- bens[bens$SQ_CANDIDATO %in% candidatos$SQ_CANDIDATO, ]

# Realizando a junção (merge) dos dataframes bens_filtrados e candidatos
bens_com_informacoes <- merge(bens_filtrados, candidatos, by = "SQ_CANDIDATO", all.x = TRUE)
