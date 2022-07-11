-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provence` (
  `provence_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name_provence` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`provence_id`),
  UNIQUE INDEX `name_provence_UNIQUE` (`name_provence` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`town`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`town` (
  `town_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name_town` VARCHAR(45) NOT NULL,
  `provence_id` INT(11) NOT NULL,
  PRIMARY KEY (`town_id`),
  INDEX `fk_Town_Provence_idx` (`provence_id` ASC) ,
  CONSTRAINT `fk_Town_Provence`
    FOREIGN KEY (`provence_id`)
    REFERENCES `pizzeria`.`provence` (`provence_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`customer` (
  `customer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `adresses` VARCHAR(45) NULL DEFAULT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `surname` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `town_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_Person_Town1_idx` (`town_id` ASC) ,
  CONSTRAINT `fk_customer_Town1`
    FOREIGN KEY (`town_id`)
    REFERENCES `pizzeria`.`town` (`town_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza_shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_shop` (
  `pizza_shop_id` INT(11) NOT NULL DEFAULT '0',
  `address` VARCHAR(55) NULL DEFAULT NULL,
  `zip_code` INT(11) NULL DEFAULT NULL,
  `town` VARCHAR(45) NULL DEFAULT NULL,
  `provence` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`pizza_shop_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employee` (
  `employee_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name_employee` VARCHAR(45) NULL DEFAULT NULL,
  `surname_employee` VARCHAR(45) NULL DEFAULT NULL,
  `vat_employee` VARCHAR(15) NULL DEFAULT NULL,
  `phone_employee` VARCHAR(15) NULL DEFAULT NULL,
  `type_employee` ENUM('Cook', 'Delivery') NULL DEFAULT NULL,
  `pizza_shop_id` INT(11) NOT NULL,
  PRIMARY KEY (`employee_id`, `pizza_shop_id`),
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) ,
  INDEX `fk_employee_Pizza_shop1_idx` (`pizza_shop_id` ASC) ,
  CONSTRAINT `fk_employee_Pizza_shop1`
    FOREIGN KEY (`pizza_shop_id`)
    REFERENCES `pizzeria`.`pizza_shop` (`pizza_shop_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`type_service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`type_service` (
  `type_service_id` INT NOT NULL,
  `type_service_name` VARCHAR(45) NULL,
  PRIMARY KEY (`type_service_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`order` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `data_order` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `total_pizzas` INT(11) NULL DEFAULT NULL,
  `total_hamburger` INT(11) NULL DEFAULT NULL,
  `total_drinks` INT(11) NULL DEFAULT NULL,
  `ticket_amount` DOUBLE NULL DEFAULT NULL,
  `data_delivery` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_customer_id` INT(11) NOT NULL,
  `employee_employee_id` INT(11) NOT NULL,
  `type_service_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_Order_customer1_idx` (`customer_customer_id` ASC) ,
  INDEX `fk_Order_employee1_idx` (`employee_employee_id` ASC) ,
  INDEX `fk_Order_type_service1_idx` (`type_service_id` ASC) ,
  CONSTRAINT `fk_Order_customer1`
    FOREIGN KEY (`customer_customer_id`)
    REFERENCES `pizzeria`.`customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Order_employee1`
    FOREIGN KEY (`employee_employee_id`)
    REFERENCES `pizzeria`.`employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Order_type_service1`
    FOREIGN KEY (`type_service_id`)
    REFERENCES `pizzeria`.`type_service` (`type_service_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`category_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`category_pizza` (
  `category_pizza_id` INT(11) NOT NULL AUTO_INCREMENT,
  `version_pizza_col` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`category_pizza_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`type_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`type_product` (
  `type_product_id` INT NOT NULL,
  `type_product_name` VARCHAR(45) NULL,
  PRIMARY KEY (`type_product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`product` (
  `product_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `image` VARCHAR(200) NULL DEFAULT NULL,
  `price` VARCHAR(45) NULL DEFAULT NULL,
  `category_pizza_id` INT(11) NULL DEFAULT '0',
  `type_product_id` INT NOT NULL,
  PRIMARY KEY (`product_id`),
  INDEX `fk_Products_Category_pizza1_idx` (`category_pizza_id` ASC) ,
  INDEX `fk_product_type_product1_idx` (`type_product_id` ASC) ,
  CONSTRAINT `fk_Products_Category_pizza1`
    FOREIGN KEY (`category_pizza_id`)
    REFERENCES `pizzeria`.`category_pizza` (`category_pizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_product_type_product1`
    FOREIGN KEY (`type_product_id`)
    REFERENCES `pizzeria`.`type_product` (`type_product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `pizzeria`.`product_has_Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`product_has_Order` (
  `product_id` INT(11) NOT NULL,
  `order_id` INT(11) NOT NULL DEFAULT '0',
  `quantity` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`, `order_id`),
  INDEX `fk_Products_has_Order_Order1_idx` (`order_id` ASC) ,
  INDEX `fk_Products_has_Order_Products1_idx` (`product_id` ASC) ,
  CONSTRAINT `fk_Products_has_Order_Order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizzeria`.`order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Products_has_Order_Products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pizzeria`.`product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
