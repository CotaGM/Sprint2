-- MySQL Script generated by MySQL Workbench
-- Sat May  4 12:46:09 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DBpizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `DBpizzeria` ;

-- -----------------------------------------------------
-- Schema DBpizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DBpizzeria` DEFAULT CHARACTER SET utf8 ;
USE `DBpizzeria` ;

-- -----------------------------------------------------
-- Table `DBpizzeria`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBpizzeria`.`Cliente` (
  `id_cliente` INT(20) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(80) NOT NULL,
  `codigo_postal` INT(5) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBpizzeria`.`Tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBpizzeria`.`Tiendas` (
  `id_tienda` INT(20) NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(80) NOT NULL,
  `codigo_postal` INT(5) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tienda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBpizzeria`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBpizzeria`.`Pedidos` (
  `id_pedido` INT(45) NOT NULL AUTO_INCREMENT,
  `id_cliente` INT(20) NOT NULL,
  `id_tienda` INT(20) NOT NULL,
  `fecha_pedido` DATE NOT NULL,
  `hora pedido` TIME NOT NULL,
  `tipo_pedido` VARCHAR(10) NOT NULL,
  `cantidad_pizzas` INT(10) NOT NULL,
  `cantidad_hamburguesas` INT(10) NOT NULL,
  `cantidad_bebidas` INT(10) NOT NULL,
  `total_cantidad_productos` INT(10) NOT NULL,
  `precio_total` DOUBLE NOT NULL,
  PRIMARY KEY (`id_pedido`),
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `DBpizzeria`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `DBpizzeria`.`Tiendas` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_cliente_idx` ON `DBpizzeria`.`Pedidos` (`id_cliente` ASC) VISIBLE;

CREATE INDEX `id_tienda_idx` ON `DBpizzeria`.`Pedidos` (`id_tienda` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DBpizzeria`.`Categoria pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBpizzeria`.`Categoria pizzas` (
  `id_categoria_pizza` INT(20) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `periodo` DATE NOT NULL,
  PRIMARY KEY (`id_categoria_pizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DBpizzeria`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBpizzeria`.`Productos` (
  `id_producto` INT(20) NOT NULL AUTO_INCREMENT,
  `id_categoria_pizza` INT(20) NOT NULL,
  `tipo_producto` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` DOUBLE NOT NULL,
  `descripcion` VARCHAR(80) NOT NULL,
  `imagen` BLOB NOT NULL,
  PRIMARY KEY (`id_producto`),
  CONSTRAINT `id_categoria_pizza`
    FOREIGN KEY (`id_categoria_pizza`)
    REFERENCES `DBpizzeria`.`Categoria pizzas` (`id_categoria_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_categoria_pizza_idx` ON `DBpizzeria`.`Productos` (`id_categoria_pizza` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DBpizzeria`.`Detalle pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBpizzeria`.`Detalle pedido` (
  `id_pedido` INT(45) NOT NULL AUTO_INCREMENT,
  `id_producto` INT(20) NOT NULL,
  `nombre_producto` VARCHAR(45) NOT NULL,
  `cantidad_detalle` INT(10) NOT NULL,
  `precio_detalle` DOUBLE NOT NULL,
  CONSTRAINT `id_pedido`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `DBpizzeria`.`Pedidos` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_producto`
    FOREIGN KEY (`id_producto`)
    REFERENCES `DBpizzeria`.`Productos` (`id_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_pedido_idx` ON `DBpizzeria`.`Detalle pedido` (`id_pedido` ASC) VISIBLE;

CREATE INDEX `id_producto_idx` ON `DBpizzeria`.`Detalle pedido` (`id_producto` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DBpizzeria`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBpizzeria`.`Empleados` (
  `id_empleado` INT(45) NOT NULL AUTO_INCREMENT,
  `id_tienda` INT(20) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  `funcion` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_empleado`),
  CONSTRAINT `id_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `DBpizzeria`.`Tiendas` (`id_tienda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_tienda_idx` ON `DBpizzeria`.`Empleados` (`id_tienda` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `DBpizzeria`.`Entregas a domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DBpizzeria`.`Entregas a domicilio` (
  `id_entrega` INT(45) NOT NULL AUTO_INCREMENT,
  `id_pedido` INT(45) NOT NULL,
  `id_repartidor` INT(45) NOT NULL,
  `hora_entrega` TIME NOT NULL,
  PRIMARY KEY (`id_entrega`),
  CONSTRAINT `id_pedido`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `DBpizzeria`.`Pedidos` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_repartidor`
    FOREIGN KEY (`id_repartidor`)
    REFERENCES `DBpizzeria`.`Empleados` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `id_pedido_idx` ON `DBpizzeria`.`Entregas a domicilio` (`id_pedido` ASC) VISIBLE;

CREATE INDEX `id_repartidor_idx` ON `DBpizzeria`.`Entregas a domicilio` (`id_repartidor` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
