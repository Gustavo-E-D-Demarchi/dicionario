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
		
	procedure adicionar_dicionario(dicionario : E_dicionario);
	var
		aux , aux2 : Tlista;
		chave_p , chave_i : string ;
//portugues /\      /\ inglês 
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
				if (dicionario = nil) then
					begin
						aux^.br := chave_p ;
						aux^.ing := chave_i ;
						aux^.prox := dicionario ;
						dicionario := aux ;
					end;
				aux2 := aux ;
				while (aux2 <> nil) and (aux2^.br < chave_p ) do
				begin 
					aux2 := aux2^.prox ;
					aux := aux2 ;
				end;
				if aux2 = nil then
				begin
				
				aux2^.br := chave_p ;
				aux2^.ing := chave_i ;
				
				if aux <> nil then
					aux2^.prox := aux 
				else 
					aux2^.prox := nil ;
				

				end;
			end;
					
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

	procedure menu ( var T_lista : Tlista);
	var 
		op : integer
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
		case ler_int of 
			1 : adicionar_lista ; 
			2 : adicionar_dicionario ;
			3 : consultar_lista ;
			4 : consultar_dicionario ;
			5 : consultar_geral ;
			6 : remover_lista ;
			7 : remover_dicionario ;
		end
		else if ( ) 
			write (' opcao invalida digite novamente : ');
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
