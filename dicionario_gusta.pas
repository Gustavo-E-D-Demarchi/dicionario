program pzim;
uses crt;

	type
		Tverbete = ^E_Dicionario;
		E_Dicionario = record
			br : string; //portugues 
			ing : string;	// ingles
			prox : Tverbete;
		end; 
	 
		Tlista = ^E_lista ;
		E_lista = record 
			ant : Tlista ; //anterior
			key : string; 
			dicionario : Tverbete ;
			prox : Tlista ;
		end;
	
	function verificar_palavra ( D : Tverbete ; P : string ) : boolean ;
	var
		sair : boolean ;
	begin	
		if D = nil then 
			verificar_palavra := false
		else 
		begin	
			if D^.br = P then
				verificar_palavra := true 
			else if D^.prox <> nil then
				sair := false
				else 
				sair := true 

			if sair then
				verificar_palavra := false 
			else 
			verificar_palavra := verificar_palavra( D^.prox , P );
		end;
	end;

	function consultar ( T_lista : Tlista ; chave : string ) : Tlista ;
	var 
		atual : Tlista ;
	begin
		atual := T_lista ;

		while ( atual <> nil ) and ( atual^.key < chave ) do
			atual := atual^.prox ;
		
		if ( atual <> nil ) and ( atual ^.key = chave) then
			consultar := atual 
		else 
			consultar := nil ;
	end;
   	
	function ler : string ;
	var
		temp : string ;
	begin
		write (' digite a palavra :') ;
		readln( temp ) ;
		ler := temp ;
	end;

	function ler_int : integer ;
	var 
		temp : integer ;
	begin
		write (' digite um numero : ') ;
		readln (temp) ;
		ler_int := temp ;
	end;

	function continuar : boolean ;
	var 
		op : string ;
	begin
		write ( 'quer continuar ? (S / N)' ) ;
		op := ler ;
		while ( ( op <> 'S' ) or ( op <> 's' ) ) and ( ( op <> 'N') or ( op <> 'n') ) do
		begin
			writeln ('opcao invalida') ;
			op := ler ;
		end;
		if op = 'S' then
			continuar := true 
		else 
			continuar := false ;
	end;

	{
	function maior(a , b : string):boolean;
	begin
		maior := upcase(a) > upcase(b);	
	end;
	}
	
	// Procedimentos \/  | /\ funçoes 

	procedure criar_lista ( var lista: Tlista );
	begin
		lista := nil;
	end; 

	procedure adicionar_lista(var T_lista : Tlista );
	var
		novo , anterior , atual : Tlista ;
		chave : string ;
	begin	
		chave := ler ;
		new (novo);
		if novo = nil then
			writeln ('memoria cheia') 
		else
		begin
			if T_lista = nil then
			begin
				
				novo^.ant := nil ;
				novo^.key := chave ;
				novo^.dicionario := nil ;
				novo^.prox := T_lista;
				
				T_lista := novo ;
			
			end
			
			else
			begin
				
				atual := T_lista ;
				anterior := nil ;
				
				while (atual <> nil) and (atual^.key < chave) do
				begin
					anterior := atual;
					atual := atual^.prox;
				end;
				
				novo^.ant := anterior ;
				novo^.prox := atual ;
				novo^.key := chave ;
				novo^.dicionario := nil ;
				
				if anterior <> nil then
					anterior^.prox := novo
				else
					T_lista := novo ; 

				if atual <> nil then
					atual^.ant := novo ;
				
			end;
		end; 
	end; 
		
	procedure adicionar_dicionario( var lista : Tlista );
	var
		aux_l : Tlista ;
		aux , aux_atual , aux_ant : Tverbete ;
		chave , chave_p , chave_i , op : string ;
//portugues /\      /\ inglês 
		existe : boolean ;
	begin
		writeln (' digite a chave que vc quer : ') ;
		chave := ler ;
	
		aux_l := consultar (lista , chave );

		if aux_l = nil then
		begin
			writeln ('nao exite esta chave quer adicionar ? ');
			
			if continuar then
			begin
				adicionar_lista ( lista );
				aux_l := consultar (lista , chave) ;
			end;
		end
		else
		begin
			chave_p := ler ;
			chave_i := ler ;

			new(aux);

			if aux_l^.dicionario = nil then //adicionar o primeiro verbete
				begin
					aux^.br := chave_p ;
					aux^.ing := chave_i ;
					aux^.prox := aux_l^.dicionario ;
					aux_l^.dicionario := aux ;
				end

       	    else 
       	    begin
				existe := verificar_palavra( aux_l^.dicionario , chave_p); // verificar se a palavra ja existe no dicionario

				if not existe then
				begin
					aux_ant := nil ;
					aux_atual := aux_l^.dicionario ; // apontar para o primeiro verbete do dicionario da chave

					while (aux_atual <> nil) and ( aux_atual^.br < chave_p ) do
					begin
						aux_ant := aux_atual ;
						aux_atual := aux_atual^.prox ;
					end;

					if aux_ant = nil then
					begin
					    aux^.br := chave_p;
					    aux^.ing := chave_i;
					    aux^.prox := aux_atual;
					
					    aux_l^.dicionario := aux;
					end
					else 
					begin
						aux_ant^.prox := aux ;
						aux^.br := chave_p ;
						aux^.ing := chave_i ;
						aux^.prox := aux_atual;
					end;

				end
				else
					write (' esta palavra ja existe no dicionario ') ;

			end;
		end;
	end;			
	

	procedure consultar_lista ( T_lista : Tlista );
	var 
		aux : tlista ;
		op : string ;
	begin
		write ( ' vc quer consutar quer consultar qual palavra ? ') ;
		op := ler ; 

		aux := consultar( T_lista , op );

		if aux = nil then
			writeln (' palavra nao encontrada ')
		else 
			write (' palavra encontrada :' , aux^.key );

	end;

	procedure consultar_dicionario (T_lista : Tlista );
	var 
		aux : Tlista ;
		op : string ;
	begin
	end;

	procedure menu ( var lista : Tlista );
	var 
		op : integer ;
	begin
	
		writeln (' 1 : adicionar_lista ') ;
		writeln (' 2 : adicionar_dicionario ') ;
		writeln (' 3 : consultar_lista ') ;
		writeln (' 4 : consultar_dicionario ') ;
		writeln (' 5 : consultar_geral ') ;
		writeln (' 6 : remover_lista ') ;
		writeln (' 7 : remover_dicionario ') ;
		writeln (' 0 : sair ') ;
		op := ler_int ;
		case op of 
			1 : adicionar_lista(lista) ; 
			2 :	adicionar_dicionario (lista) ;
			3 : consultar_lista (lista) ;
			4 : consultar_dicionario (lista) ;
			5 : consultar_geral (lista , dicionario) ;
			6 :
			begin
				remover_lista (lista) ;
				adicionar_dicionario (lista) ;
			end;
			7 : remover_dicionario (dicionario) ;
			0 : writeln (' vc saiu do sistema ') ;
		end
		else 
			write (' opcao invalida digite novamente : ') ;
		
	end;
var 
	lista : Tlista ;

	i : integer ;
begin
	i := 1;
	criar_lista (lista) ;
	while ( i = 1 ) do
	begin
		menu (lista);
		if not continuar then
			i := 0;
	end;
end.			
