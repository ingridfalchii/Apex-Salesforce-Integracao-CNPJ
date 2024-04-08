@IsTest
public class IntegrationByCnpjTest {
  @IsTest
    private static void testSendCNPJ() {
    Test.setMock(HttpCalloutMock.class, new IntegrationByCNPJMock());
    Test.startTest();
    
    Account acc = new Account(
    name='teste', 
      CNPJ__c= '59717553000102',
      Industry='Alta Tecnologia',
        Tamanho__c='GB (1000 a 2000)',
        Nome_Contato__c='teste',
        Sobrenome_contato__c ='teste'
  );
    insert acc; 
        
        acc.CNPJ__c ='21900899000179';
            update acc;
  
        Account ac = new Account(
    name='teste', 
      CNPJ__c= '00623904000173',
      Industry='Alta Tecnologia',
        Tamanho__c='GB (1000 a 2000)',
        Nome_Contato__c='teste',
        Sobrenome_contato__c ='teste'
    );
        insert ac;    

    Test.stopTest();
    // runs callout and check results
    List<Account> logs = [SELECT Id, CNPJ__c, Razao_Social__c, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingAddress,
                               Status__c, Ultima_atualizacao__c, Tipo__c, Porte__c, Nome_Fantasia__c, Natureza_Juridica__c, 
                               Numero__c, Bairro__c, Email_CNPJ__c, CnpjPhone__c, efr__c,complement__c, situation__c, reasonForTheSituation__c, SpecialSituation__c, SpecialSituationDate__c, 
                               Shareapital__c,Text__c, Code__c, Data_de_Abertura__c
                 FROM Account];
    System.assertEquals(2, logs.size());
    System.assertEquals('21900899000179', logs[0].CNPJ__C);
  }
}
