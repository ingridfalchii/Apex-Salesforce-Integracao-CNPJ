Public class IntegrationByCNPJ {
    
    @InvocableMethod(label='Get CNPJ' description='Integrate with IntegrationByCNPJ')
    Public static void consultaCNPJ(Id[] objectIds) {
        if(!System.isFuture() && !System.isBatch() && !System.isScheduled()){
            atualizaAccount(objectIds);
        }
    }
    
    //metodo usado quando você realiza chamada a serviços da Web externos 
    @future(callout=true)
    
    //metodo que atualiza a conta    
    Public static void atualizaAccount(Id[] objectIds) {
        //Criando lista com os dados da conta
        List<Account> accs =  [SELECT Id, CNPJ__c, Razao_Social__c, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingAddress,
                               Status__c, Ultima_atualizacao__c, Tipo__c, Porte__c, Nome_Fantasia__c, Natureza_Juridica__c, 
                               Numero__c, Bairro__c, Email_CNPJ__c, CnpjPhone__c, efr__c,complement__c, situation__c, reasonForTheSituation__c, SpecialSituation__c, SpecialSituationDate__c, 
                               Shareapital__c,Text__c, Code__c, Data_de_Abertura__c
                 FROM Account WHERE id IN :objectIds];        

        //criando uma lista com os dados da atividade com relacionamento com a conta
        List<MainActivity__c> lstcode= [SELECT id, name,codee__c, text__c from MainActivity__c where account__c IN : objectIds];       
        List<Contact> cont = [SELECT id, PartnerQualification__c ,firstName, lastName from contact where AccountId IN : objectIds];
        List<MainActivity__c> lstcoderetorno= new List<MainActivity__c>();
        List<Contact> lstcont = new List<Contact>();
          
        for(Account acc : accs) {       
            //pega o cnpj da conta para verificar na web os dados
            String CNPJbusca = acc.CNPJ__c;               
            System.debug('CNPJ Busca: '+CNPJbusca);
            
            //criando a requisição na web
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://receitaws.com.br/v1/cnpj/'+ CNPJbusca);
            request.setMethod('GET');
            HttpResponse response = http.send(request);        
            // If the request is successful, parse the JSON response.
            
            try {
                System.debug(response.getStatusCode());
                if(response.getStatusCode() == 200) {
                    //desserializar o Json
                    ViaCnpjJson results = (ViaCnpjJson) JSON.deserialize(response.getBody(), ViaCnpjJson.class);
               
                     //Pega os resultados da busca e coloca nas variaveis 
                    acc.BillingCity = results.municipio;
                    acc.BillingState = results.uf;
                    acc.BillingPostalCode = results.cep;
                    acc.BillingStreet = results.logradouro;
                    acc.Razao_Social__c = results.nome;
                    acc.Status__c = results.status;
                    acc.Ultima_atualizacao__c = date.valueOf(results.ultima_atualizacao);
                    acc.Tipo__c = results.tipo;
                    acc.Porte__c = results.porte;
                    acc.Nome_Fantasia__c = results.fantasia;
                    acc.Data_de_Abertura__c = results.abertura;
                    acc.Natureza_Juridica__c = results.natureza_juridica; 
                    acc.Numero__c = results.numero;
                    acc.Bairro__c = results.bairro;
                    acc.complement__c = results.complemento;
                    acc.CnpjPhone__c = results.telefone;
                    acc.Email_CNPJ__c = results.email;    
                    acc.efr__c = results.efr;
                    acc.situation__c = results.situacao;
                    acc.reasonForTheSituation__c = results.motivo_situacao;
                    acc.SpecialSituation__c = results.situacao_especial;
                    acc.SpecialSituationDate__c = results.data_situacao_especial;
                    acc.Shareapital__c = results.capital_social;
                    acc.Code__c = results.atividade_principal.get(0).code;             
                  acc.Text__c = results.atividade_principal.get(0).text; 
                    
                    //pega o tamanho da lista retornada de atv secundarias e quadro societário da receita federal
                    Integer tamanho = results.atividades_secundarias.size();    
                    Integer tamanhoNovo = results.qsa.size();

                     //Coloca os dados de acordo com o tamanho da lista retornada de atv secundarias
                    for(integer i=0; i<tamanho; i++){
                  
                        system.debug('entrou no for' + i );
                        //Cria o objeto para inserção de dados
                        MainActivity__c AtvSecundaria = new MainActivity__c();
                        
                        AtvSecundaria.codee__c = results.atividades_secundarias.get(i).code;
                        AtvSecundaria.name= results.atividades_secundarias.get(i).code;
                         AtvSecundaria.text__c = results.atividades_secundarias.get(i).text;
                        AtvSecundaria.account__c = acc.Id;
                        
                        if(lstcode.size()!= null && lstcode.size()!=0){
                           AtvSecundaria.id = lstcode[i].id;
                        }
                            lstcoderetorno.add(AtvSecundaria); 
                    }
 
                    for(integer j=0; j<tamanhoNovo; j++){
                        String last ='';                        
                        String str = results.qsa.get(j).nome;
            String[] str2 = str.split(' ');
               
                        for(integer i=1;i<str2.size();i++){
                             last += str2[i]+' ';
                        }
  
                        Contact contato = new Contact ();
                        
                        contato.firstName = str2[0];
                        contato.lastName = last;
                      contato.PartnerQualification__c = results.qsa.get(j).qual;
                        contato.AccountId = acc.Id;
                                         
                        if(cont.size()!= null && cont.size()!=0){
                            system.debug('j: '+j+'cont size: '+cont.size());
                            if(j < cont.size()){
                               contato.id = cont[j].id; 
                            }
                        } 
                        
                        if(contato.PartnerQualification__c != null || contato.PartnerQualification__c != ''){
                            contato.partner__c = true;
                        }
                       
                        lstcont.add(contato);    
                  }  
                        upsert lstcoderetorno;
                      upsert lstcont;
                      update acc;
                }
            }catch(exception e){
                System.debug('Erro: ' + e);
            } 
        }
    }
}