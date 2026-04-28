program pzim;
	type
		ptnodo_verbete = ^E_Dicionario;
		E_Dicionario = record
			portugues : string;
			ingles : string;
			prox : ptnodo_verbete;
		end; 
	
		Lista = ^E_lista;
		E_lista = record ;
			anterior : lista ;
			palavrachave : string;
			dicionario : E_dicionario ;
			prox : lista ;
		end;
			
begin
end.			