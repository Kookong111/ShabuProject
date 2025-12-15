-- Init script generated from entity classes
CREATE DATABASE IF NOT EXISTS project_shabu2;
USE project_shabu2;

-- Customers (entity: Customer, @Table("Customers"))
CREATE TABLE IF NOT EXISTS `Customers` (
  `cusId` INT NOT NULL AUTO_INCREMENT,
  `cususername` VARCHAR(255) NOT NULL,
  `cuspassword` VARCHAR(255) NOT NULL,
  `cusname` VARCHAR(255) NOT NULL,
  `phonenumber` VARCHAR(11) NOT NULL,
  `age` VARCHAR(5) NOT NULL,
  `gmail` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`cusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Employees (entity: Employee, @Table("employees"))
CREATE TABLE IF NOT EXISTS `employees` (
  `empUsername` VARCHAR(255) NOT NULL,
  `empPassword` VARCHAR(255) NOT NULL,
  `empname` VARCHAR(255) NOT NULL,
  `age` VARCHAR(10) NOT NULL,
  `position` VARCHAR(255) NOT NULL,
  `image` VARCHAR(255),
  PRIMARY KEY (`empUsername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Managers (entity: Manager, @Table("managers"))
CREATE TABLE IF NOT EXISTS `managers` (
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `ux_managers_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tables (entity: Tables, @Table("tables"))
CREATE TABLE IF NOT EXISTS `tables` (
  `tableid` VARCHAR(255) NOT NULL,
  `status` VARCHAR(50),
  `capacity` VARCHAR(55) NOT NULL,
  `qr_token` VARCHAR(255) UNIQUE,
  PRIMARY KEY (`tableid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Food types (entity: FoodType, @Table("foodtype"))
CREATE TABLE IF NOT EXISTS `foodtype` (
  `foodtypeId` INT NOT NULL AUTO_INCREMENT,
  `foodtypeName` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255),
  PRIMARY KEY (`foodtypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Menu food (entity: MenuFood, @Table("menufood"))
CREATE TABLE IF NOT EXISTS `menufood` (
  `foodId` INT NOT NULL AUTO_INCREMENT,
  `foodname` VARCHAR(255) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `foodImage` VARCHAR(255) NOT NULL,
  `foodtypeId` INT NOT NULL,
  PRIMARY KEY (`foodId`),
  KEY `idx_menufood_foodtypeId` (`foodtypeId`),
  CONSTRAINT `fk_menufood_foodtype` FOREIGN KEY (`foodtypeId`) REFERENCES `foodtype` (`foodtypeId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Orders (entity: Order, @Table("orders"))
CREATE TABLE IF NOT EXISTS `orders` (
  `oderId` INT NOT NULL AUTO_INCREMENT,
  `orderDate` DATE NOT NULL,
  `totalPeice` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `tableid` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`oderId`),
  KEY `idx_orders_tableid` (`tableid`),
  CONSTRAINT `fk_orders_tables` FOREIGN KEY (`tableid`) REFERENCES `tables` (`tableid`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Order details / order_menu (entity: OrderDetail, @Table("order_menu"))
CREATE TABLE IF NOT EXISTS `order_menu` (
  `odermenuId` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(255) NOT NULL,
  `quantity` INT NOT NULL,
  `priceAtTimeOfOrder` DECIMAL(10,2) NOT NULL,
  `orderId` INT NOT NULL,
  `foodId` INT NOT NULL,
  PRIMARY KEY (`odermenuId`),
  KEY `idx_order_menu_orderId` (`orderId`),
  KEY `idx_order_menu_foodId` (`foodId`),
  CONSTRAINT `fk_order_menu_orders` FOREIGN KEY (`orderId`) REFERENCES `orders` (`oderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_menu_menufood` FOREIGN KEY (`foodId`) REFERENCES `menufood` (`foodId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Reserve (entity: Reserve, @Table("Reserve"))
CREATE TABLE IF NOT EXISTS `Reserve` (
  `reserveid` INT NOT NULL AUTO_INCREMENT,
  `reservedate` DATE NOT NULL,
  `reservetime` VARCHAR(50) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `numberOfGuests` INT NOT NULL,
  `tableid` VARCHAR(255) NOT NULL,
  `cusId` INT NOT NULL,
  PRIMARY KEY (`reserveid`),
  KEY `idx_reserve_tableid` (`tableid`),
  KEY `idx_reserve_cusId` (`cusId`),
  CONSTRAINT `fk_reserve_tables` FOREIGN KEY (`tableid`) REFERENCES `tables` (`tableid`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_reserve_customer` FOREIGN KEY (`cusId`) REFERENCES `Customers` (`cusId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Payment (entity: Payment, @Table("payment"))
CREATE TABLE IF NOT EXISTS `payment` (
  `PaymentId` INT NOT NULL AUTO_INCREMENT,
  `paymentStatus` VARCHAR(255) NOT NULL,
  `paymentDate` DATE NOT NULL,
  `totalPrice` DECIMAL(10,2) NOT NULL,
  `empUsername` VARCHAR(255) NOT NULL,
  `oderId` INT NOT NULL,
  PRIMARY KEY (`PaymentId`),
  KEY `idx_payment_empUsername` (`empUsername`),
  KEY `idx_payment_oderId` (`oderId`),
  CONSTRAINT `fk_payment_employee` FOREIGN KEY (`empUsername`) REFERENCES `employees` (`empUsername`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_orders` FOREIGN KEY (`oderId`) REFERENCES `orders` (`oderId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sample seed (optional) -- uncomment as needed
-- INSERT INTO `managers` (`username`, `password`) VALUES ('admin','adminpass');
