CREATE OR REPLACE FUNCTION descuentos(id_cargo INTEGER, id_campa INTEGER)
RETURNS VOID AS $$

DECLARE ida INTEGER;
		idc INTEGER;
		idz INTEGER;
		idr INTEGER;
		suma INTEGER;

BEGIN

	IF id_cargo = 1 THEN
		SELECT MAX(id_encabezado_asesor) FROM tab_encabezado_pedidos_asesores INTO ida;

		FOR i IN 1..ida LOOP

			SELECT MAX(id_descuento) FROM tab_descuentos_asesores INTO ida;

			IF ida is NULL THEN
				ida = 1;
			ELSE
				ida = ida + 1;
			END IF;

			select sum(dpa.valor_total) from tab_detalle_pedidos_asesores dpa, tab_encabezado_pedidos_asesores epa, 
			tab_asesores ta, tab_encabezado_catalogos ec, tab_campanas tc
			where dpa.id_encabezado_asesor = epa.id_encabezado_asesor
			and epa.id_asesor = ta.id_asesor
			and dpa.id_catalogo = ec.id_catalogo
			and ec.id_campana = tc.id_campana
			and tc.id_campana = id_campa
			and ta.id_asesor = i INTO suma;

			IF suma = 150000 THEN
				INSERT INTO tab_descuentos_asesores VALUES (ida,'Bono por $40.000 para siguiente campaña',i,CURRENT_USER,CURRENT_DATE);
			END IF;
				
			IF suma > 150000 THEN
				INSERT INTO tab_descuentos_asesores VALUES (ida,'Artículo de regalo',i,CURRENT_USER,CURRENT_DATE);
			END IF;
		END LOOP;		

	END IF;

	IF id_cargo = 2 THEN
		SELECT MAX(id_encabezado_consultor) FROM tab_encabezado_pedidos_consultores INTO idc;

		FOR i IN 1..idc LOOP

			SELECT MAX(id_descuento) FROM tab_descuentos_consultores INTO idc;

			IF idc is NULL THEN
				idc = 1;
			ELSE
				idc = idc + 1;
			END IF;

			SELECT SUM(valor_total) FROM tab_detalle_pedidos_consultores dpc,  tab_encabezado_pedidos_consultores epc, tab_encabezado_catalogos ec, tab_campanas tc
			WHERE dpc.id_encabezado_consultor = epc.id_encabezado_consultor
			AND dpc.id_catalogo = ec.id_catalogo
			AND ec.id_campana = tc.id_campana
			AND tc.id_campana = id_campa
			AND epc.id_consultor = i INTO suma;

			IF suma = 150000 THEN
				INSERT INTO tab_descuentos_consultores VALUES (idc,'Bono por $40.000 para siguiente campaña',i,CURRENT_USER,CURRENT_DATE);
			END IF;
				
			IF suma > 150000 THEN
				INSERT INTO tab_descuentos_consultores VALUES (idc,'Artículo de regalo',i,CURRENT_USER,CURRENT_DATE);
			END IF;

		END LOOP;
	END IF;

	IF id_cargo = 3 THEN
		
		SELECT MAX(id_encabezado_zona) FROM tab_encabezado_pedidos_zonas INTO idz;

		FOR i IN 1..idz LOOP
			SELECT MAX(id_descuento) FROM tab_descuentos_zonas INTO idz;

			IF idz is NULL THEN
				idz = 1;
			ELSE
				idz = idz + 1;
			END IF;

			SELECT SUM(valor_total) FROM tab_detalle_pedidos_zonas dpz,  tab_encabezado_pedidos_zonas epz, tab_encabezado_catalogos ec, tab_campanas tc
			WHERE dpz.id_encabezado_zona = epz.id_encabezado_zona
			AND dpz.id_catalogo = ec.id_catalogo
			AND ec.id_campana = tc.id_campana
			AND tc.id_campana = id_campa
			AND epz.id_gerente_zona = i INTO suma;

			IF suma = 150000 THEN
				INSERT INTO tab_descuentos_zonas VALUES (idz,'Bono por $40.000 para siguiente campaña',i,CURRENT_USER,CURRENT_DATE);
			END IF;
				
			IF suma > 150000 THEN
				INSERT INTO tab_descuentos_zonas VALUES (idz,'Artículo de regalo',i,CURRENT_USER,CURRENT_DATE);
			END IF;
		END LOOP;

	END IF;

	IF id_cargo = 4 THEN
		SELECT MAX(id_encabezado_regional) FROM tab_encabezado_pedidos_regional INTO idr;

		FOR i IN 1..idr LOOP
			SELECT MAX(id_descuento) FROM tab_descuentos_regional INTO idr;

			IF idr is NULL THEN
				idr = 1;
			ELSE
				idr = idr + 1;
			END IF;

			SELECT SUM(valor_total) FROM tab_detalle_pedidos_regional dpr,  tab_encabezado_pedidos_regional epr, tab_encabezado_catalogos ec, tab_campanas tc
			WHERE dpr.id_encabezado_regional = epr.id_encabezado_regional
			AND dpr.id_catalogo = ec.id_catalogo
			AND ec.id_campana = tc.id_campana
			AND tc.id_campana = id_campa
			AND epr.id_gerente = i INTO suma;

			IF suma = 150000 THEN
				INSERT INTO tab_descuentos_regional VALUES (idr,'Bono por $40.000 para siguiente campaña',i,CURRENT_USER,CURRENT_DATE);
			END IF;
				
			IF suma > 150000 THEN
				INSERT INTO tab_descuentos_regional VALUES (idr,'Artículo de regalo',i,CURRENT_USER,CURRENT_DATE);
			END IF;
		END LOOP;	

	END IF;	

END;

$$ LANGUAGE plpgsql;

------------ se llama la función descuentos la cual genera los descuentos de cada cargo, se debe enviar dos parametros de 1 - 4 para los cargos, luego el id del catálogo

SELECT descuentos(1,1);
SELECT descuentos(2,1);
SELECT descuentos(3,1);
SELECT descuentos(4,1);