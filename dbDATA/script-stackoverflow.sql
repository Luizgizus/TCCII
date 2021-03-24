-- MySQL Script generated by MySQL Workbench
-- Sat Mar 20 20:58:13 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema stackoverflow
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema stackoverflow
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `stackoverflow` DEFAULT CHARACTER SET utf8 ;
USE `stackoverflow` ;

-- -----------------------------------------------------
-- Table `stackoverflow`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stackoverflow`.`user` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `idAccountStackOverflow` INT NOT NULL,
  `idUserStackOverflow` INT NOT NULL,
  `gitLink` VARCHAR(100) NULL,
  `name` VARCHAR(45) NOT NULL,
  `reputation` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stackoverflow`.`badge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stackoverflow`.`badge` (
  `idBadges` INT NOT NULL AUTO_INCREMENT,
  `userFK` INT NOT NULL,
  `rank` VARCHAR(10) NOT NULL,
  `count` INT NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  `type` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idBadges`),
  INDEX `fk_badge_user1_idx` (`userFK` ASC),
  CONSTRAINT `fk_badge_user1`
    FOREIGN KEY (`userFK`)
    REFERENCES `stackoverflow`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stackoverflow`.`answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stackoverflow`.`answer` (
  `idAnswer` INT NOT NULL AUTO_INCREMENT,
  `userFK` INT NOT NULL,
  `isAccepted` TINYINT NOT NULL,
  `score` INT NOT NULL,
  PRIMARY KEY (`idAnswer`),
  INDEX `fk_answer_user_idx` (`userFK` ASC),
  CONSTRAINT `fk_answer_user`
    FOREIGN KEY (`userFK`)
    REFERENCES `stackoverflow`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stackoverflow`.`question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stackoverflow`.`question` (
  `idQuestion` INT NOT NULL AUTO_INCREMENT,
  `userFK` INT NOT NULL,
  `score` INT NOT NULL,
  `isAnswered` TINYINT NOT NULL,
  `qtdViews` INT NOT NULL,
  PRIMARY KEY (`idQuestion`),
  INDEX `fk_question_user1_idx` (`userFK` ASC),
  CONSTRAINT `fk_question_user1`
    FOREIGN KEY (`userFK`)
    REFERENCES `stackoverflow`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stackoverflow`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stackoverflow`.`tag` (
  `idTag` INT NOT NULL AUTO_INCREMENT,
  `userFK` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTag`),
  INDEX `fk_tag_user1_idx` (`userFK` ASC),
  CONSTRAINT `fk_tag_user1`
    FOREIGN KEY (`userFK`)
    REFERENCES `stackoverflow`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stackoverflow`.`activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stackoverflow`.`activity` (
  `idActivity` INT NOT NULL AUTO_INCREMENT,
  `userFK` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  PRIMARY KEY (`idActivity`),
  INDEX `fk_activity_user1_idx` (`userFK` ASC),
  CONSTRAINT `fk_activity_user1`
    FOREIGN KEY (`userFK`)
    REFERENCES `stackoverflow`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stackoverflow`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stackoverflow`.`comment` (
  `idComment` INT NOT NULL AUTO_INCREMENT,
  `userFK` INT NOT NULL,
  `score` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  PRIMARY KEY (`idComment`),
  INDEX `fk_comment_user1_idx` (`userFK` ASC),
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`userFK`)
    REFERENCES `stackoverflow`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
