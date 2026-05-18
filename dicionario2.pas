program pzim;
uses crt;

const
	DEBUG_ATIVO = true;

	type
		Tverbete = ^E_Dicionario;
		E_Dicionario = record
			br : string; // portugues
			ing : string; // ingles
			prox : Tverbete;
		end; 
	
		Tlista = ^E_lista ;
		E_lista = record 
			ant : Tlista ; // anterior
			key : string;
			dicionario : Tverbete ;
			prox : Tlista ;
		end;

	procedure Debug(const msg : string);
	begin
		if DEBUG_ATIVO then
			writeln('[debug] ', msg);
	end;

	function ler_prompt(const msg : string) : string ;
	var
		temp : string ;
	begin
		write (msg) ;
		readln( temp ) ;
		Debug('entrada = "' + temp + '"');
		ler_prompt := temp ;
	end;


	function ler_int : integer ;
	var
		temp : integer ;
	begin
		write (' digite um numero : ') ;
		readln (temp) ;
		if DEBUG_ATIVO then
			writeln('[debug] entrada numero = ', temp);
		ler_int := temp ;
	end;

	function CompareCI(const a, b : string) : integer;
	var
		aa, bb : string;
	begin
		aa := upcase(a);
		bb := upcase(b);
		if aa < bb then
			CompareCI := -1
		else if aa > bb then
			CompareCI := 1
		else
			CompareCI := 0;
	end;

	procedure criar_lista ( var lista: Tlista );
	begin
		lista := nil;
	end;

	procedure adicionar_lista(var T_lista : Tlista );
	var
		novo , anterior , atual : Tlista ;
		chave : string ;
	begin
		chave := ler_prompt(' digite a chave :');
		Debug('adicionar_lista chave="' + chave + '"');

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
				Debug('adicionar_lista inseriu no inicio');
			end

			else
			begin
				atual := T_lista ;
				anterior := nil ;

				while (atual <> nil) and (CompareCI(atual^.key, chave) < 0) do
				begin
					anterior := atual;
					atual := atual^.prox;
				end;

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
				Debug('adicionar_lista inseriu no meio/fim');
			end;
		end;
	end;


	procedure adicionar_dicionario(var dicionario : Tverbete);
	var
		aux, aux2, anterior : Tverbete;
		chave_p , chave_i : string ;
		// portugues /\      /\ ingles
	begin
		chave_p := ler_prompt(' digite a palavra em portugues :');
		chave_i := ler_prompt(' digite a traducao em ingles :');
		Debug('adicionar_dicionario br="' + chave_p + '" ing="' + chave_i + '"');
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
				Debug('adicionar_dicionario inseriu no inicio');
			end
            else // se o dicionario ja tiver verbetes, tem que inserir ordenado
            begin
		    	anterior := nil;
		    	aux2 := dicionario ;
		    	while (aux2 <> nil) and (CompareCI(aux2^.br, chave_p) < 0) do
		    	begin
		    		anterior := aux2;
		    		aux2 := aux2^.prox ;
		    	end;

		    	if anterior = nil then
		    	begin
		    		aux^.prox := dicionario;
		    		dicionario := aux;
		    		Debug('adicionar_dicionario inseriu no inicio (ordenado)');
		    	end
		    	else
		    	begin
		    		aux^.prox := aux2;
		    		anterior^.prox := aux;
		    		Debug('adicionar_dicionario inseriu no meio/fim');
		    	end;
            end;
		end;
	end;


	function consultar ( T_lista : Tlista ; chave : string ) : Tlista ;
	var
		atual : Tlista ;
	begin
		atual := T_lista ;

		while ( atual <> nil ) and ( CompareCI(atual^.key, chave) < 0 ) do
			atual := atual^.prox ;

		if ( atual <> nil ) and ( CompareCI(atual^.key, chave) = 0 ) then
			consultar := atual
		else
			consultar := nil ;
	end;


	procedure consultar_lista ( T_lista : Tlista );
	var
		aux : tlista ;
		op : string ;
	begin
		op := ler_prompt(' qual chave deseja consultar ? ') ;
		Debug('consultar_lista chave="' + op + '"');

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
			write ( 'quer continuar ? (S / N) ' ) ;
			readln(op);
			while (op = '') or ((UpCase(op[1]) <> 'S') and (UpCase(op[1]) <> 'N')) do
			begin
				writeln ('opcao invalida') ;
				write ( ' quer continuar ? (S / N) ' ) ;
				readln(op);
			end;
			if UpCase(op[1]) = 'S' then
				continuar := true 
			else 
				continuar := false ;

			if DEBUG_ATIVO then
				writeln('[debug] continuar = ', continuar);
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
		if DEBUG_ATIVO then
			writeln('[debug] menu opcao = ', op);
		case op of
			1 : adicionar_lista (T_lista);
			2 : begin
					chave := ler_prompt(' digite a chave :');
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
