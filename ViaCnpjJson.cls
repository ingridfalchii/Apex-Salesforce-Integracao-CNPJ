public class ViaCnpjJson {

    public String status;
    public String ultima_atualizacao;
    public String cnpj;
    public String tipo;
    public String porte;
    public String nome;
    public String fantasia;
    public String abertura;
    public String natureza_juridica;
    public String logradouro;
    public String numero;
    public String complemento;
    public String cep;
    public String bairro;
    public String municipio;
    public String uf;
    public String email;
    public String telefone;
    public String efr;
    public String situacao;
    public String motivo_situacao;
    public String situacao_especial;
    public String data_situacao_especial;
    public String capital_social;
  public String Resultado;
    public List<AtividadePrincipal> atividade_principal;
    public List<AtividadeSecundaria> atividades_secundarias;
    public List<QuadroSocietario> qsa;
    
    Public Class AtividadePrincipal {
         public  String code;
         public  String text; 
    }
    
     Public Class AtividadeSecundaria {
         public  String code;
         public  String text; 
    }
 
     Public Class QuadroSocietario{
         public  String nome;
         public  String qual;
         public  String pais_origem;
         public  String nome_rep_legal;
         public  String qual_rep_legal;
    }
}