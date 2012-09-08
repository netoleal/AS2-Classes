/**
* com.netoleal.validators.Exemple
*
* @author Neto Leal
* @version 0.1
*/

import com.netoleal.validators.*;

class com.netoleal.validators.Example {

	var txtNome:TextField;
	var txtEmail:TextField;
	var txtIdade:TextField;
	var txtMensagem:TextField;
	
	function validaFormulario( ):ValidationResult {
		
		var validacao:ValidationGroup = new ValidationGroup( );
		
		validacao.addValidation( [ txtNome.text, txtEmail.text, txtIdade.text, txtMensagem.text ], NotEmptyValidation, "Todos os campos são obrigatórios" );
		validacao.addValidation( [ txtEmail.text ], EmailValidation, "Informe um email válido" );
		validacao.addValidation( [ Number( txtIdade.text ), 18, 70 ], NumericRangeValidation, "Informe uma idade entre 18 e 70" );
		
		//Outras formas de validação:
		
		//DateValidation (Valida se uma ou mais datas é(são) válida(s). Informar [ dia, mes, ano, dia, mes, ano, ... ... ... ])
		//IsSetValidation (Valida se um ou mais valores não é nem null nem undefined)
		//NumericValidation (Valida se um ou mais valores são números)
		//RestrictCharsValidation (restringe se um ou mais valores de texto respeitam um conjunto de caracteres. por exemplo o texto "ele" no conjunto "ela" é válido pois nenhum caracter de "ele" está fora do conjunto "ela". Passar como parâmetros: (ex:) [ "ele", "ela", "a", "abcd" ]
		
		return validacao.validate( );
		
	}
	
	function enviaFormulario( ):Void {
		
		var validacao:ValidationResult = validaFormulario( );
		
		if( validacao.isValid( ) ){
			//Formulário todo válido. Pode enviar
		} else {
			//Formulário inválido
			trace( validacao.message ); //validacao.message traz a mensagem de erro definida em "validaFormulario"
		}
		
	}
	
}