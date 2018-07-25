--- función para ascenso de un asesor  -- se debe ingresar el id del asesor que va a ascender, para saber cual id usar se debe hacer una consulta a la tabla tab_ventas_asesores
CREATE OR REPLACE FUNCTION ascenso_asesor(id_ase INTEGER) RETURNS VOID AS $$

DECLARE id INTEGER;	
		cur_ase REFCURSOR;
		rec_ase RECORD;
		nom_consultor VARCHAR;	
		apel_consultor VARCHAR;
		cedula_consultor BIGINT;
		tel_consultor BIGINT;
		direc_consultor VARCHAR;
		email_consultor VARCHAR;
		id_gerente_zona INTEGER;
		id_regional INTEGER;
		id_zona INTEGER;
		id_ciudad INTEGER;


BEGIN

	OPEN cur_ase FOR SELECT nom_asesor,apel_asesor,cedula_asesor,tel_asesor,direc_asesor,email_asesor,id_consultor,ta.id_regional,ta.id_zona,ta.id_ciudad 
			FROM tab_asesores ta
			WHERE id_asesor = id_ase;

		IF NOT FOUND THEN
			RAISE NOTICE 'No se encontro registros en la tabla productos';
		END IF;

		FETCH cur_ase INTO rec_ase;

		WHILE FOUND LOOP

			SELECT MAX(id_consultor) FROM tab_consultores INTO id;

			IF id IS NULL THEN
				id = 1;
			ELSE
				id = id +1;
			END IF;

			nom_consultor = rec_ase.nom_asesor;
			apel_consultor = rec_ase.apel_asesor;
			cedula_consultor = rec_ase.cedula_asesor;
			tel_consultor = rec_ase.tel_asesor;
			direc_consultor = rec_ase.direc_asesor;
			email_consultor = rec_ase.email_asesor;
			id_gerente_zona = rec_ase.id_consultor;
			id_regional = rec_ase.id_regional;
			id_zona = rec_ase.id_zona;
			id_ciudad =rec_ase.id_ciudad;

			INSERT INTO tab_consultores VALUES (id,nom_consultor,apel_consultor,cedula_consultor,tel_consultor,direc_consultor,email_consultor,id_gerente_zona,id_regional,id_zona,id_ciudad,CURRENT_USER,CURRENT_DATE);

			UPDATE tab_asesores SET ascenso = TRUE  WHERE id_asesor = id_ase;

			FETCH cur_ase INTO rec_ase;
		END LOOP;
	CLOSE cur_ase;

END;

$$ LANGUAGE plpgsql;

---- se debe ingresar el id del asesor que va a ascender, para saber cual id usar se debe hacer una consulta a la tabla tab_ventas_asesores

--SELECT ascenso_asesor();