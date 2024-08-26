# Metodologia da reportagem ["Bíblia e bens: candidatos religiosos milionários têm fazenda, empresa e multa ambiental"](https://apublica.org/2024/08/biblia-e-bens-candidatos-religiosos-milionarios-tem-fazenda-empresa-e-multa-ambiental/)

- Usamos a base de candidatos do Portal de Dados Abertos do Tribunal Superior Eleitoral, extraída dia 19/08 às 12h30.
- Consideramos “candidato religioso” os pré-candidatos que atendiam a esses critérios:
- DS_OCUPACAO = SACERDOTE OU MEMBRO DE ORDEM OU SEITA RELIGIOSA
- NM_URNA_CANDIDATO contendo os termos “APÓSTOLA", "APÓSTOLO", "BABALORIXÁ", "BISPA ", "BISPO ", "IRMÃ ", "IRMÃO ", "MÃE ", "PAI ", "MISSIONÁRIA", "MISSIONÁRIO", "PADRE ", "PASTOR", "PASTORA", "PRESBÍTERO", "PROFETA", "REVERENDO", "YALORIXÁ", "IALORIXÁ"
- Foram excluídos: 1) Candidatos com IRMÃO/IRMÃ/MÃE/PAI + DO/DA no nome e que não tem a ocupação de SACERDOTE OU MEMBRO DE ORDEM OU SEITA RELIGIOSA; 2) Candidatos com BISPO, PROFETA, PASTOR no NM_CANDIDATO e que não têm a ocupação de SACERDOTE OU MEMBRO DE ORDEM OU SEITA RELIGIOSA
- Nesses critérios, encontramos 7445 candidatos. Desses, 657 declararam a ocupação “SACERDOTE OU MEMBRO DE ORDEM OU SEITA RELIGIOSA”
- A partir disso, extraímos os dados de patrimônio declarado dos candidatos dessa lista, no dia 19/08. Os valores foram agrupados por candidato, tornando possível encontrar os nomes com maior patrimônio declarado.
- Os dados e códigos podem ser vistos no Github da Agência Pública.
