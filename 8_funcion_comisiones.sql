-- función para comisiones se debe enviar 1 - 4 para los cargos y el número del catálogo

CREATE OR REPLACE FUNCTION comisiones(id_cargo INTEGER, id_campa INTEGER) RETURNS VOID AS $$

DECLARE ida INTEGER;
	idc INTEGER;
	id INTEGER;
	idz INTEGER;
	idr INTEGER;
	id_ventas INTEGER;
	id_pedido_asesor INTEGER;
	suma NUMERIC;
	asesor NUMERIC;
	nue_asesor INTEGER;
	descuento NUMERIC;
	sum_asesor NUMERIC;
	total NUMERIC;
	porcen1 INTEGER;
	porcen2 INTEGER;

BEGIN

	IF id_cargo = 1 THEN
		SELECT MAX(id_asesor) FROM tab_asesores INTO ida;

		FOR i IN 1..ida LOOP
			
			SELECT MAX(id_comision_asesor) FROM tab_comisiones_asesores INTO id;
			SELECT MAX(id_venta_asesor) FROM tab_ventas_asesores INTO id_ventas;
			SELECT tp.porcentaje FROM tab_porcentajes tp WHERE tp.id_cargo = 4 INTO porcen1;

			IF id is NULL THEN
				id = 1;
			ELSE 
				id = id +1;
			END IF;		

			select sum(dpa.valor_total) from tab_detalle_pedidos_asesores dpa, tab_encabezado_pedidos_asesores epa, 
			tab_asesores ta, tab_encabezado_catalogos ec, tab_campanas tc
			where dpa.id_encabezado_asesor = epa.id_encabezado_asesor
			and epa.id_asesor = ta.id_asesor
			and dpa.id_catalogo = ec.id_catalogo
			and ec.id_campana = tc.id_campana
			and tc.id_campana = id_campa
			and ta.id_asesor = i INTO suma;

			IF suma >= 500000 THEN
				descuento = suma * porcen1 / 100;
				INSERT INTO tab_comisiones_asesores VALUES (id,i,descuento,CURRENT_DATE,CURRENT_USER,CURRENT_DATE);
			ELSE
				INSERT INTO tab_comisiones_asesores VALUES (id,i,0,CURRENT_DATE,CURRENT_USER,CURRENT_DATE);
			END IF;

			IF id_ventas IS NULL THEN
				id_ventas = 1;
			ELSE
				id_ventas = id_ventas + 1;
			END IF;

			-- si el asesor tiene ventas >= a 1500000 por 3 meses asciende a consultor
			IF suma >= 1500000 THEN
				SELECT id_encabezado_asesor FROM tab_encabezado_pedidos_asesores WHERE id_asesor = i INTO id_pedido_asesor;
				INSERT INTO tab_ventas_asesores VALUES (id_ventas,id_pedido_asesor,suma,CURRENT_DATE,CURRENT_USER,CURRENT_DATE);
			END IF;

		END LOOP;
	END IF;	

	IF id_cargo = 2 THEN
		SELECT MAX(id_consultor) FROM tab_consultores INTO idc;
		SELECT tp.porcentaje FROM tab_porcentajes tp WHERE tp.id_cargo = 3 INTO porcen1;
		SELECT tp.porcentaje_adicional FROM tab_porcentajes tp WHERE tp.id_cargo = 3 INTO porcen2;

		FOR i IN 1..idc LOOP
			SELECT MAX(id_comision_consultor) FROM tab_comisiones_consultores INTO id;

			IF id is NULL THEN
				id = 1;
			ELSE 
				id = id +1;
			END IF;

			SELECT SUM(valor_total) FROM tab_detalle_pedidos_consultores dpc,  tab_encabezado_pedidos_consultores epc, tab_encabezado_catalogos ec, tab_campanas tc
			WHERE dpc.id_encabezado_consultor = epc.id_encabezado_consultor
			AND dpc.id_catalogo = ec.id_catalogo
			AND ec.id_campana = tc.id_campana
			AND tc.id_campana = id_campa
			AND epc.id_consultor = i INTO suma;

			select SUM(valor_total) from tab_detalle_pedidos_asesores dpa, tab_encabezado_pedidos_asesores epa, tab_asesores ta, tab_consultores tc
			where dpa.id_encabezado_asesor = epa.id_encabezado_asesor
			and epa.id_asesor = ta.id_asesor
			and ta.id_consultor = tc.id_consultor
			and ta.id_consultor = i INTO asesor;

			select COUNT(ta.id_asesor) from tab_asesores ta, tab_consultores tc
			where ta.id_consultor = tc.id_consultor
			and tc.id_consultor = i
			and ta.nuevo_asesor = TRUE INTO nue_asesor;

			-- no hay registro de ventas de asesores asignados a consultores después del id 5
			IF asesor IS NULL THEN
				asesor = 0;
			END IF;

			descuento = suma * porcen1 / 100;
			sum_asesor = asesor * porcen2 / 100;	
			total = sum_asesor + descuento;

			IF suma >= 1000000 AND nue_asesor >= 5 THEN
				INSERT INTO tab_comisiones_consultores VALUES (id,i,total,CURRENT_DATE,CURRENT_USER,CURRENT_DATE);
			ELSE
				INSERT INTO tab_comisiones_consultores VALUES (id,i,sum_asesor,CURRENT_DATE,CURRENT_USER,CURRENT_DATE);
			END IF;

		END LOOP;

	END IF;

	IF id_cargo = 3 THEN
		SELECT MAX(id_gerente_zona) FROM tab_gerentes_zonas INTO idz;
		SELECT tp.porcentaje FROM tab_porcentajes tp WHERE tp.id_cargo = 2 INTO porcen1;
		SELECT tp.porcentaje_adicional FROM tab_porcentajes tp WHERE tp.id_cargo = 2 INTO porcen2;

		FOR i IN 1..idz LOOP
			SELECT MAX(id_comision_zonas) FROM tab_comisiones_zonas INTO id;

			IF id IS NULL THEN
				id = 1;
			ELSE
				id = id +1;
			END IF;

			SELECT SUM(valor_total) FROM tab_detalle_pedidos_zonas dpz,  tab_encabezado_pedidos_zonas epz, tab_encabezado_catalogos ec, tab_campanas tc
			WHERE dpz.id_encabezado_zona = epz.id_encabezado_zona
			AND dpz.id_catalogo = ec.id_catalogo
			AND ec.id_campana = tc.id_campana
			AND tc.id_campana = id_campa
			AND epz.id_gerente_zona = i INTO suma;

			SELECT SUM(valor_total) FROM tab_detalle_pedidos_consultores dpc, tab_encabezado_pedidos_consultores epc,
			tab_consultores tc, tab_gerentes_zonas gz
			where dpc.id_encabezado_consultor = epc.id_encabezado_consultor
			and epc.id_consultor = tc.id_consultor
			and tc.id_gerente_zona = gz.id_gerente_zona
			and gz.id_gerente_zona = i INTO asesor;

			-- no hay registro de ventas de consultores asignados a gerentes después del id 5
			IF asesor IS NULL THEN
				asesor = 0;				
			END IF;

			descuento = suma * porcen1 / 100;
			sum_asesor = asesor * porcen2 / 100;
			total = descuento + sum_asesor;

			IF suma >= 2000000 THEN
				INSERT INTO tab_comisiones_zonas VALUES (id,i,total,CURRENT_DATE,CURRENT_USER,CURRENT_DATE);
			ELSE
				INSERT INTO tab_comisiones_zonas VALUES (id,i,sum_asesor,CURRENT_DATE,CURRENT_USER,CURRENT_DATE);
			END IF;

		END LOOP;
	END IF;

	IF id_cargo = 4 THEN
		SELECT MAX(id_gerente) FROM tab_gerentes_regionales INTO idr;
		SELECT tp.porcentaje FROM tab_porcentajes tp WHERE tp.id_cargo = 1 INTO porcen1;
		SELECT tp.porcentaje_adicional FROM tab_porcentajes tp WHERE tp.id_cargo = 1 INTO porcen2;

		FOR i IN 1..idr LOOP
			SELECT MAX(id_comision_regional) FROM tab_comisiones_regionales INTO id;

			IF id IS NULL THEN
				id = 1;
			ELSE
				id = id + 1;
			END IF;

			SELECT SUM(valor_total) FROM tab_detalle_pedidos_regional dpr,  tab_encabezado_pedidos_regional epr, tab_encabezado_catalogos ec, tab_campanas tc
			WHERE dpr.id_encabezado_regional = epr.id_encabezado_regional
			AND dpr.id_catalogo = ec.id_catalogo
			AND ec.id_campana = tc.id_campana
			AND tc.id_campana = id_campa
			AND epr.id_gerente = i INTO suma;

			SELECT SUM(valor_total) FROM tab_detalle_pedidos_zonas dpz, tab_encabezado_pedidos_zonas epz, tab_gerentes_zonas gz, tab_gerentes_regionales gr
			WHERE dpz.id_encabezado_zona = epz.id_encabezado_zona
			AND epz.id_gerente_zona = gz.id_gerente_zona
			AND gz.id_gerente = gr.id_gerente
			AND gz.id_gerente = i INTO asesor;

			IF asesor IS NULL THEN
				asesor = 0;				
			END IF;

			descuento = suma * porcen1 / 100;
			sum_asesor = asesor * porcen2 / 100;	
			total = sum_asesor + descuento;

			IF suma >= 4000000 THEN
				INSERT INTO tab_comisiones_regionales VALUES (id,i,total,CURRENT_DATE,CURRENT_USER,CURRENT_DATE);
			ELSE
				INSERT INTO tab_comisiones_regionales VALUES (id,i,sum_asesor,CURRENT_DATE,CURRENT_USER,CURRENT_DATE);
			END IF;

		END LOOP;
	END IF;

END;

$$ LANGUAGE plpgsql;


-- se debe enviar 1 - 4 para cargo -- id de catálogo
SELECT comisiones(1,1);
SELECT comisiones(2,1);
SELECT comisiones(3,1);
SELECT comisiones(4,1);