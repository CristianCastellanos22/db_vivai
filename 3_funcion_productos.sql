-- función para crear los productos, se crearán 600 registros

CREATE OR REPLACE FUNCTION crear_productos()
RETURNS VOID AS $$

DECLARE id INTEGER;
				i INTEGER;
				nom VARCHAR;
				des VARCHAR;
				precio INTEGER;

BEGIN
	SELECT MAX(id_producto) FROM tab_productos INTO id;

	precio = 0;

	FOR i IN 1 .. 600 LOOP
		IF id IS NULL THEN
			id = 1;
		ELSE
			id = id + 1;
		END IF;

		nom = 'Producto ' || i;
		des = 'Descripción para producto ' || i;		

		IF i >= 1 AND i <= 150 THEN
			precio = precio + 1000;
			INSERT INTO tab_productos VALUES (id,nom,des,30,precio,1,CURRENT_USER,CURRENT_DATE);
		END IF;
		
		IF i > 150 AND i <= 300 THEN
			precio = precio + 1000;
			INSERT INTO tab_productos VALUES (id,nom,des,30,precio,2,CURRENT_USER,CURRENT_DATE);				
		END IF;

		IF i > 300 AND i <= 450 THEN
			precio = precio + 1000;
			INSERT INTO tab_productos VALUES (id,nom,des,30,precio,3,CURRENT_USER,CURRENT_DATE);
		END IF;

		IF i > 450 AND i <= 600 THEN
			precio = precio + 1000;
			INSERT INTO tab_productos VALUES (id,nom,des,30,precio,4,CURRENT_USER,CURRENT_DATE);
		END IF;

	END LOOP;	

END;

$$ LANGUAGE plpgsql;

--se llama a la función crear_productos para que cree 600 registros de productos
SELECT crear_productos();