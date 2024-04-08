## Integração Via CNPJ

Este projeto implementa uma integração com a API ViaCNPJ para atualizar dados de contas no Salesforce com base no CNPJ informado.

## Funcionalidades Implementadas

Método invocável consultaCNPJ para integração com a API ViaCNPJ.
Método atualizaAccount para consulta do CNPJ, atualização dos dados da conta e gravação no Salesforce.
Utilização de chamadas assíncronas (@future) para chamadas de serviço externo.
Parseamento da resposta JSON da API ViaCNPJ para atualização dos dados da conta.

## Como Utilizar

Para utilizar essa integração, siga os passos abaixo:

Certifique-se de que a classe IntegrationByCNPJ e a classe ViaCnpjJson estão corretamente implementadas no Salesforce.
Utilize o método consultaCNPJ para acionar a integração e passar os IDs das contas que deseja atualizar.
A classe irá realizar a consulta do CNPJ para cada conta, atualizar os dados com base na resposta da API ViaCNPJ e salvar no Salesforce.
Testes
Este projeto inclui testes de unidade para garantir o correto funcionamento da integração. Os testes são executados utilizando uma classe de mock (IntegrationByCNPJMock) para simular a resposta da API ViaCNPJ.

## Autores

Ingrid de Falchi
