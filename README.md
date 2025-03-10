# CoinExchange

![Gif do App](https://private-user-images.githubusercontent.com/38943978/416814319-9eda2f1c-cb67-42de-b42c-8d9f60c4ee8f.gif?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NDA1MDY0MTEsIm5iZiI6MTc0MDUwNjExMSwicGF0aCI6Ii8zODk0Mzk3OC80MTY4MTQzMTktOWVkYTJmMWMtY2I2Ny00MmRlLWI0MmMtOGQ5ZjYwYzRlZThmLmdpZj9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTAyMjUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUwMjI1VDE3NTUxMVomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWVmZWM4ZmYyMTFlNWE2OTFlZmQ1YjY4ZDI1NGZjMTUxODk0Nzg2OTQyY2YwMmMwZGM2MmFhNjJlNGUwYjdiYmYmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.SxJ5u0_3zZUZrsafMIn4zCea4JQF6Yf9mt3SQs08z10)  <!-- Adicione o link do seu gif aqui -->

CoinExchange é um aplicativo iOS desenvolvido em Swift que consulta a API da CoinAPI.io para exibir uma lista de exchanges de criptomoedas e seus respectivos ícones. O aplicativo foi projetado sem dependências externas, utilizando exclusivamente recursos nativos da linguagem e do SDK do iOS.

Ele segue a arquitetura VIP-C (View-Interactor-Presenter-Coordinator), com design patterns como Factory para criação de telas e DependencyContainer para injeção de dependências. Todo o código é baseado em Protocol-Oriented Programming (POP), garantindo escalabilidade, testabilidade e manutenção.

## Pré-requisitos

Para executar o projeto, você precisará de:

- **Xcode**: Versão 15.0 ou superior (recomendado).
- **iOS**: Compatível com iOS 15.0 ou superior.
- **Chave da API**: Uma chave válida da CoinAPI.io para consultas à API (veja instruções abaixo).

## Instruções de Execução

1. **Baixe o Projeto**

   Descompacte o arquivo `.zip` enviado por e-mail.

2. **Abra no Xcode**

   Navegue até a pasta do projeto e abra o arquivo `CoinExchange.xcodeproj` no Xcode.

3. **Configure a Chave da API**

   No projeto, localize o arquivo `ConfigService.apikey` e substitua a chave da API por uma chave válida da CoinAPI.io. A chave da API pode ser obtida diretamente no [site da CoinAPI.io](https://www.coinapi.io).

4. **Compile e Execute**

   Selecione um simulador (ex.: iPhone 15) ou dispositivo físico no Xcode.

   Pressione `Cmd + R` ou clique em "Run" para compilar e executar o aplicativo. A tela inicial exibirá a lista de exchanges obtidas da API.

## Duvidas

Caso tenha dúvidas, verifique a documentação da CoinAPI.io para mais detalhes sobre a obtenção da chave de API.
