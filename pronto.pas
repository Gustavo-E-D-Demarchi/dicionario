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



function ler : string;
var
	temp : string;
begin
	write (' digite a palavra : ');
	readln(temp);
	ler := temp;
end;

function ler_int : integer;
var
 	temp : integer;
begin
	write (' digite um numero : ');
	readln(temp);
	ler_int := temp;
end;


function buscar_verbete (D : Tverbete; P : string) : Tverbete;
begin
 	if D = nil then
  		buscar_verbete := nil
	else
	begin
		if D^.br = P then
			buscar_verbete := D
		else
		buscar_verbete := buscar_verbete(D^.prox , P);
	end;
end;


function encontrar_lista (T_lista : Tlista; palavra : string) : Tlista;
var
	aux : Tlista;
	melhor : Tlista;
begin
	aux := T_lista;
	melhor := nil;

	while aux <> nil do
	begin
		if UpCase(palavra[1]) >= UpCase(aux^.key[1]) then
		begin
			melhor := aux;
		end;
		aux := aux^.prox;
	end;
 	
	encontrar_lista := melhor; // retorna a lista pra inserir ou nil se nao achar nada, vulgo lista vazia
end;

procedure redistribuir_verbetes (var lista : Tlista; chave : string);
var
	nova : Tlista;
	ant_d , aux_d : Tverbete;
	primeira , sair : boolean;
begin
   	ant_d := nil;
 	nova := lista;
 	while (nova <> nil) and (nova^.key <> chave) do
  		nova := nova^.prox;

 	if (nova = nil) or (nova^.ant = nil) then
 	begin
  		primeira := true;
  		aux_d := nil;
 	end
 	else
 	begin
  		primeira := false;
  		aux_d := nova^.ant^.dicionario;
 	end;
    sair := false ;
    
    
  while (aux_d <> nil) and (not primeira) and (not sair) do
  begin
    if UpCase(aux_d^.br[1]) >= UpCase(nova^.key[1]) then
    begin
      if ant_d = nil then
        nova^.ant^.dicionario := nil
      else
        ant_d^.prox := nil;

      nova^.dicionario := aux_d;

      sair := true;
    end
    else
    begin
      ant_d := aux_d;
      aux_d := aux_d^.prox;
    end;
  end;
end;


procedure lista_iniciar (var lista : Tlista);
begin
	lista := nil;
end;

procedure dicionario_adicionar (var dicionario : Tverbete; br , ing : string);
var
 	novo , aux_atual , aux_ant : Tverbete;
begin
 	new (novo);

	novo^.br := br;
	novo^.ing := ing;
	novo^.prox := nil;

	aux_atual := dicionario;
	aux_ant := nil;

	while (aux_atual <> nil) and (aux_atual^.br < novo^.br) do
	begin
		aux_ant := aux_atual;
		aux_atual := aux_atual^.prox;
	end;

 	novo^.prox := aux_atual;

	if aux_ant = nil then
		dicionario := novo
	else
		aux_ant^.prox := novo;
end;

procedure dicionario_remover (var dicionario : Tverbete; palavra : string; var removido : Tverbete);
var
 	aux , ant : Tverbete;
begin
	removido := nil;
	aux := dicionario;
	ant := nil;

	while (aux <> nil) and (removido = nil) do
	begin
		if aux^.br = palavra then
		begin
			if ant = nil then
				dicionario := aux^.prox
			else
				ant^.prox := aux^.prox;

			aux^.prox := nil;
			removido := aux;
			aux := nil;
		end;

  		ant := aux;
  		aux := aux^.prox;
 	end;
end;

procedure lista_adicionar (var lista : Tlista);
var
 	novo , anterior , atual : Tlista;
 	chave:string;
begin
 	chave := ler();
 	new (novo);

	novo^.key := chave;
	novo^.dicionario := nil;
	novo^.prox := nil;
	novo^.ant := nil;

	atual := lista;
	anterior := nil;

	while (atual <> nil) and (atual^.key < chave) do
	begin
		anterior := atual;
		atual := atual^.prox;
	end;

	novo^.ant := anterior;
	novo^.prox := atual;

	if anterior <> nil then
		anterior^.prox := novo
	else
		lista := novo;

	if atual <> nil then
		atual^.ant := novo;

 	redistribuir_verbetes (lista , chave);
end;


procedure mover_verbetes_para_listas (var lista : Tlista; var origem : Tverbete);
var
 	aux_d , prox_d : Tverbete;
 	destino : Tlista;
begin
 	aux_d := origem;
 	origem := nil;

	while aux_d <> nil do
	begin
		prox_d := aux_d^.prox;
		aux_d^.prox := nil;

		destino := encontrar_lista (lista , aux_d^.br);
		
		if destino <> nil then
			dicionario_adicionar (destino^.dicionario , aux_d^.br , aux_d^.ing)
		else
			dispose (aux_d);

		aux_d := prox_d;
	end;
end;

procedure adicionar_dicionario (var lista : Tlista);
var
	aux_l : Tlista;
	chave_p , chave_i : string;
begin
	writeln(' digite a palavra em portugues : ');
	chave_p := ler;

	writeln(' digite a traducao em ingles : ');
	chave_i := ler;

	aux_l := encontrar_lista (lista , chave_p);

	if aux_l = nil then
	begin
		writeln(' nenhuma chave encontrada ');
	end
	else
	begin
		if buscar_verbete(aux_l^.dicionario, chave_p) <> nil then
			writeln(' palavra ja existe ')
		else
			dicionario_adicionar(aux_l^.dicionario, chave_p, chave_i);
	end;
end;

procedure consultar_lista (T_lista : Tlista);
var
 	aux : Tlista;
begin
 	aux := T_lista;

	if aux = nil then
	begin
		writeln(' lista vazia ');
	end
	else
	begin
		while aux <> nil do
		begin
			writeln(' chave : ' , aux^.key);
			aux := aux^.prox;
		end;
	end;
end;

procedure consultar_dicionario (T_lista : Tlista);
var
	aux_l : Tlista;
	aux_d : Tverbete;
	palavra : string;
	encontrou : boolean;
begin
	palavra := ler;

	aux_l := T_lista;
	encontrou := false;

	while (aux_l <> nil) and (not encontrou) do
	begin
		aux_d := buscar_verbete (aux_l^.dicionario , palavra);
		if aux_d <> nil then
		begin
			writeln;
			writeln(' chave : ' , aux_l^.key);
			writeln(aux_d^.br , ' = ' , aux_d^.ing);
			encontrou := true;
		end;
		aux_l := aux_l^.prox;
	end;
	
	if not encontrou then
		writeln(' palavra nao encontrada ');
end;

procedure consultar_geral (T_lista : Tlista);
var
 	aux_l : Tlista;
 	aux_d : Tverbete;
begin
	aux_l := T_lista;
	if aux_l = nil then
	begin
		wrieln(' lista vazia ');
	end
	else
	begin
		while aux_l <> nil do
		begin
			writeln;
			writeln(' chave : ' , aux_l^.key);

			aux_d := aux_l^.dicionario;

			if aux_d = nil then
			begin
				writeln(' dicionario vazio ');
			end
			else
			begin
				while aux_d <> nil do
				begin
				writeln(' ',aux_d^.br ,' = ' ,aux_d^.ing);
				aux_d := aux_d^.prox;
				end;
			end;
			aux_l := aux_l^.prox;
		end;
 end;
end;

procedure remover_dicionario (T_lista : Tlista);
var
	aux_l : Tlista;
	aux_d : Tverbete;
	palavra : string;
	achou : boolean;
begin
 	palavra := ler;

	aux_l := T_lista;
	achou := false;

while (aux_l <> nil) and (not achou) do
begin

dicionario_remover (aux_l^.dicionario , palavra , aux_d);

if aux_d <> nil then
	begin
		dispose (aux_d);
		achou := true;
	end;
aux_l := aux_l^.prox;
end;

if achou then
  	writeln(' palavra removida ')
else
	writeln(' palavra nao encontrada ');
end;	

procedure remover_lista(var lista : Tlista);
var
	aux, ant : Tlista;
	aux_d : Tverbete;
	chave : string;
begin
	writeln(' digite a chave : ');
	chave := ler;
	aux := lista;
	ant := nil;

 while (aux <> nil) and (aux^.key <> chave) do
 begin
	ant := aux;
	aux := aux^.prox;
 end;

	if aux = nil then
		writeln(' chave nao encontrada ')
	else
		begin
			if ant = nil then
				lista := aux^.prox
			else
				ant^.prox := aux^.prox;

			if aux^.prox <> nil then
				aux^.prox^.ant := ant;

				aux_d := aux^.dicionario;
				aux^.dicionario := nil;
				mover_verbetes_para_listas(lista, aux_d);
				dispose(aux);
				writeln(' chave removida ');
		end;
end;

procedure menu (var lista : Tlista; var j : integer);
var
	op : integer;
begin
		writeln;
		writeln(' 1 - adicionar lista ');
		writeln(' 2 - adicionar dicionario ');
		writeln(' 3 - consultar lista ');
		writeln(' 4 - consultar dicionario ');
		writeln(' 5 - consultar geral ');
		writeln(' 6 - remover lista ');
		writeln(' 7 - remover dicionario ');
		writeln(' 0 - sair ');

	op := ler_int;

	case op of
		1 : lista_adicionar (lista);
		2 : adicionar_dicionario (lista);
		3 : consultar_lista (lista);
		4 : consultar_dicionario (lista);
		5 : consultar_geral (lista);
		6 : remover_lista (lista);
		7 : remover_dicionario (lista);

		0 : begin
			writeln(' saindo... ');
			j := 0;
		end;
		else
			writeln(' opcao invalida ');
		end;
end;

var
	lista : Tlista;
 	i : integer;

begin
	i := 1;

	lista_iniciar (lista);

	while i = 1 do
	begin
	end;
end.
