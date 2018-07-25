CREATE TABLE tab_regionales(
	id_regional						INTEGER			NOT NULL,
	nom_regional					VARCHAR(60)		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_regional)
);

CREATE TABLE tab_lineas_productos(
	id_linea						INTEGER			NOT NULL,
	nom_linea						VARCHAR(60)		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_linea)
);

CREATE TABLE tab_zonas(
	id_zona							INTEGER			NOT NULL,	
	nom_zona						VARCHAR(60)		NOT NULL,
	id_regional						INTEGER			NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_zona),
	FOREIGN KEY (id_regional) REFERENCES tab_regionales (id_regional)
);

CREATE TABLE tab_ciudades(
	id_ciudad						INTEGER			NOT NULL,	
	nom_ciudad						VARCHAR(60)		NOT NULL,
	id_zona							INTEGER			NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,	

	PRIMARY KEY (id_ciudad),
	FOREIGN KEY (id_zona) REFERENCES tab_zonas (id_zona)
);

CREATE TABLE tab_cargos(
	id_cargo 						INTEGER 		NOT NULL,
	nom_cargo 						VARCHAR(60) 	NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,	

	PRIMARY KEY (id_cargo)
);

CREATE TABLE tab_porcentajes(
	id_porcentaje 					INTEGER 		NOT NULL,
	id_cargo 						INTEGER 		NOT NULL,
	porcentaje 						INTEGER			NOT NULL,
	porcentaje_adicional            INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_porcentaje),
	FOREIGN KEY (id_cargo) REFERENCES tab_cargos (id_cargo)
);

CREATE TABLE tab_gerentes_regionales(
	id_gerente						INTEGER			NOT NULL,
	id_cargo 						INTEGER 		NOT NULL,
	nom_gerente						VARCHAR(60)		NOT NULL,
	apel_gerente					VARCHAR(60)		NOT NULL,
	cedula_gerente					BIGINT			NOT NULL,
	tel_gerente						BIGINT			NOT NULL,	
	direc_gerente					VARCHAR(60)		NOT NULL,	
	email_gerente					VARCHAR(60)		NOT NULL,
	id_regional						INTEGER			NOT NULL,
	id_zona 						INTEGER 		NOT NULL,
	id_ciudad 						INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_gerente),
	FOREIGN KEY (id_cargo) REFERENCES tab_cargos (id_cargo),
	FOREIGN KEY (id_regional) REFERENCES tab_regionales (id_regional),
	FOREIGN KEY (id_zona) REFERENCES tab_zonas (id_zona),
	FOREIGN KEY (id_ciudad) REFERENCES tab_ciudades (id_ciudad)
);

CREATE TABLE tab_gerentes_zonas(
	id_gerente_zona					INTEGER			NOT NULL,
	id_cargo 						INTEGER    		NOT NULL,
	nom_gerente_zona				VARCHAR(60)		NOT NULL,
	apel_gerente_zona				VARCHAR(60)		NOT NULL,
	cedula_gerente_zona				BIGINT			NOT NULL,
	tel_gerente_zona				BIGINT			NOT NULL,	
	direc_gerente_zona				VARCHAR(60)		NOT NULL,	
	email_gerente_zona				VARCHAR(60)		NOT NULL,
	id_gerente 						INTEGER			NOT NULL,
	id_regional						INTEGER			NOT NULL,
	id_zona 						INTEGER 		NOT NULL,
	id_ciudad 						INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_gerente_zona),
	FOREIGN KEY (id_cargo) REFERENCES tab_cargos (id_cargo),
	FOREIGN KEY (id_gerente) REFERENCES tab_gerentes_regionales (id_gerente),
	FOREIGN KEY (id_regional) REFERENCES tab_regionales (id_regional),
	FOREIGN KEY (id_zona) REFERENCES tab_zonas (id_zona),
	FOREIGN KEY (id_ciudad) REFERENCES tab_ciudades (id_ciudad)
);

CREATE TABLE tab_consultores(
	id_consultor					INTEGER			NOT NULL,
	id_cargo 						INTEGER 		NOT NULL,
	nom_consultor					VARCHAR(60)		NOT NULL,
	apel_consultor					VARCHAR(60)		NOT NULL,
	cedula_consultor				BIGINT			NOT NULL,
	tel_consultor					BIGINT			NOT NULL,	
	direc_consultor					VARCHAR(60)		NOT NULL,	
	email_consultor					VARCHAR(60)		NOT NULL,
	id_gerente_zona 				INTEGER 		NOT NULL,
	id_regional						INTEGER			NOT NULL,
	id_zona 						INTEGER 		NOT NULL,
	id_ciudad 						INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_consultor),
	FOREIGN KEY (id_cargo) REFERENCES tab_cargos (id_cargo),
	FOREIGN KEY (id_gerente_zona) REFERENCES tab_gerentes_zonas (id_gerente_zona),
	FOREIGN KEY (id_regional) REFERENCES tab_regionales (id_regional),
	FOREIGN KEY (id_zona) REFERENCES tab_zonas (id_zona),
	FOREIGN KEY (id_ciudad) REFERENCES tab_ciudades (id_ciudad)
);

CREATE TABLE tab_asesores(
	id_asesor						INTEGER			NOT NULL,
	id_cargo 						INTEGER 		NOT NULL,
	nom_asesor						VARCHAR(60)		NOT NULL,
	apel_asesor						VARCHAR(60)		NOT NULL,
	cedula_asesor					BIGINT			NOT NULL,
	tel_asesor						BIGINT			NOT NULL,
	direc_asesor					VARCHAR(60)		NOT NULL,
	email_asesor					VARCHAR(60)		NOT NULL,
	nuevo_asesor					BOOLEAN			NOT NULL,
	id_consultor 					INTEGER 		NOT NULL,
	id_regional						INTEGER			NOT NULL,
	id_zona 						INTEGER 		NOT NULL,
	id_ciudad 						INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	ascenso							BOOLEAN,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_asesor),
	FOREIGN KEY (id_cargo) REFERENCES tab_cargos (id_cargo),
	FOREIGN KEY (id_consultor) REFERENCES tab_consultores (id_consultor),
	FOREIGN KEY (id_regional) REFERENCES tab_regionales (id_regional),
	FOREIGN KEY (id_zona) REFERENCES tab_zonas (id_zona),
	FOREIGN KEY (id_ciudad) REFERENCES tab_ciudades (id_ciudad)
);

CREATE TABLE tab_productos(
	id_producto 					INTEGER 		NOT NULL,
	nom_producto					VARCHAR(60)		NOT NULL,
	descrip_producto				VARCHAR(60)		NOT NULL,
	cantidad_producto				INTEGER			NOT NULL,
	precio_producto					BIGINT	 		NOT NULL,
	id_linea_producto				INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_producto),
	FOREIGN KEY (id_linea_producto) REFERENCES tab_lineas_productos (id_linea)
);

CREATE TABLE tab_campanas(
	id_campana						INTEGER 		NOT NULL,
	nom_campana						VARCHAR(60)		NOT NULL,
	fec_inicio						TIMESTAMP 		NOT NULL,
	fec_fin							TIMESTAMP 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_campana)

);

CREATE TABLE tab_encabezado_catalogos(
	id_catalogo						INTEGER			NOT NULL,
	nom_catalogo					VARCHAR(60)		NOT NULL,	
	fec_inicio						TIMESTAMP 		NOT NULL,
	fec_fin							TIMESTAMP 		NOT NULL,
	id_campana						INTEGER    		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_catalogo),
	FOREIGN KEY (id_campana) REFERENCES tab_campanas (id_campana)
);

CREATE TABLE tab_detalle_catalogos(
	id_detalle_catalogo 			INTEGER			NOT NULL,
	id_producto 					INTEGER			NOT NULL,
	id_catalogo 					INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_detalle_catalogo),
	FOREIGN KEY (id_producto) REFERENCES tab_productos (id_producto),
	FOREIGN KEY (id_catalogo) REFERENCES tab_encabezado_catalogos (id_catalogo)
);


CREATE TABLE tab_encabezado_pedidos_asesores(
	id_encabezado_asesor			INTEGER 		NOT NULL,
	fec_pedido						TIMESTAMP 		NOT NULL,
	id_asesor 						INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_encabezado_asesor),
	FOREIGN KEY (id_asesor) REFERENCES tab_asesores (id_asesor)
);

CREATE TABLE tab_detalle_pedidos_asesores(
	id_detalle_asesor				INTEGER			NOT NULL,
	id_catalogo 					INTEGER 		NOT NULL,
	id_producto 					INTEGER 		NOT NULL,
	cantidad_producto 				INTEGER 		NOT NULL,
	valor_unitario 					BIGINT 			NOT NULL,
	valor_total						BIGINT 			NOT NULL,
	id_encabezado_asesor 			INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_detalle_asesor),
	FOREIGN KEY (id_catalogo) REFERENCES tab_encabezado_catalogos (id_catalogo),
	FOREIGN KEY (id_producto) REFERENCES tab_productos (id_producto),
	FOREIGN KEY (id_encabezado_asesor) REFERENCES tab_encabezado_pedidos_asesores (id_encabezado_asesor)
);

CREATE TABLE tab_encabezado_pedidos_consultores(
	id_encabezado_consultor			INTEGER 		NOT NULL,
	fec_pedido						TIMESTAMP 		NOT NULL,
	id_consultor 					INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_encabezado_consultor),
	FOREIGN KEY (id_consultor) REFERENCES tab_consultores (id_consultor)
);

CREATE TABLE tab_detalle_pedidos_consultores(
	id_detalle_consultor			INTEGER			NOT NULL,
	id_catalogo 					INTEGER 		NOT NULL,
	id_producto 					INTEGER 		NOT NULL,
	cantidad_producto 				INTEGER 		NOT NULL,
	valor_unitario 					BIGINT 			NOT NULL,
	valor_total						BIGINT 			NOT NULL,
	id_encabezado_consultor			INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_detalle_consultor),
	FOREIGN KEY (id_catalogo) REFERENCES tab_encabezado_catalogos (id_catalogo),
	FOREIGN KEY (id_producto) REFERENCES tab_productos (id_producto),
	FOREIGN KEY (id_encabezado_consultor) REFERENCES tab_encabezado_pedidos_consultores (id_encabezado_consultor)
);

CREATE TABLE tab_encabezado_pedidos_zonas(
	id_encabezado_zona				INTEGER 		NOT NULL,
	fec_pedido						TIMESTAMP 		NOT NULL,
	id_gerente_zona 				INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_encabezado_zona),
	FOREIGN KEY (id_gerente_zona) REFERENCES tab_gerentes_zonas (id_gerente_zona)
);

CREATE TABLE tab_detalle_pedidos_zonas(
	id_detalle_zona					INTEGER			NOT NULL,
	id_catalogo 					INTEGER 		NOT NULL,
	id_producto 					INTEGER 		NOT NULL,
	cantidad_producto 				INTEGER 		NOT NULL,
	valor_unitario 					BIGINT 			NOT NULL,
	valor_total						BIGINT 			NOT NULL,
	id_encabezado_zona				INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_detalle_zona),
	FOREIGN KEY (id_catalogo) REFERENCES tab_encabezado_catalogos (id_catalogo),
	FOREIGN KEY (id_producto) REFERENCES tab_productos (id_producto),
	FOREIGN KEY (id_encabezado_zona) REFERENCES tab_encabezado_pedidos_zonas (id_encabezado_zona)
);

CREATE TABLE tab_encabezado_pedidos_regional(
	id_encabezado_regional			INTEGER 		NOT NULL,
	fec_pedido						TIMESTAMP 		NOT NULL,
	id_gerente 						INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_encabezado_regional),
	FOREIGN	KEY (id_gerente) REFERENCES tab_gerentes_regionales (id_gerente)
);

CREATE TABLE tab_detalle_pedidos_regional(
	id_detalle_regional				INTEGER			NOT NULL,
	id_catalogo 					INTEGER 		NOT NULL,
	id_producto 					INTEGER 		NOT NULL,
	cantidad_producto 				INTEGER 		NOT NULL,
	valor_unitario 					BIGINT 			NOT NULL,
	valor_total						BIGINT 			NOT NULL,
	id_encabezado_regional			INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_detalle_regional),
	FOREIGN KEY (id_catalogo) REFERENCES tab_encabezado_catalogos (id_catalogo),
	FOREIGN KEY (id_producto) REFERENCES tab_productos (id_producto),
	FOREIGN KEY (id_encabezado_regional) REFERENCES tab_encabezado_pedidos_regional (id_encabezado_regional)
);

CREATE TABLE tab_descuentos_asesores(
	id_descuento					INTEGER 		NOT NULL,
	tipo_descuento					VARCHAR(50)		NOT NULL,
	id_asesor 						INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_descuento),
	FOREIGN KEY (id_asesor) REFERENCES tab_asesores (id_asesor)
);

CREATE TABLE tab_descuentos_consultores(
	id_descuento					INTEGER 		NOT NULL,
	tipo_descuento					VARCHAR(50)		NOT NULL,
	id_consultor 					INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_descuento),
	FOREIGN KEY (id_consultor) REFERENCES tab_consultores (id_consultor)
);

CREATE TABLE tab_descuentos_zonas(
	id_descuento 					INTEGER 		NOT NULL,
	tipo_descuento					VARCHAR(50)		NOT NULL,
	id_gerente_zona 				INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_descuento),
	FOREIGN KEY (id_gerente_zona) REFERENCES tab_gerentes_zonas (id_gerente_zona)
);

CREATE TABLE tab_descuentos_regional(
	id_descuento					INTEGER 		NOT NULL,
	tipo_descuento					VARCHAR(50)		NOT NULL,
	id_gerente 						INTEGER 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_descuento),
	FOREIGN KEY (id_gerente) REFERENCES tab_gerentes_regionales (id_gerente)
);

CREATE TABLE tab_comisiones_asesores(
	id_comision_asesor				INTEGER 		NOT NULL,
	id_asesor 						INTEGER 		NOT NULL,
	monto_comision 					INTEGER 		NOT NULL,
	fecha_comision 					TIMESTAMP		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_comision_asesor),
	FOREIGN KEY (id_asesor) REFERENCES tab_asesores (id_asesor)
);

CREATE TABLE tab_comisiones_consultores(
	id_comision_consultor			INTEGER 		NOT NULL,
	id_consultor 					INTEGER 		NOT NULL,
	monto_comision 					INTEGER 		NOT NULL,
	fecha_comision 					TIMESTAMP 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_comision_consultor),
	FOREIGN KEY (id_consultor) REFERENCES tab_consultores (id_consultor)
);

CREATE TABLE tab_comisiones_zonas(
	id_comision_zonas				INTEGER 		NOT NULL,
	id_gerente_zona					INTEGER 		NOT NULL,
	monto_comision 					INTEGER 		NOT NULL,
	fecha_comision 					TIMESTAMP 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_comision_zonas),
	FOREIGN KEY (id_gerente_zona) REFERENCES tab_gerentes_zonas (id_gerente_zona)
);

CREATE TABLE tab_comisiones_regionales(
	id_comision_regional			INTEGER 		NOT NULL,
	id_gerente 	 					INTEGER 		NOT NULL,
	monto_comision 					NUMERIC(12,0)	NOT NULL,
	fecha_comision 					TIMESTAMP		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_comision_regional),
	FOREIGN KEY (id_gerente) REFERENCES tab_gerentes_regionales (id_gerente)
);

CREATE TABLE tab_ventas_asesores(
	id_venta_asesor 				INTEGER 		NOT NULL,
	id_encabezado_asesor			INTEGER 		NOT NULL,
	monto_venta_asesor				INTEGER 		NOT NULL,
	fec_venta_asesor				TIMESTAMP 		NOT NULL,
	usr_insert      				VARCHAR(20) 	NOT NULL,
	fec_insert       				TIMESTAMP 		NOT NULL,
	usr_update      				VARCHAR(20),
	fec_update      				TIMESTAMP,

	PRIMARY KEY (id_venta_asesor),
	FOREIGN KEY (id_encabezado_asesor) REFERENCES tab_encabezado_pedidos_asesores (id_encabezado_asesor)
);