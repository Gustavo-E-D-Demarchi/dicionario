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
		if D^.br < P then
			verificar_palavra := true 
		else if D^.prox <> nil then
			sair := false
			else 
			sair := true 

		if sair then
			verificar_palavra := false 
		else 
			verificar_palavra( D^.prox , P );
	end;


	function consultar ( T_lista : Tlista ; chave : string ) : Tlista ;
	var 
		atual : Tlista ;
	begin
		atual := T_lista ;

		while ( atual <> nil ) and ( atual^.key < chave ) do
			atual := atual^.prox ;
		
		if ( atual <> nil ) and ( atual ^.key = chave)
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

	function continuar ( num : integer ) : boolean ;
	var 
		op : string ;
	begin
		if num = 1 then
			continuar := true 
		else 
		begin
			write ( 'quer continuar ? (S / N)' ) ;
			op := ler ;
			while ( op <> 'S' ) and ( op <> 'N') do
			begin
				writeln ('opcao invalida') ;
				op := ler ;
			end;
			if op = 'S' then
				continuar := true 
			else 
				continuar := false ;
		end;
	end;

	{
	function maior(a , b : string):boolean;
	begin
		maior := upcase(a) > upcase(b);	
	end;
	}
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
				
				novo^.key := chave ;
				novo^.prox := T_lista;
				novo^.ant := nil ;
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
				
				if anterior <> nil then
					anterior^.prox := novo
				else
					T_lista := novo ; 

				if atual <> nil then
					atual^.ant := novo ;
				
			end;
		end; 
	end; 
		
	procedure adicionar_dicionario( var dicionario : Tverbete );
	var
		aux , aux_atual , aux_ant : Tverbete ;
		chave_p , chave_i : string ;
//portugues /\      /\ inglês 
		existe : boolean ;
	begin
		chave_p := ler ;
		chave_i := ler ;
		new(aux);
		if aux = nil then
			begin
				writeln ('memoria cheia') ;
			end
		else
		begin
		aux := dicionario ;
			if (aux = nil) then //adicionar o primeiro verbete
				begin
					aux^.br := chave_p ;
					aux^.ing := chave_i ;
					aux^.prox := dicionario ;
					dicionario := aux ;
				end
            else 
            begin
				aux_ant := nil ;
				aux_atual := aux ;
				while (aux_atual <> nil) and ( aux_atual^.br < chave_p ) do
				begin
					aux_ant := aux_atual ;
					aux_atual := aux_atual^.prox ;
				end;
				
				existe := verificar_palavra( aux , chave_p); // verificar se a palavra ja existe no dicionario
				
				if not existe then
				begin
					if aux_ant = nil then
					begin
						aux^.br := chave_p ;
						aux^.ing := chave_i ;
						aux^.prox := aux_atual ;
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
					write (' esta palavra ja existe no dicionario ')

			end;
		end;
				
	end;

	procedure adicionar_dicionario_lista (L , D) ;
	var
	begin
		while (l <> nil) and (l^.dicionario < d) do 
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

	procedure menu ( var lista : Tlista ; var dicionario : Tverbete);
	var 
		op : integer ;
	begin
	
		writeln (' 1 : adicionar_lista ') ;
		writeln (' 2 : adicionar_dicionario ') ;
		writeln (' 3 : consultar_lista ') ;
		writeln (' 4 : consultar_dicionario ') ;
		writeln (' 5 : consultar_geral ')
		writeln (' 6 : remover_lista ');
		writeln (' 7 : remover_dicionario ');
		writeln (' 0 : sair ');
		op := ler_int ;
		case op of 
			1 : adicionar_lista(lista) ; 
			2 :
			begin
				adicionar_dicionario (dicionario) ;
				adicionar_dicionario_lista (lista , dicionario)
			end;
			3 : consultar_lista (lista) ;
			4 : consultar_dicionario (dicionario) ;
			5 : consultar_geral (lista , dicionario) ;
			6 :
			begin
				remover_lista (lista) ;
				adicionar_dicionario_lista (lista , dicionario) ;
			end;
			7 : remover_dicionario (dicionario) ;
		end
		else if ( ) 
			write (' opcao invalida digite novamente : ');
	end;
var 
	lista : Tlista ;

	i : integer ;
begin
	i := 1;
	criar_lista (lista) ;
	while ( continuar(i) ) do
	begin
		menu (lista);
		i := 0;
	end;
end.			
