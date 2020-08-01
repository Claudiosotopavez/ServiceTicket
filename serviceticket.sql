CREATE SCHEMA `serviceticket`;

USE serviceticket;

CREATE TABLE `serviceticket`.`usuario` (
  `usuarioID` INT NOT NULL AUTO_INCREMENT,
  `nomnbreUsuario` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
   PRIMARY KEY (`usuarioID`));
   
CREATE TABLE `serviceticket`.`gerencia` (
  `gerenciaID` INT NOT NULL AUTO_INCREMENT,
  `nombreGerencia` VARCHAR(45) NOT NULL,
   PRIMARY KEY (`gerenciaID`));
   
CREATE TABLE `serviceticket`.`departamento` (
  `departamentoID` INT NOT NULL AUTO_INCREMENT,
  `nombreDepartamento` VARCHAR(45) NOT NULL,
  `gerenciaID` INT(11) NOT NULL,
   PRIMARY KEY (`departamentoID`),
   CONSTRAINT `FK_gerenciaID`
   FOREIGN KEY (`gerenciaID`)
   REFERENCES `gerencia`(`gerenciaID`));
   
CREATE TABLE `serviceticket`.`area` (
  `areaID` INT NOT NULL AUTO_INCREMENT,
  `nombreArea` VARCHAR(45) NOT NULL,
  `departamentoID` INT(11) NOT NULL, 
   PRIMARY KEY (`areaID`),
   CONSTRAINT `FK_departamentoID`
   FOREIGN KEY (`departamentoID`)
   REFERENCES `departamento`(`departamentoID`));
   
CREATE TABLE `serviceticket`.`encargado` (
  `encargadoID` INT NOT NULL AUTO_INCREMENT,
  `nombreEncargado` VARCHAR(200) NOT NULL,
  `areaID` INT(11) NOT NULL, 
   PRIMARY KEY (`encargadoID`),
   CONSTRAINT `FK_areaID`
   FOREIGN KEY (`areaID`)
   REFERENCES `area`(`areaID`));
   
CREATE TABLE `serviceticket`.`requerimiento` (
  `requerimientoID` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(245) NOT NULL,
  `estado` TINYINT NOT NULL,
  `usuarioID` INT(11) NOT NULL,
  `encargadoID` INT(11) NOT NULL,
   PRIMARY KEY (`requerimientoID`),
   CONSTRAINT `FK_encargadoID`
   FOREIGN KEY (`encargadoID`)
   REFERENCES `encargado`(`encargadoID`),
   CONSTRAINT FK_usuarioID
   FOREIGN KEY (`usuarioID`)
   REFERENCES `usuario`(`usuarioID`));

-- DROP DATABASE `serviceticket`;

INSERT INTO serviceticket.usuario(nomnbreUsuario, password, email) Values('Jorge', '098765','jorge.mirandas@correoaiep.cl'); 
INSERT INTO serviceticket.usuario(nomnbreUsuario, password, email) Values('Claudio', '123456','claudio.sotopav@correoaiep.cl');
INSERT INTO serviceticket.gerencia (nombreGerencia) VALUES ('TICs');
INSERT INTO serviceticket.gerencia (nombreGerencia) VALUES ('RRHH');
INSERT INTO serviceticket.gerencia (nombreGerencia) VALUES ('Trafico');
INSERT INTO serviceticket.departamento (gerenciaID,nombreDepartamento) VALUES (1,'Seguridad Informatica');
INSERT INTO serviceticket.departamento (gerenciaID,nombreDepartamento) VALUES (1,'Desarrollo e investigación');
INSERT INTO serviceticket.departamento (gerenciaID,nombreDepartamento) VALUES (2,'Servicio a personas');
INSERT INTO serviceticket.departamento (gerenciaID,nombreDepartamento) VALUES (3,'Logística');
INSERT INTO serviceticket.area (departamentoID,nombreArea) VALUES (1,'Pentesting & EH');
INSERT INTO serviceticket.area (departamentoID,nombreArea) VALUES (2,'Desarrollo software');
INSERT INTO serviceticket.area (departamentoID,nombreArea) VALUES (2,'UAT');
INSERT INTO serviceticket.area (departamentoID,nombreArea) VALUES (2,'QA');
INSERT INTO serviceticket.area (departamentoID,nombreArea) VALUES (2,'Mesa de ayuda sistemas');
INSERT INTO serviceticket.area (departamentoID,nombreArea) VALUES (3,'Selección de personal');
INSERT INTO serviceticket.area (departamentoID,nombreArea) VALUES (3,'Capacitación');
INSERT INTO serviceticket.area (departamentoID,nombreArea) VALUES (3,'Servicio a personas');
INSERT INTO serviceticket.area (departamentoID,nombreArea) VALUES (4,'Agenda proveedores');
INSERT INTO serviceticket.area (departamentoID,nombreArea) VALUES (4,'Soporte logístico');
INSERT INTO serviceticket.encargado (areaID, nombreEncargado) VALUES (2,'Jorge Miranda');
INSERT INTO serviceticket.encargado (areaID, nombreEncargado) VALUES (3,'Jorge Jara');
INSERT INTO serviceticket.encargado (areaID, nombreEncargado) VALUES (4,'Eric Dinamarca');
INSERT INTO serviceticket.encargado (areaID, nombreEncargado) VALUES (5,'Felipe Gutierrez');
INSERT INTO serviceticket.encargado (areaID, nombreEncargado) VALUES (6,'Annie Borbaran');
INSERT INTO serviceticket.encargado (areaID, nombreEncargado) VALUES (7,'Andy Louis');
INSERT INTO serviceticket.encargado (areaID, nombreEncargado) VALUES (8,'Jose Bustos');
INSERT INTO serviceticket.encargado (areaID, nombreEncargado) VALUES (9,'Leonardo Pacheco');
INSERT INTO serviceticket.encargado (areaID, nombreEncargado) VALUES (10,'Sergio Labrin');
INSERT INTO serviceticket.encargado (areaID, nombreEncargado) VALUES (1,'Claudio Soto');
INSERT INTO serviceticket.requerimiento (descripcion, estado, usuarioID, encargadoID) VALUES('test_1', 1, 1,2);
INSERT INTO serviceticket.requerimiento (descripcion, estado, usuarioID, encargadoID) VALUES('test_2', 1, 2,10);
INSERT INTO serviceticket.requerimiento (descripcion, estado, usuarioID, encargadoID) VALUES('test_3', 2, 2,10);

SELECT * FROM serviceticket.usuario;
SELECT * FROM serviceticket.gerencia;
SELECT * FROM serviceticket.departamento;
SELECT * FROM serviceticket.area;
SELECT * FROM serviceticket.encargado;
SELECT * FROM serviceticket.requerimiento;

CREATE  OR REPLACE VIEW `consulta` AS
	SELECT requerimientoID, descripcion, estado, e.areaID, nombreArea, a.departamentoID, nombreDepartamento, d.gerenciaID, nombreGerencia
    FROM requerimiento r
	INNER JOIN	encargado AS e
	ON r.encargadoID = e.encargadoID
    INNER JOIN area a
    ON e.areaID = a.areaID
    INNER JOIN departamento AS d
    ON a.departamentoID = d.departamentoID
    INNER JOIN gerencia g
    ON d.gerenciaID = g.gerenciaID;

SELECT * FROM serviceticket.consulta
    WHERE gerenciaID = 1 AND departamentoID = 1 AND gerenciaID = 1;
    