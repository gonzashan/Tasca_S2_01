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
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`Provence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Provence` (
  `provence_id` INT NOT NULL AUTO_INCREMENT,
  `name_provence` VARCHAR(45) NULL,
  PRIMARY KEY (`provence_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Town`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Town` (
  `town_id` INT NOT NULL AUTO_INCREMENT,
  `name_town` VARCHAR(45) NOT NULL,
  `provence_id` INT NOT NULL,
  PRIMARY KEY (`town_id`),
  INDEX `fk_Town_Provence_idx` (`provence_id` ASC) VISIBLE,
  CONSTRAINT `fk_Town_Provence`
    FOREIGN KEY (`provence_id`)
    REFERENCES `pizzeria`.`Provence` (`provence_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`customer` (
  `customer_id` INT NULL AUTO_INCREMENT,
  `adresses` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `town_id` INT NOT NULL,
  `provence_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_Person_Town1_idx` (`town_id` ASC, `provence_id` ASC) VISIBLE,
  CONSTRAINT `fk_Person_Town1`
    FOREIGN KEY (`town_id` , `provence_id`)
    REFERENCES `pizzeria`.`Town` (`town_id` , `provence_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Category_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Category_pizza` (
  `Category_pizza_id` INT NOT NULL AUTO_INCREMENT,
  `version_pizza_col` VARCHAR(45) NULL,
  PRIMARY KEY (`Category_pizza_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Products` (
  `products_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `image` VARCHAR(200) NULL,
  `price` VARCHAR(45) NULL,
  `products_type` ENUM("Pizza", "Hamburger", "Drink") NULL,
  `category_pizza_id` INT NULL,
  PRIMARY KEY (`products_id`, `category_pizza_id`),
  INDEX `fk_Products_Category_pizza1_idx` (`category_pizza_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_Category_pizza1`
    FOREIGN KEY (`category_pizza_id`)
    REFERENCES `pizzeria`.`Category_pizza` (`Category_pizza_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name_employee` VARCHAR(45) NULL,
  `surname_employee` VARCHAR(45) NULL,
  `vat_employee` VARCHAR(15) NULL,
  `phone_employee` VARCHAR(15) NULL,
  `type_employee` ENUM("Cook", "Delivery") NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Pizza_shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Pizza_shop` (
  `pizza_shop_id` INT NOT NULL,
  `address` VARCHAR(55) NULL,
  `zip_code` INT NULL,
  `town` VARCHAR(45) NULL,
  `provence` VARCHAR(45) NULL,
  `employee_employee_id` INT NOT NULL,
  PRIMARY KEY (`pizza_shop_id`, `employee_employee_id`),
  INDEX `fk_Pizza_shop_employee1_idx` (`employee_employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_Pizza_shop_employee1`
    FOREIGN KEY (`employee_employee_id`)
    REFERENCES `pizzeria`.`employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Order` (
  `order_id` INT NULL AUTO_INCREMENT,
  `data_order` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total_pizzas` INT NULL,
  `total_hamburger` INT NULL,
  `total_drinks` INT NULL,
  `ticket_amount` DOUBLE NULL,
  `type_order` ENUM("Domicilio", "Reparto") NULL,
  `pizza_shop_id` INT NULL,
  `customer_id` INT NULL,
  `town_town_id` INT NULL,
  `provence_id` INT NULL,
  `employee_id` INT NULL,
  `data_delivery` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`, `pizza_shop_id`, `customer_id`, `town_town_id`, `provence_id`, `employee_id`, `data_delivery`),
  INDEX `fk_Order_Pizza_shop1_idx` (`pizza_shop_id` ASC) VISIBLE,
  INDEX `fk_Order_Person1_idx` (`customer_id` ASC, `town_town_id` ASC, `provence_id` ASC) VISIBLE,
  INDEX `fk_order_employee_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_pizza_shop1`
    FOREIGN KEY (`pizza_shop_id`)
    REFERENCES `pizzeria`.`Pizza_shop` (`pizza_shop_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_customer`
    FOREIGN KEY (`customer_id` , `town_town_id` , `provence_id`)
    REFERENCES `pizzeria`.`customer` (`customer_id` , `town_id` , `provence_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_employee`
    FOREIGN KEY (`employee_id`)
    REFERENCES `pizzeria`.`employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Products_has_Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`Products_has_Order` (
  `products_id` INT NOT NULL,
  `Order_order_id` INT NOT NULL,
  `quantity` VARCHAR(45) NULL,
  PRIMARY KEY (`products_id`, `Order_order_id`),
  INDEX `fk_Products_has_Order_Order1_idx` (`Order_order_id` ASC) VISIBLE,
  INDEX `fk_Products_has_Order_Products1_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_Products_has_Order_Products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `pizzeria`.`Products` (`products_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Products_has_Order_Order1`
    FOREIGN KEY (`Order_order_id`)
    REFERENCES `pizzeria`.`Order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`address` (
  `address_id` INT(11) NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NULL DEFAULT NULL,
  `numero` INT(11) NULL DEFAULT NULL,
  `puerta` VARCHAR(10) NULL DEFAULT NULL,
  `ciudad` VARCHAR(45) NULL DEFAULT NULL,
  `cod_postal` INT(11) NULL DEFAULT NULL,
  `pais` VARCHAR(27) NULL DEFAULT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`supplier` (
  `supplier_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(12) NULL DEFAULT NULL,
  `fax` VARCHAR(12) NULL DEFAULT NULL,
  `vat` VARCHAR(15) NULL DEFAULT NULL,
  `address_id2` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`supplier_id`),
  INDEX `fk_supplier_address1_idx` (`address_id2` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_address1`
    FOREIGN KEY (`address_id2`)
    REFERENCES `optica`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`brand` (
  `brand_id` INT(11) NOT NULL AUTO_INCREMENT,
  `supplier_supplier_id` INT(11) NOT NULL DEFAULT '0',
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`brand_id`, `supplier_supplier_id`),
  INDEX `fk_brand_supplier1_idx` (`supplier_supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_brand_supplier1`
    FOREIGN KEY (`supplier_supplier_id`)
    REFERENCES `optica`.`supplier` (`supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`colors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`colors` (
  `colors_id` INT(11) NOT NULL AUTO_INCREMENT,
  `colors_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`colors_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`customer` (
  `customer_id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_registered` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `endorsed_by` VARCHAR(45) NULL DEFAULT NULL,
  `firts_name` VARCHAR(45) NULL DEFAULT NULL,
  `second_name` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `mail` VARCHAR(45) NULL DEFAULT NULL,
  `address_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `optica`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`employee` (
  `employed_id` INT(11) NOT NULL AUTO_INCREMENT,
  `employee_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`employed_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`eyeglass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`eyeglass` (
  `eyeglass_id` INT(11) NOT NULL AUTO_INCREMENT,
  `prescription_left` DECIMAL(2,0) NULL DEFAULT NULL,
  `prescription_right` DECIMAL(2,0) NULL DEFAULT NULL,
  `type_frame` VARCHAR(15) NULL DEFAULT NULL,
  `id_color_frame` INT(11) NOT NULL,
  `id_color_glass` INT(11) NOT NULL,
  `price` INT(11) NULL DEFAULT NULL,
  `brand_brand_id` INT(11) NOT NULL,
  `brand_supplier_supplier_id` INT(11) NOT NULL,
  PRIMARY KEY (`eyeglass_id`, `brand_brand_id`, `brand_supplier_supplier_id`, `id_color_frame`, `id_color_glass`),
  INDEX `fk_eyeglass_brand1_idx` (`brand_brand_id` ASC, `brand_supplier_supplier_id` ASC) VISIBLE,
  INDEX `fk_id_color_frame_idx` (`id_color_frame` ASC) VISIBLE,
  INDEX `fk_id_color_glass_idx` (`id_color_glass` ASC) VISIBLE,
  CONSTRAINT `fk_eyeglass_brand1`
    FOREIGN KEY (`brand_brand_id` , `brand_supplier_supplier_id`)
    REFERENCES `optica`.`brand` (`brand_id` , `supplier_supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_id_color_frame`
    FOREIGN KEY (`id_color_frame`)
    REFERENCES `optica`.`colors` (`colors_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_id_color_glass`
    FOREIGN KEY (`id_color_glass`)
    REFERENCES `optica`.`colors` (`colors_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`order` (
  `order_id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_order` DATETIME NULL DEFAULT NULL,
  `supplier_supplier_id` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`, `supplier_supplier_id`),
  INDEX `fk_order_supplier1_idx` (`supplier_supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_supplier1`
    FOREIGN KEY (`supplier_supplier_id`)
    REFERENCES `optica`.`supplier` (`supplier_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`order_lines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`order_lines` (
  `order_order_id` INT(11) NOT NULL,
  `eyeglass_eyeglass_id` INT(11) NOT NULL,
  `quantity` INT(11) NULL DEFAULT NULL,
  `comments` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `fk_order_products_order1_idx` (`order_order_id` ASC) VISIBLE,
  INDEX `fk_order_products_eyeglass1_idx` (`eyeglass_eyeglass_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_products_eyeglass1`
    FOREIGN KEY (`eyeglass_eyeglass_id`)
    REFERENCES `optica`.`eyeglass` (`eyeglass_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_products_order1`
    FOREIGN KEY (`order_order_id`)
    REFERENCES `optica`.`order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`sales` (
  `sales_id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_sale` VARCHAR(45) NULL DEFAULT NULL,
  `customer_customer_id` INT(11) NOT NULL,
  `employee_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`sales_id`, `customer_customer_id`),
  INDEX `fk_sales_customer1_idx` (`customer_customer_id` ASC) VISIBLE,
  INDEX `fk_employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `optica`.`employee` (`employed_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sales_customer1`
    FOREIGN KEY (`customer_customer_id`)
    REFERENCES `optica`.`customer` (`customer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


-- -----------------------------------------------------
-- Table `optica`.`sale_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`sale_details` (
  `sales_sale_id` INT(11) NOT NULL,
  `quantity` INT(11) NULL DEFAULT NULL,
  `price` INT(11) NULL DEFAULT NULL,
  `discount` INT(11) NULL DEFAULT NULL,
  `eyeglass_eyeglass_id` INT(11) NOT NULL,
  PRIMARY KEY (`sales_sale_id`, `eyeglass_eyeglass_id`),
  INDEX `fk_sales_eyeglass_sales1_idx` (`sales_sale_id` ASC) VISIBLE,
  INDEX `fk_sale_details_eyeglass1_idx` (`eyeglass_eyeglass_id` ASC) VISIBLE,
  CONSTRAINT `fk_sale_details_eyeglass1`
    FOREIGN KEY (`eyeglass_eyeglass_id`)
    REFERENCES `optica`.`eyeglass` (`eyeglass_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sales_eyeglass_sales1`
    FOREIGN KEY (`sales_sale_id`)
    REFERENCES `optica`.`sales` (`sales_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
