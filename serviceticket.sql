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
   CONSTRAINT FK_gerenciaID
   FOREIGN KEY (`gerenciaID`)
   REFERENCES `gerencia`(`gerenciaID`));
   
CREATE TABLE `serviceticket`.`area` (
  `areaID` INT NOT NULL AUTO_INCREMENT,
  `nombreArena` VARCHAR(45) NOT NULL,
  `departamentoID` INT(11) NOT NULL, 
   PRIMARY KEY (`areaID`),
   CONSTRAINT FK_departamentoID
   FOREIGN KEY (`departamentoID`)
   REFERENCES `departamento`(`departamentoID`));
   
CREATE TABLE `serviceticket`.`encargado` (
  `encargadoID` INT NOT NULL AUTO_INCREMENT,
  `nombreEncargado` VARCHAR(200) NOT NULL,
  `areaID` INT(11) NOT NULL, 
   PRIMARY KEY (`encargadoID`),
   CONSTRAINT FK_areaID
   FOREIGN KEY (`areaID`)
   REFERENCES `area`(`areaID`));
   
CREATE TABLE `serviceticket`.`requerimiento` (
  `requerimientoID` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(245) NOT NULL,
  `estado` TINYINT NOT NULL,
  `usuarioID` INT(11) NOT NULL,
  `encargadoID` INT(11) NOT NULL,
   PRIMARY KEY (`requerimientoID`),
   CONSTRAINT FK_encargadoID
   FOREIGN KEY (`encargadoID`)
   REFERENCES `encargado`(`encargadoID`),
   CONSTRAINT FK_usuarioID
   FOREIGN KEY (`usuarioID`)
   REFERENCES `usuario`(`usuarioID`));

-- DROP DATABASE `serviceticket`;

