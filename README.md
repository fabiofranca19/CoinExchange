# CoinExchange

CoinExchange é um aplicativo iOS desenvolvido em Swift que consulta a API da CoinAPI.io para exibir uma lista de exchanges de criptomoedas e seus respectivos ícones. O aplicativo foi projetado sem dependências externas, utilizando exclusivamente recursos nativos da linguagem e do SDK do iOS.

Ele segue a arquitetura VIP-C (View-Interactor-Presenter-Coordinator), com design patterns como Factory para criação de telas e DependencyContainer para injeção de dependências. Todo o código é baseado em Protocol-Oriented Programming (POP), garantindo escalabilidade, testabilidade e manutenção.

## Pré-requisitos

Para executar o projeto, você precisará de:

- **Xcode**: Versão 15.0 ou superior (recomendado).
- **iOS**: Compatível com iOS 15.0 ou superior.
- **Chave da API**: Uma chave válida da CoinAPI.io para consultas à API (veja instruções abaixo).

## Instruções de Execução

### 1. Baixe o Projeto

Descompacte o arquivo `.zip` enviado por e-mail.

### 2. Abra no Xcode

1. Navegue até a pasta do projeto.
2. Abra o arquivo `CoinExchange.xcodeproj` no Xcode.

### 3. Configure a Chave da API

1. No projeto, localize o arquivo `ConfigService.swift`.
2. Altere o valor da propriedade `apikey` para uma chave válida da CoinAPI.io.

### 4. Compile e Execute

1. Selecione um simulador (ex.: iPhone 15) ou um dispositivo físico no Xcode.
2. Pressione `Cmd + R` ou clique em **Run** para compilar e executar o aplicativo.

A tela inicial exibirá a lista de exchanges obtidas da API.

Caso tenha dúvidas, verifique a [documentação da CoinAPI.io](https://www.coinapi.io/) para mais detalhes sobre a obtenção da chave de API.

