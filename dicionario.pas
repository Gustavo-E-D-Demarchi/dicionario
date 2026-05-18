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

   	
	{
	function maior(a , b : string):boolean;
	begin
		maior := upcase(a) > upcase(b);	
	end;
	}
	{ JULGAMENTO: comparacao esta comentada; se a ordenacao precisar disso, tem que reativar }
	procedure criar_lista ( var lista: Tlista );
	begin
		lista := nil;
	end;

	procedure adicionar_lista(var T_lista : Tlista );
	var
		novo , anterior , atual : Tlista ;
		chave : string ;
	begin
		chave := ler();

		new (novo);
		if novo = nil then
			writeln ('memoria cheia')
		else
		begin
			if T_lista = nil then
			begin
				novo^.key := chave ;
				novo^.dicionario := nil;
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

				// JULGAMENTO: comparacao eh case-sensitive; se quiser alfabetico "padrao", precisa normalizar
				novo^.ant := anterior ;
				novo^.prox := atual ;
				novo^.key := chave ;
				novo^.dicionario := nil;
				if anterior <> nil then
					anterior^.prox := novo
				else
					T_lista := novo ;

				if atual <> nil then
					atual^.ant := novo ;
			end;
		end;
	end;


	procedure adicionar_dicionario(var dicionario : Tverbete);
	var
		aux, aux2, anterior : Tverbete;
		chave_p , chave_i : string ;
		//portugues /\      /\ inglês
	begin
		chave_p := ler() ;
		chave_i := ler() ;
			new(aux);
			if aux = nil then
				begin
					writeln ('memoria cheia') ;
				end
			else
			begin
				aux^.br := chave_p ;
				aux^.ing := chave_i ;
				aux^.prox := nil ;

				if (dicionario = nil) then
				begin
					dicionario := aux ;
					exit;
				end;

				anterior := nil;
				aux2 := dicionario ;
				while (aux2 <> nil) and (aux2^.br < chave_p ) do
				begin
					anterior := aux2;
					aux2 := aux2^.prox ;
				end;

				if anterior = nil then
				begin
					aux^.prox := dicionario;
					dicionario := aux;
				end
				else
				begin
					aux^.prox := aux2;
					anterior^.prox := aux;
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

		if ( atual <> nil ) and ( atual ^.key = chave) then
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
		// TODO: consultar palavra dentro do dicionario da chave
	end;

	procedure consultar_geral(T_lista : Tlista);
	begin
		// TODO: listar todo o dicionario
	end;

	procedure remover_lista(var T_lista : Tlista);
	begin
		// TODO: remover chave da lista principal
	end;

	procedure remover_dicionario(var T_lista : Tlista);
	begin
		// TODO: remover verbete do dicionario
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


	procedure menu ( var T_lista : Tlista);
	var
		op : integer;
		chave : string;
		aux : Tlista;
	begin
		writeln (' 1 : adicionar_lista ') ;
		writeln (' 2 : adicionar_dicionario ') ;
		writeln (' 3 : consultar_lista ') ;
		writeln (' 4 : consultar_dicionario ') ;
		writeln (' 5 : consultar_geral ');
		writeln (' 6 : remover_lista ');
		writeln (' 7 : remover_dicionario ');
		writeln (' 0 : sair ');
		op := ler_int ;
		case op of
			1 : adicionar_lista (T_lista);
			2 : begin
					chave := ler();
					aux := consultar(T_lista, chave);
					if aux = nil then
						writeln (' chave nao encontrada ')
					else
						adicionar_dicionario(aux^.dicionario);
				end;
			3 : consultar_lista (T_lista);
			4 : consultar_dicionario (T_lista);
			5 : consultar_geral (T_lista);
			6 : remover_lista (T_lista);
			7 : remover_dicionario (T_lista);
			0 : exit;
		else
			writeln (' opcao invalida digite novamente : ');
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