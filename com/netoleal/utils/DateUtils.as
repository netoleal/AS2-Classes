import com.netoleal.utils.StringUtils;

class com.netoleal.utils.DateUtils {
	
	public static function parseStringDate( theDate:String ):Date {
		
		var ar:Array = theDate.split( " " );
		var date:Array = ar[ 0 ].split( "-" );
		var time:Array = ar[ 1 ].split( ":" );
		
		return new Date( date[ 0 ], Number( date[ 1 ] ) - 1, date[ 2 ], time[ 0 ], time[ 1 ], time[ 2 ], 0 );
		
	}
	
	public static function formatDate( date:Date, mask:String ):String {
		
		mask = mask || "dd/mm/yyyy"
		
		mask = mask.split( "mm" ).join( StringUtils.leftZero( date.getMonth() + 1, 2 ) );
		mask = mask.split( "m" ).join( String( date.getMonth() + 1 ) );
		
		mask = mask.split( "M" ).join( getMonthsNames()[ date.getMonth() ] );
		
		mask = mask.split( "yyyy" ).join( String( date.getFullYear( ) ) );
		
		mask = mask.split( "dd" ).join( StringUtils.leftZero( date.getDate(), 2 ) );
		mask = mask.split( "d" ).join( String( date.getDate( ) ) );
		
		mask = mask.split( "w" ).join( getWeekNames( )[ date.getDay() ] );
		
		return mask;
		
	}
	
	public static function formatTime( date:Date, mask:String ):String {
		
		mask = mask || "hh/mm/ss";
		
		mask = mask.split( "hh" ).join( StringUtils.leftZero( date.getHours(), 2 ) );
		mask = mask.split( "h" ).join( String( date.getHours() ) );
		
		mask = mask.split( "mm" ).join( StringUtils.leftZero( date.getMinutes(), 2 ) );
		mask = mask.split( "m" ).join( String( date.getMinutes() ) );
		
		mask = mask.split( "ss" ).join( StringUtils.leftZero( date.getSeconds(), 2 ) );
		mask = mask.split( "s" ).join( String( date.getSeconds() ) );
		
		return mask;
		
	}
	
	public static function getMonthsNames( ):Array {
		return ( "Janeiro,Fevereiro,Março,Abril,Maio,Junho,Julho,Agosto,Setembro,Outubro,Novembro,Dezembro" ).split( "," );
	}
	
	public static function getWeekNames( ):Array {
		return ( "Domingo,Segunda-feira,Terça-feira,Quarta-feira,Quinta-feira,Sexta-feira,Sábado" ).split( "," );
	}
	
}
