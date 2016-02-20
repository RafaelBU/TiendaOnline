-- INTEGRANTES
-- RAFAEL BUZÓN URBANO 51141979F
-- GUILLERMO ROMERO ALONSO 51121244H

DROP TABLE Clientes CASCADE CONSTRAINTS;
DROP TABLE Carrito CASCADE CONSTRAINTS;
DROP TABLE Producto CASCADE CONSTRAINTS;
DROP TABLE Cheques CASCADE CONSTRAINTS;
DROP TABLE Pedidos CASCADE CONSTRAINTS;
DROP TABLE Formado CASCADE CONSTRAINTS;
DROP TABLE Repartidores CASCADE CONSTRAINTS;
DROP TABLE Asignado CASCADE CONSTRAINTS;
DROP TABLE Zona CASCADE CONSTRAINTS;
DROP SEQUENCE secuenciaID;

create table Clientes
(Nombre VARCHAR(10)  NOT NULL, 
Apellido VARCHAR(10)  NOT NULL,
Telefono NUMBER,
Correo VARCHAR(25) CONSTRAINT correo_PK PRIMARY KEY,
NumSocio NUMBER,
NumTarjeta NUMBER  NOT NULL,
Pass VARCHAR(20)  NOT NULL,
Via VARCHAR(10)  NOT NULL,
NombreVia VARCHAR(20)  NOT NULL,
NumVia NUMBER  NOT NULL,
Piso NUMBER  NOT NULL,
Letra VARCHAR (1)  NOT NULL,
CP NUMBER  NOT NULL);

create table Producto
(CodigoBarras NUMBER PRIMARY KEY,
Descuento VARCHAR(5),
Tipo VARCHAR (10) NOT NULL,
Descripcion VARCHAR (40) NOT NULL,
Precio NUMBER NOT NULL CHECK (Precio > 0),
CHECK ((Tipo = 'Fresco' AND (Descuento = '10%' OR Descuento = '20%' OR Descuento = '50%')) OR (Tipo = 'Envasado' AND (Descuento = '3x2' OR Descuento = '2x1'))));

create table Carrito
(CorreoCliente VARCHAR (25) REFERENCES Clientes on delete cascade,
CodigoBarrasProducto NUMBER REFERENCES Producto on delete cascade,
Cantidad NUMBER NOT NULL,
CONSTRAINT carrito_PK PRIMARY KEY(CorreoCliente, CodigoBarrasProducto)
);

create table Cheques  
(NumeroCheque NUMBER,
Caducidad DATE NOT NULL,
Importe NUMBER NOT NULL,
ImporteMinimo NUMBER NOT NULL,
CorreoCliente VARCHAR (25) REFERENCES Clientes on delete cascade,
CONSTRAINT cheque_PK PRIMARY KEY (NumeroCheque, CorreoCliente)
);

create table Repartidores
(NumEmpleado NUMBER CONSTRAINT NumEmpleado_PK PRIMARY KEY
);

create table Pedidos
(IdPedido NUMBER,
Total NUMBER NOT NULL,
Fecha DATE NOT NULL,
CorreoCliente VARCHAR (25) NOT NULL REFERENCES Clientes on delete cascade,
NumEmpleado NUMBER REFERENCES Repartidores on delete cascade,
NumeroCheque NUMBER,
CONSTRAINT Pedidos_PK PRIMARY KEY (IdPedido)
);

create table Formado
(IdPedido NUMBER REFERENCES Pedidos on delete cascade,
CodigoBarrasProducto NUMBER REFERENCES Producto on delete cascade,
Cantidad NUMBER NOT NULL,
CONSTRAINT Formado_PK PRIMARY KEY (IdPedido, CodigoBarrasProducto)
);

create table Zona
(CP NUMBER CONSTRAINT CP_PK PRIMARY KEY
);

create table Asignado
(NumEmpleado NUMBER REFERENCES Repartidores on delete cascade,
CP NUMBER REFERENCES Zona on delete cascade,
CONSTRAINT Asignado_PK PRIMARY KEY (NumEmpleado, CP)
);

--Inserts con los datos
INSERT INTO Clientes VALUES('Pepe','Perez', 623456, 'correopepe@gmail.com', 001, 748596,'pass1', 'calle', 'callePepe',1, 1, 'A', 28330); 
INSERT INTO Clientes VALUES('Juan','Lopez', 678901, 'correojuan@gmail.com', 002, 418963,'pass2', 'calle', 'calleJuan',2, 2, 'B', 26550); 
INSERT INTO Clientes VALUES('Santiago','Segura', 634567, 'correosantiago@gmail.com', 003, 075946,'pass3', 'calle', 'calleSantiago',3, 3, 'C', 29730); 
INSERT INTO Clientes VALUES('Marta','Fernandez', 690123, 'correomarta@gmail.com', 004, 904589,'pass4', 'calle', 'calleMarta',4, 4, 'D', 25450); 
INSERT INTO Clientes VALUES('Laura','Gimenez', 656789, 'correolaura@gmail.com', 005, 123456,'pass5', 'calle', 'calleLaura',5, 5, 'E', 21756); 
INSERT INTO Clientes VALUES('Rafa','Buzón', 648956, 'correorafa@gmail.com', 006, 897150,'pass6', 'calle', 'calleRafa',6, 6, 'F', 20412); 
INSERT INTO Clientes VALUES('Guille','Romero', 618620, 'correoguille@gmail.com', 007, 374915,'pass7', 'calle', 'calleGuille',7, 7, 'G', 22880); 
--INSERT INTO Clientes VALUES(NOMBRE, APELLIDO, TELEFONO, CORREO, NUMSOCIO, NUMTARJETA, PASS, VIA, NOMBREVIA,NUMVIA, PISO, LETRA, CP); 

INSERT INTO Producto VALUES(147852,'50%','Fresco','Pescado fresco',20);
INSERT INTO Producto VALUES(852963,'3x2','Envasado','Empanadillas envasadas',10);
INSERT INTO Producto VALUES(789123,'10%','Fresco','Manzanas frescas',14);
INSERT INTO Producto VALUES(589654,'50%','Fresco','Ternera fresca',25);
INSERT INTO Producto VALUES(985632,'10%','Fresco','Mejillones frescos',23);
INSERT INTO Producto VALUES(478541,'2x1','Envasado','Croquetas envasadas',15);
INSERT INTO Producto VALUES(156423,'3x2','Envasado','Pizza envasada',12);
INSERT INTO Producto VALUES(189875,'10%','Fresco','Verdura fresca',10);
INSERT INTO Producto VALUES(256477,'50%','Fresco','Legumbres frescas',11);
INSERT INTO Producto VALUES(321564,'2x1','Envasado','Fabada envasada',10);
INSERT INTO Producto VALUES(452152,'3x2','Envasado','Patatas congeladas envasadas',11);
INSERT INTO Producto VALUES(360215,'2x1','Envasado','Refrescos envasados',10);
INSERT INTO Producto VALUES(021452,'50%','Fresco','Caviar fresco',60);
INSERT INTO Producto VALUES(985654,'20%','Fresco','Pulpo fresco',20);
INSERT INTO Producto VALUES(021023,'20%','Fresco','Embutido fresco',16);
--INSERT INTO Producto VALUES(CODIGOBARRAS, DESCUENTO, TIPO, DESCRIPCION, PRECIO);


INSERT INTO Carrito VALUES('correopepe@gmail.com',147852,2);
INSERT INTO Carrito VALUES('correopepe@gmail.com',452152,5);
INSERT INTO Carrito VALUES('correopepe@gmail.com',321564,3);
INSERT INTO Carrito VALUES('correopepe@gmail.com',789123,7);
INSERT INTO Carrito VALUES('correopepe@gmail.com',156423,2);
INSERT INTO Carrito VALUES('correopepe@gmail.com',985632,3);
INSERT INTO Carrito VALUES('correojuan@gmail.com',852963,4);
INSERT INTO Carrito VALUES('correojuan@gmail.com',589654,5);
INSERT INTO Carrito VALUES('correojuan@gmail.com',985632,7);
INSERT INTO Carrito VALUES('correosantiago@gmail.com',852963,7);
INSERT INTO Carrito VALUES('correosantiago@gmail.com',360215,3);
INSERT INTO Carrito VALUES('correosantiago@gmail.com',452152,6);
INSERT INTO Carrito VALUES('correomarta@gmail.com',852963,8);
INSERT INTO Carrito VALUES('correomarta@gmail.com',589654,7);
INSERT INTO Carrito VALUES('correolaura@gmail.com',156423,1);
INSERT INTO Carrito VALUES('correolaura@gmail.com',589654,4);
INSERT INTO Carrito VALUES('correolaura@gmail.com',985632,1);
INSERT INTO Carrito VALUES('correorafa@gmail.com',852963,3);
INSERT INTO Carrito VALUES('correorafa@gmail.com',021023,4);
INSERT INTO Carrito VALUES('correorafa@gmail.com',478541,7);
INSERT INTO Carrito VALUES('correorafa@gmail.com',985654,8);
INSERT INTO Carrito VALUES('correoguille@gmail.com',189875,7);
INSERT INTO Carrito VALUES('correoguille@gmail.com',256477,3);
INSERT INTO Carrito VALUES('correoguille@gmail.com',147852,6);
INSERT INTO Carrito VALUES('correoguille@gmail.com',985654,2);
--INSERT INTO Carrito VALUES(CORREO, CODIGOBARRAS, CANTIDAD);

INSERT INTO Cheques VALUES(0001,TO_DATE('01/12/2015'),10,30,'correopepe@gmail.com');
INSERT INTO Cheques VALUES(0002,TO_DATE('01/03/2015'),15,45,'correojuan@gmail.com');
INSERT INTO Cheques VALUES(0003,TO_DATE('01/03/2015'),10,45,'correojuan@gmail.com');
INSERT INTO Cheques VALUES(0003,TO_DATE('01/11/2015'),15,55,'correosantiago@gmail.com');
INSERT INTO Cheques VALUES(0004,TO_DATE('01/11/2015'),15,55,'correosantiago@gmail.com');
INSERT INTO Cheques VALUES(0003,TO_DATE('01/11/2015'),10,45,'correorafa@gmail.com');
INSERT INTO Cheques VALUES(0004,TO_DATE('01/12/2015'),20,60,'correoguille@gmail.com');
INSERT INTO Cheques VALUES(0004,TO_DATE('01/12/2015'),12,50,'correomarta@gmail.com');
INSERT INTO Cheques VALUES(0005,TO_DATE('01/01/2016'),20,60,'correolaura@gmail.com');
--INSERT INTO Cheques VALUES(NUMEROCHEQUE,CADUCIDAD,IMPORTE,IMPORTEMINIMO,CORREOCLIENTE);

INSERT INTO Repartidores VALUES(10);
INSERT INTO Repartidores VALUES(11);
INSERT INTO Repartidores VALUES(12);
INSERT INTO Repartidores VALUES(13);
INSERT INTO Repartidores VALUES(14);
INSERT INTO Repartidores VALUES(15);
INSERT INTO Repartidores VALUES(16);

INSERT INTO Zona VALUES(28330);
INSERT INTO Zona VALUES(26550);
INSERT INTO Zona VALUES(29730);
INSERT INTO Zona VALUES(25450);
INSERT INTO Zona VALUES(21756);
INSERT INTO Zona VALUES(20412);
INSERT INTO Zona VALUES(22880);

INSERT INTO Asignado VALUES(10, 28330);
INSERT INTO Asignado VALUES(10, 26550);
INSERT INTO Asignado VALUES(15, 26550);
INSERT INTO Asignado VALUES(11, 29730);
INSERT INTO Asignado VALUES(12, 25450);
INSERT INTO Asignado VALUES(13, 25450);
INSERT INTO Asignado VALUES(16, 21756);
INSERT INTO Asignado VALUES(12, 20412);
INSERT INTO Asignado VALUES(14, 22880);

CREATE SEQUENCE secuenciaID
INCREMENT BY 1
START WITH 0
MAXVALUE 2000
MINVALUE 0;
  
--Procedimientos

CREATE OR REPLACE PROCEDURE confirmarPedido(v_Correo VARCHAR2)IS
 
  existe NUMBER;
  encontrado NUMBER;
  Aplicado NUMBER := 0;
  NumeroChequeOk NUMBER := NULL;
  v_importeInicial NUMBER := 0;
  vacio NUMBER;
  v_importePedido NUMBER := 0;
  v_descuentoReal NUMBER := 0;
  v_unidadesDescuento NUMBER;
  v_resto NUMBER;
  v_idActual NUMBER;
  
  /*Creamos un cursor para poder recorrer todos los elementos del carrtio
  y poder sacar los codigos de barras y las cantidades del carrito 
  a traves del email*/
  CURSOR cursorCarrito IS
  SELECT *
  FROM Carrito join Producto on Carrito.CodigoBarrasProducto = Producto.CodigoBarras
  WHERE CorreoCliente = v_Correo;
  
  CURSOR cursorCheques IS
  SELECT *
  FROM Cheques join Clientes on Cheques.CorreoCliente = Clientes.Correo
  WHERE CorreoCliente = v_Correo and Clientes.NumSocio IS NOT NULL 
  ORDER BY NumeroCheque;
  
  CARRITO_VACIO EXCEPTION;
  
BEGIN
    DBMS_OUTPUT.PUT_LINE('INFORME DEL PEDIDO');
    DBMS_OUTPUT.PUT_LINE('----------------------------------');
    
    --Si el carrito esta vacio mostramos un error por pantalla
    SELECT count(*) INTO vacio 
    FROM Carrito
    WHERE CorreoCliente = v_Correo;
       
    IF vacio = 0 THEN
        RAISE CARRITO_VACIO;
    END IF;
       
    FOR rCarrito IN cursorCarrito LOOP
         --Vamos rellenando el informe con los datos
         DBMS_OUTPUT.PUT_LINE('Codigo de barras : ' || rCarrito.CodigoBarrasProducto );
         DBMS_OUTPUT.PUT_LINE('Descripcion : ' || rCarrito.Descripcion);
         DBMS_OUTPUT.PUT_LINE('Unidades/Peso : ' || rCarrito.Cantidad );
         DBMS_OUTPUT.PUT_LINE('----------------------------------');
         
         --Nos quedamos con el importe inicial para poder añadir un cheque regalo al cliente sobre ese importe
         v_importeInicial := v_importeInicial + (rCarrito.Precio * rCarrito.Cantidad);
         
         v_descuentoReal := CASE rCarrito.Descuento
                            WHEN '10%' THEN 0.90
                            WHEN '20%' THEN 0.80
                            WHEN '50%' THEN 0.50
                            END; 
                        
        --Calculamos el importe total teniendo en cuenta descuentos
          /*Vamos calculando el importe del pedido en cada pasada del for*/
        IF rCarrito.Descuento = '2x1' AND rCarrito.Cantidad > 2 THEN
           v_unidadesDescuento := TRUNC(rCarrito.Cantidad/2, 0);
           v_resto := MOD(rCarrito.Cantidad,2);
           v_importePedido := v_importePedido + (rCarrito.Precio * v_unidadesDescuento) + (v_resto * rCarrito.Precio);
        END IF;
           
        IF rCarrito.Descuento = '3x2' AND rCarrito.Cantidad >= 3 THEN
           v_unidadesDescuento := rCarrito.Cantidad - TRUNC(rCarrito.Cantidad/3, 0);
           v_importePedido := v_importePedido + (rCarrito.Precio * v_unidadesDescuento);
        END IF;
        
        IF rCarrito.Descuento = '2x1' AND rCarrito.Cantidad <= 2 THEN
           v_importePedido := v_importePedido + rCarrito.Precio;
        END IF;
        
        IF rCarrito.Descuento = '10%' OR rCarrito.Descuento = '20%' OR rCarrito.Descuento = '50%' THEN
           v_importePedido := v_importePedido + ( (rCarrito.Precio * rCarrito.Cantidad) * v_descuentoReal);
        END IF;
        
        IF (rCarrito.Descuento IS NULL) OR (rCarrito.Descuento = '3x2' AND rCarrito.Cantidad < 3) THEN 
           v_importePedido := v_importePedido + (rCarrito.Precio * rCarrito.Cantidad);
        END IF;
        
    END LOOP;
    
    --Comprobamos si el usuario tenia algun cheque para poder aplicarselo al final de la compra
    SELECT COUNT(*) INTO existe 
    FROM Cheques
    WHERE Cheques.CorreoCliente = v_Correo;
    
    --Hacemos un insert inicial en el pedido para poder activar el trigger(mas tarde se actualizara con todos los datos)
    INSERT INTO Pedidos VALUES(secuenciaID.NEXTVAL, v_importeInicial, SYSDATE, v_correo, NULL, NULL);
     
    --Si habia cheques le aplicaremos al pedido(el de menor numeracion del cliente) 
    FOR rCheques IN cursorCheques LOOP
    
      --Miramos si el cheque se habia aplicado a un pedido realizado previamente
      SELECT COUNT(*) INTO encontrado
      FROM Cheques
      WHERE EXISTS(SELECT NumeroCheque FROM Pedidos WHERE CorreoCliente = v_Correo AND Pedidos.NumeroCheque = rCheques.NumeroCheque);
        
      IF (existe > 0) AND (rCheques.ImporteMinimo <= v_importePedido AND rCheques.Caducidad > SYSDATE) 
          AND (Aplicado = 0) AND (encontrado < 1) THEN
        v_importePedido := v_importePedido - rCheques.Importe;
        DBMS_OUTPUT.PUT_LINE('Descuento : ' || rCheques.Importe || '€' );
        NumeroChequeOk := rCheques.NumeroCheque;
        Aplicado := 1;
      END IF;

   END LOOP;
  
  --Actualizamos el pedido con los datos finales(importe con descuentos incluidos y numero de cheque si es que hay)
  v_idActual := secuenciaID.CURRVAL;
  UPDATE Pedidos
  SET Total = v_importePedido, NumeroCheque = NumeroChequeOk
  WHERE Pedidos.IdPedido =  v_idActual;
  
  --Insertamos en la tabla Formado la informacion necesaria para relacionar los productos con el pedido
  INSERT INTO Formado 
  SELECT IdPedido, CodigoBarras, Cantidad 
  FROM Pedidos, Producto, Carrito
  WHERE Carrito.CorreoCliente = v_Correo AND Carrito.CodigoBarrasProducto = Producto.CodigoBarras AND Pedidos.IdPedido = v_idActual;
    
  --Vaciamos el carrito
  DELETE
  FROM Carrito WHERE CorreoCliente = v_Correo;
  
  --Emitimos el importe total del pedido
  DBMS_OUTPUT.PUT_LINE('Importe : ' || v_importePedido || ' €' );
  
  EXCEPTION
    WHEN CARRITO_VACIO THEN  
      DBMS_OUTPUT.PUT_LINE('El carrito está vacio y no se puede procesar el pedido');
END;

/
CREATE OR REPLACE PROCEDURE pedidosPendientes IS

  aux NUMBER := -1;
  
  CURSOR cursorEmpleados IS
  SELECT Asignado.NumEmpleado, Clientes.Correo, IdPedido, Total, Fecha , CorreoCliente, Pedidos.NumeroCheque
  FROM Asignado, Clientes, Pedidos
  WHERE Asignado.CP = Clientes.CP AND Pedidos.CorreoCliente = Clientes.Correo AND Pedidos.NumEmpleado IS NULL
  ORDER BY IdPedido;
  
BEGIN
  DBMS_OUTPUT.PUT_LINE('PEDIDOS PENDIENTES');
  DBMS_OUTPUT.PUT_LINE('----------------------------------');
  
  FOR rEmpleados IN cursorEmpleados LOOP
    --Mostramos informacion sobre los pedidos pendientes
    IF aux != rEmpleados.IdPedido THEN
      DBMS_OUTPUT.PUT_LINE(' ');
      DBMS_OUTPUT.PUT_LINE('ID del pedido : ' || rEmpleados.IdPedido);
      DBMS_OUTPUT.PUT_LINE('Importe total : ' || rEmpleados.Total || ' €');
      DBMS_OUTPUT.PUT_LINE('Fecha : ' || rEmpleados.Fecha);
      DBMS_OUTPUT.PUT_LINE('Correo electronico cliente : ' || rEmpleados.CorreoCliente);
      DBMS_OUTPUT.PUT_LINE('Numero de cheque : ' || rEmpleados.NumeroCheque);
      DBMS_OUTPUT.PUT_LINE(' ');
      DBMS_OUTPUT.PUT_LINE('El pedido puede ser encargado a los siguientes repartidores :');
    END IF;
    aux := rEmpleados.IdPedido;
      
		IF rEmpleados.Correo = rEmpleados.CorreoCliente THEN
      DBMS_OUTPUT.PUT_LINE(' *Repartidor numero ' || rEmpleados.NumEmpleado);
    END IF;
    
  END LOOP;
  
END;

/
CREATE OR REPLACE TRIGGER registrarCheque
AFTER INSERT ON Pedidos
FOR EACH ROW
DECLARE v_numSocio NUMBER; v_numCheque NUMBER; sinCheques NUMBER;
BEGIN
  SELECT COUNT(*) INTO sinCheques
  FROM Cheques
  WHERE Cheques.CorreoCliente = :NEW.CorreoCliente;
  
  IF sinCheques != 0 THEN
    SELECT Cheques.NumeroCheque INTO v_numCheque
    FROM Cheques
    WHERE CorreoCliente = :NEW.CorreoCliente AND Cheques.NumeroCheque =
        (SELECT MAX(NumeroCheque) FROM Cheques WHERE Cheques.CorreoCliente = :NEW.CorreoCliente) ;
  ELSE
    v_numCheque := 0;
  END IF;
 
  SELECT NumSocio INTO v_numSocio
  FROM Clientes
  WHERE Clientes.Correo = :NEW.CorreoCliente;
  
  IF v_numSocio IS NOT NULL THEN
     INSERT INTO Cheques VALUES(v_numCheque + 1,ADD_MONTHS(SYSDATE, 3),:NEW.Total * 0.03,(:NEW.Total * 0.50),:NEW.CorreoCliente);
  END IF;
END;