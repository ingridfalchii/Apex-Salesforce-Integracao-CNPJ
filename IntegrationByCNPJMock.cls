@isTest
public class IntegrationByCNPJMock implements HttpCalloutMock {
  public HttpResponse respond(HttpRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{ "atividade_principal": [{"text": "Bancos múltiplos, com carteira comercial","code": "64.22-1-00"}], "data_situacao": "03/11/2005","tipo": "MATRIZ","nome": "BANCO BRADESCO S.A.","telefone": "(11) 3684-5122","atividades_secundarias": [{"text": "Serviços combinados de escritório e apoio administrativo","code": "82.11-3-00"}],"qsa": [{"nome": "CASSIANO RICARDO SCARPELLI","qual": "10-Diretor"},{"nome": "CAROLINA SALOMAO FERA","qual": "10-Diretor"},{"nome": "HEBERCLEY MAGNO DOS SANTOS LIMA","qual": "10-Diretor"}],"situacao": "ATIVA","bairro": "VILA YARA","logradouro": "NUC CIDADE DE DEUS","numero": "S/N","cep": "06.029-900","municipio": "OSASCO","uf": "SP","porte": "DEMAIS","abertura": "02/03/1943","natureza_juridica": "204-6 - Sociedade Anônima Aberta","fantasia": "BRADESCO EST UNIF","cnpj": "60.746.948/0001-12","ultima_atualizacao": "2022-10-07T14:08:08.283Z","status": "OK","complemento": "","email": "","efr": "","motivo_situacao": "","situacao_especial": "","data_situacao_especial": "","capital_social": "87100000000.00","extra": {}, "billing": {"free": true,"database": true}}');
        res.setStatusCode(200);
        return res;
    }
}