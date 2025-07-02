# 🌿 Extração e Limpeza de Dados da Plataforma PhotosynQ

Este projeto contém um script em R (`MultispeQ.R`) projetado para automatizar o processo de download, limpeza e formatação de dados de fotossíntese da plataforma PhotosynQ.

## 🧭 Contexto

A plataforma PhotosynQ permite que pesquisadores coletem e compartilhem dados de medições de plantas, como fotossíntese, usando dispositivos como o MultispeQ. Os dados são armazenados em um formato estruturado (JSON) que pode ser complexo para analisar diretamente. Este script serve como uma ponte, extraindo os dados brutos via API e transformando-os em um formato tabular (CSV) pronto para análise estatística.

## ⚙️ Funcionalidades do Script

1. **🔐 Autenticação**: Realiza o login na plataforma PhotosynQ.
2. **📥 Extração de Dados**: Baixa os metadados e os dados brutos do projeto especificado.
3. **🧹 Limpeza de Dados de Localização**: Utiliza a função `lista_sem_location` para remover recursivamente os campos de geolocalização (`location`) dos dados. Isso é crucial porque a presença desses campos pode causar erros ao tentar converter a lista de dados aninhada em um data frame com a função `PhotosynQ::createDataframe`.
4. **🗃️ Criação do Data Frame**: Converte os dados limpos em um data frame estruturado.
5. **🔎 Filtragem e Seleção**:

   * Filtra as medições para incluir apenas aquelas com status `"submitted"`, garantindo que apenas dados completos e validados sejam usados.
   * Seleciona um subconjunto de colunas (parâmetros fisiológicos) de interesse para a análise.
6. **💾 Exportação**: Salva o data frame final em um arquivo CSV (`vigna.csv`) no formato `csv2` (ponto e vírgula como separador), compatível com versões do Excel em português.

## 📦 Pré-requisitos

Para executar o script, você precisará ter o R e o RStudio (recomendado) instalados, além das seguintes bibliotecas do R:

* `PhotosynQ`: Para interagir com a API da plataforma.
* `dplyr`: Para manipulação e filtragem de dados.

Você pode instalar as bibliotecas com o seguinte comando no console do R:

```r
install.packages(c("PhotosynQ", "dplyr"))
```

## 🧪 Como Usar

1. **Clone ou baixe** este repositório.
2. **Abra o arquivo `MultispeQ.R`** no RStudio ou em seu editor de R preferido.
3. **🔑 Atualize suas credenciais**: Modifique a linha de login com seu e-mail da conta PhotosynQ.

   ```r
   PhotosynQ::login(email = "seu-email@exemplo.com.br")
   ```

   *💡 Nota: Para maior segurança, considere usar variáveis de ambiente para armazenar suas credenciais em vez de escrevê-las diretamente no script.*
4. **🆔 (Opcional) Altere o ID do Projeto**:

   ```r
   ID <- SEU_ID_DE_PROJETO
   ```
5. **📁 (Opcional) Altere o caminho de saída**:

   ```r
   write.csv2(x = dados_filtrados, file = "caminho/para/seu/arquivo.csv")
   ```
6. **▶️ Execute o script**.
   Ao final da execução, o arquivo `vigna.csv` (ou o nome que você definiu) será criado no local especificado, contendo os dados prontos para análise.

## 🗂️ Estrutura do Projeto

* `MultispeQ.R`: O script principal que executa todo o processo de extração e limpeza.
* `vigna.csv` (Saída): O arquivo CSV gerado pelo script, contendo os dados de fotossíntese limpos e formatados.