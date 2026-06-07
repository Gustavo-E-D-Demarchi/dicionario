program pzim;
uses crt;

type
	Tverbete = ^E_Dicionario;
	E_Dicionario = record
		br : string;
		ing : string;
		prox : Tverbete;
	end;

	Tlista = ^E_lista;
	E_lista = record
		ant : Tlista;
		key : string;
		dicionario : Tverbete;
		prox : Tlista;
	end;

function verificar_palavra ( D : Tverbete ; P : string ) : boolean ;
begin
	if D = nil then
		verificar_palavra := false
	else
	begin
		if D^.br = P then
			verificar_palavra := true
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

	if ( atual <> nil ) and ( atual^.key = chave ) then
		consultar := atual
	else
		consultar := nil ;
end;

function encontrar_lista (
	T_lista : Tlista ;
	palavra : string
	) : Tlista ;
var
	aux : Tlista ;
	melhor : Tlista ;
begin
	aux := T_lista ;
	melhor := nil ;

	while aux <> nil do
	begin
		if UpCase( palavra[1] ) >=
		   UpCase( aux^.key[1] ) then
		begin
			melhor := aux ;
		end;

		aux := aux^.prox ;
	end;

	encontrar_lista := melhor ;
end;

function ler : string ;
var
	temp : string ;
begin
	write ( ' digite a palavra : ' ) ;
	readln ( temp ) ;
	ler := temp ;
end;

function ler_int : integer ;
var
	temp : integer ;
begin
	write ( ' digite um numero : ' ) ;
	readln ( temp ) ;
	ler_int := temp ;
end;

function continuar : boolean ;
var
	op : string ;
begin
	write ( ' quer continuar ? (S / N) : ' ) ;
	readln ( op ) ;

	while ( op <> 'S' ) and ( op <> 's' ) and
			  ( op <> 'N' ) and ( op <> 'n' ) do
	begin
		writeln ( ' opcao invalida ' ) ;
		readln ( op ) ;
	end;

	if ( op = 'S' ) or ( op = 's' ) then
		continuar := true
	else
		continuar := false ;
end;

procedure criar_lista ( var lista : Tlista ) ;
begin
	lista := nil ;
end;

procedure adicionar_lista_direto (
	var T_lista : Tlista ;
	chave : string
	) ;
var
	novo , anterior , atual : Tlista ;
begin
	new ( novo ) ;

	novo^.key := chave ;
	novo^.dicionario := nil ;
	novo^.prox := nil ;
	novo^.ant := nil ;

	if T_lista = nil then
	begin
		T_lista := novo ;
	end
	else
	begin
		atual := T_lista ;
		anterior := nil ;

		while ( atual <> nil ) and ( atual^.key < chave ) do
		begin
			anterior := atual ;
			atual := atual^.prox ;
		end;

		novo^.ant := anterior ;
		novo^.prox := atual ;

		if anterior <> nil then
			anterior^.prox := novo
		else
			T_lista := novo ;

		if atual <> nil then
			atual^.ant := novo ;
	end;
end;

procedure adicionar_lista ( var T_lista : Tlista ) ;
var
	chave : string ;
begin
	chave := ler ;
	adicionar_lista_direto ( T_lista , chave ) ;
end;

procedure inserir_ordenado_dicionario (
	var dicionario : Tverbete ;
	novo : Tverbete
	) ;
var
	aux_atual , aux_ant : Tverbete ;
begin
	aux_atual := dicionario ;
	aux_ant := nil ;

	while ( aux_atual <> nil ) and
		  ( aux_atual^.br < novo^.br ) do
	begin
		aux_ant := aux_atual ;
		aux_atual := aux_atual^.prox ;
	end;

	novo^.prox := aux_atual ;

	if aux_ant = nil then
		dicionario := novo
	else
		aux_ant^.prox := novo ;
end;

procedure redistribuir_verbetes (
	var lista : Tlista
	) ;
var
	aux_l : Tlista ;
	aux_d : Tverbete ;

	todos , ultimo , prox_d : Tverbete ;

	destino : Tlista ;
begin
	todos := nil ;
	ultimo := nil ;

	aux_l := lista ;

	while aux_l <> nil do
	begin
		aux_d := aux_l^.dicionario ;

		aux_l^.dicionario := nil ;

		while aux_d <> nil do
		begin
			prox_d := aux_d^.prox ;

			aux_d^.prox := nil ;

			if todos = nil then
			begin
				todos := aux_d ;
				ultimo := aux_d ;
			end
			else
			begin
				ultimo^.prox := aux_d ;
				ultimo := aux_d ;
			end;

			aux_d := prox_d ;
		end;

		aux_l := aux_l^.prox ;
	end;

	aux_d := todos ;

	while aux_d <> nil do
	begin
		prox_d := aux_d^.prox ;

		destino := encontrar_lista (
			lista ,
			aux_d^.br
			) ;

		aux_d^.prox := nil ;

		if destino <> nil then
		begin
			inserir_ordenado_dicionario (
				destino^.dicionario ,
				aux_d
				) ;
		end;

		aux_d := prox_d ;
	end;
end;

procedure adicionar_dicionario ( var lista : Tlista ) ;
var
	aux_l : Tlista ;
	aux : Tverbete ;
	chave_p , chave_i : string ;
	existe : boolean ;
begin
	writeln ( ' digite a palavra em portugues : ' ) ;
	chave_p := ler ;

	writeln ( ' digite a traducao em ingles : ' ) ;
	chave_i := ler ;

	aux_l := encontrar_lista ( lista , chave_p ) ;

	if aux_l = nil then
	begin
		writeln ( ' nenhuma chave encontrada ' ) ;
	end
	else
	begin
		existe := verificar_palavra (
			aux_l^.dicionario ,
			chave_p
			) ;

		if existe then
		begin
			writeln ( ' palavra ja existe ' ) ;
		end
		else
		begin
			new ( aux ) ;

			aux^.br := chave_p ;
			aux^.ing := chave_i ;
			aux^.prox := nil ;

			inserir_ordenado_dicionario (
				aux_l^.dicionario ,
				aux
				) ;
		end;
	end;
end;

procedure consultar_lista ( T_lista : Tlista ) ;
var
	aux : Tlista ;
begin
	aux := T_lista ;

	if aux = nil then
	begin
		writeln ( ' lista vazia ' ) ;
	end
	else
	begin
		while aux <> nil do
		begin
			writeln ( ' chave : ' , aux^.key ) ;
			aux := aux^.prox ;
		end;
	end;
end;

procedure consultar_dicionario ( T_lista : Tlista ) ;
var
	aux_l : Tlista ;
	aux_d : Tverbete ;
	palavra : string ;
	encontrou : boolean ;
begin
	writeln ( ' digite a palavra : ' ) ;
	palavra := ler ;

	aux_l := T_lista ;
	encontrou := false ;

	while ( aux_l <> nil ) and ( not encontrou ) do
	begin
		aux_d := aux_l^.dicionario ;

		while ( aux_d <> nil ) and ( not encontrou ) do
		begin
			if aux_d^.br = palavra then
			begin
				writeln ;
				writeln ( ' chave : ' , aux_l^.key ) ;
				writeln (
					aux_d^.br ,
					' = ' ,
					aux_d^.ing
					) ;

				encontrou := true ;
			end;

			aux_d := aux_d^.prox ;
		end;

		aux_l := aux_l^.prox ;
	end;

	if not encontrou then
		writeln ( ' palavra nao encontrada ' ) ;
end;

procedure consultar_geral ( T_lista : Tlista ) ;
var
	aux_l : Tlista ;
	aux_d : Tverbete ;
begin
	aux_l := T_lista ;

	if aux_l = nil then
	begin
		writeln ( ' lista vazia ' ) ;
	end
	else
	begin
		while aux_l <> nil do
		begin
			writeln ;
			writeln ( ' chave : ' , aux_l^.key ) ;

			aux_d := aux_l^.dicionario ;

			if aux_d = nil then
			begin
				writeln ( '   dicionario vazio ' ) ;
			end
			else
			begin
				while aux_d <> nil do
				begin
					writeln (
						'   ',
						aux_d^.br ,
						' = ' ,
						aux_d^.ing
						) ;

					aux_d := aux_d^.prox ;
				end;
			end;

			aux_l := aux_l^.prox ;
		end;
	end;
end;

procedure remover_dicionario (
	T_lista : Tlista
	) ;
var
	aux_l : Tlista ;
	aux_d , ant_d : Tverbete ;
	palavra : string ;
	achou : boolean ;
begin
	writeln ( ' digite a palavra : ' ) ;
	palavra := ler ;

	aux_l := T_lista ;
	achou := false ;

	while ( aux_l <> nil ) and ( not achou ) do
	begin
		aux_d := aux_l^.dicionario ;
		ant_d := nil ;

		while ( aux_d <> nil ) and ( not achou ) do
		begin
			if aux_d^.br = palavra then
			begin
				if ant_d = nil then
					aux_l^.dicionario := aux_d^.prox
				else
					ant_d^.prox := aux_d^.prox ;

				dispose ( aux_d ) ;

				achou := true ;
			end
			else
			begin
				ant_d := aux_d ;
				aux_d := aux_d^.prox ;
			end;
		end;

		aux_l := aux_l^.prox ;
	end;

	if achou then
		writeln ( ' palavra removida ' )
	else
		writeln ( ' palavra nao encontrada ' ) ;
end;

procedure remover_lista (
	var lista : Tlista
	) ;
var
	aux , ant : Tlista ;
	chave : string ;
begin
	writeln ( ' digite a chave : ' ) ;
	chave := ler ;

	aux := lista ;
	ant := nil ;

	while ( aux <> nil ) and
		  ( aux^.key <> chave ) do
	begin
		ant := aux ;
		aux := aux^.prox ;
	end;

	if aux = nil then
	begin
		writeln ( ' chave nao encontrada ' ) ;
	end
	else
	begin
		if ant = nil then
			lista := aux^.prox
		else
			ant^.prox := aux^.prox ;

		if aux^.prox <> nil then
			aux^.prox^.ant := ant ;

		dispose ( aux ) ;

		redistribuir_verbetes ( lista ) ;

		writeln ( ' chave removida ' ) ;
	end;
end;

procedure menu ( var lista : Tlista ; var j : integer ) ;
var
	op : integer ;
begin
	writeln ;
	writeln ( ' 1 - adicionar lista ' ) ;
	writeln ( ' 2 - adicionar dicionario ' ) ;
	writeln ( ' 3 - consultar lista ' ) ;
	writeln ( ' 4 - consultar dicionario ' ) ;
	writeln ( ' 5 - consultar geral ' ) ;
	writeln ( ' 6 - remover lista ' ) ;
	writeln ( ' 7 - remover dicionario ' ) ;
	writeln ( ' 0 - sair ' ) ;

	op := ler_int ;

	case op of
		1 : adicionar_lista ( lista ) ;
		2 : adicionar_dicionario ( lista ) ;
		3 : consultar_lista ( lista ) ;
		4 : consultar_dicionario ( lista ) ;
		5 : consultar_geral ( lista ) ;
		6 : remover_lista ( lista ) ;
		7 : remover_dicionario ( lista ) ;

		0 : begin
				writeln ( ' saindo... ' ) ;
				j := 0;
			end;
		else
			writeln ( ' opcao invalida ' ) ;
	end;
end;

var
	lista : Tlista ;
	i : integer ;

begin
	i := 1 ;

	criar_lista ( lista ) ;

	while i = 1 do
	begin
		menu ( lista , i ) ;
	end;
end.
