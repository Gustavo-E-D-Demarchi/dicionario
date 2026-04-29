program pzim;
	type
		Tverbete = ^E_Dicionario;
		E_Dicionario = record
			portugues : string;
			ingles : string;
			prox : Tverbete;
		end; 
	
		Tlista = ^E_lista;
		E_lista = record ;
			ant : Tlista ; //anterior
			key : string;
			dicionario : E_dicionario ;
			prox : Tlista ;
		end;
   	
	function maior(a , b : string):boolean;
	begin
		maior := upcase(a) > upcase(b);	
	end;

	procedure criar_lista(lista: Tlista );
	begin
		lista:=nil;
	end;

	procedure adicionar_lista(var lista : Tlista ; chave : string);
	var
		aux , aux_Ant , aux_Prox : Tlista;
		temp_s : string;
	begin
		new(aux);
		if
			//memoria cheia
		else
		begin
			while aux^.prox <> nil do
				aux := aux^.prox;
			temp_s := aux^.key;

			new (aux_Ant);
			new (aux_Prox);

			if maior(temp_s , chave)then
			begin
				if aux^.ant <> nil then
					aux_Ant := aux^.ant ;
				if aux^.prox <> nil then	
					aux_Prox := aux^.prox;
				
				aux^.key := chave ;//						
				
			end;
		end;		
	end; 




procedure portugues()
		
procedure adicionar_dicionario(dicionario : E_dicionario);
var
	aux , aux2 : Tlista;
begin
		new(aux);
		if aux = nil then
			begin
				//memoria cheia
			end
		else
		begin
			if (dicionario = nil) then
				begin
					aux^.
				end;
			while aux^.prox <> nil do 
				aux := aux^.prox
			if aux^.prox = nil then
		end;
				
end;
			
begin
end.			
