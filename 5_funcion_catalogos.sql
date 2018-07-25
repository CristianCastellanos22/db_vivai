CREATE OR REPLACE FUNCTION crear_catalogo(cat INTEGER)
RETURNS VOID AS $$

DECLARE id INTEGER;
		cur_cat REFCURSOR;
		rec_cat RECORD;
		id_produc INTEGER;

BEGIN

	SELECT MAX(id_detalle_catalogo) FROM tab_detalle_catalogos INTO id;

	IF cat = 1 THEN
		OPEN cur_cat FOR SELECT id_producto FROM tab_productos WHERE id_producto BETWEEN 1 AND 299;
			IF NOT FOUND THEN
				RAISE NOTICE 'No se encontro registros en la tabla productos';
			END IF;

			FETCH cur_cat INTO rec_cat;

			WHILE FOUND LOOP
				IF id IS NULL THEN
					id = 1;
				ELSE
					id = id + 1;
				END IF;

				id_produc = rec_cat.id_producto;

				INSERT INTO tab_detalle_catalogos VALUES (id,id_produc,1,CURRENT_USER,CURRENT_DATE);
				FETCH cur_cat INTO rec_cat;
			END LOOP;
		CLOSE cur_cat;
	END IF;

	IF cat = 2 THEN
		OPEN cur_cat FOR SELECT id_producto FROM tab_productos WHERE id_producto BETWEEN 300 AND 600;
			IF NOT FOUND THEN
				RAISE NOTICE 'No se encontro registros en la tabla productos';
			END IF;

			FETCH cur_cat INTO rec_cat;

			WHILE FOUND LOOP
				IF id IS NULL THEN
					id = 1;
				ELSE
					id = id + 1;
				END IF;

				id_produc = rec_cat.id_producto;

				INSERT INTO tab_detalle_catalogos VALUES (id,id_produc,2,CURRENT_USER,CURRENT_DATE);
				FETCH cur_cat INTO rec_cat;
			END LOOP;
		CLOSE cur_cat;
	END IF;		
	
END;

$$ LANGUAGE plpgsql;


-- se llama la función para crear los catálogos -- se debe elegir entre dos opciones del catálogo (1-2)
SELECT crear_catalogo(1);
SELECT crear_catalogo(2);