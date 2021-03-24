-- MySQL Script generated by MySQL Workbench
-- Sun Mar 21 13:50:51 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema github
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema github
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `github` DEFAULT CHARACTER SET utf8 ;
USE `github` ;

-- -----------------------------------------------------
-- Table `github`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `github`.`user` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `idUserGit` VARCHAR(40) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `qtdFollowers` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `github`.`issue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `github`.`issue` (
  `idIssue` INT NOT NULL AUTO_INCREMENT,
  `userFK` INT NOT NULL,
  `isClosed` TINYINT NOT NULL,
  `qtdComents` INT NOT NULL,
  PRIMARY KEY (`idIssue`),
  INDEX `fk_issue_user1_idx` (`userFK` ASC),
  CONSTRAINT `fk_issue_user1`
    FOREIGN KEY (`userFK`)
    REFERENCES `github`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `github`.`issueReaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `github`.`issueReaction` (
  `idIssueReaction` INT NOT NULL AUTO_INCREMENT,
  `issueFK` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idIssueReaction`),
  INDEX `fk_issueReaction_issue1_idx` (`issueFK` ASC),
  CONSTRAINT `fk_issueReaction_issue1`
    FOREIGN KEY (`issueFK`)
    REFERENCES `github`.`issue` (`idIssue`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `github`.`repository`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `github`.`repository` (
  `idRepository` INT NOT NULL AUTO_INCREMENT,
  `userFK` INT NOT NULL,
  `isEmpty` TINYINT NOT NULL,
  `url` VARCHAR(1500) NOT NULL,
  `primaryLanguage` VARCHAR(45) NULL,
  `name` VARCHAR(45) NOT NULL,
  `linesOfCode` INT NOT NULL,
  `diskUsage` INT NOT NULL,
  `qtdStars` INT NOT NULL,
  `qtdWatchers` INT NOT NULL,
  `qtdVulnerability` INT NOT NULL,
  PRIMARY KEY (`idRepository`),
  INDEX `fk_repository_user_idx` (`userFK` ASC),
  CONSTRAINT `fk_repository_user`
    FOREIGN KEY (`userFK`)
    REFERENCES `github`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `github`.`repositoryLanguages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `github`.`repositoryLanguages` (
  `idRepositoryLanguages` INT NOT NULL AUTO_INCREMENT,
  `repositoryFK` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idRepositoryLanguages`),
  INDEX `fk_repositoryLaguages_repository1_idx` (`repositoryFK` ASC),
  CONSTRAINT `fk_repositoryLaguages_repository1`
    FOREIGN KEY (`repositoryFK`)
    REFERENCES `github`.`repository` (`idRepository`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `github`.`repositoryPullRequests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `github`.`repositoryPullRequests` (
  `idRepositoryPullRequests` INT NOT NULL AUTO_INCREMENT,
  `repositoryFK` INT NOT NULL,
  `isClosed` TINYINT NOT NULL,
  `isMerged` TINYINT NOT NULL,
  PRIMARY KEY (`idRepositoryPullRequests`),
  INDEX `fk_repositoryPullRequests_repository1_idx` (`repositoryFK` ASC),
  CONSTRAINT `fk_repositoryPullRequests_repository1`
    FOREIGN KEY (`repositoryFK`)
    REFERENCES `github`.`repository` (`idRepository`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `github`.`contribuition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `github`.`contribuition` (
  `idContribuition` INT NOT NULL AUTO_INCREMENT,
  `user_idUser` INT NOT NULL,
  `qtdCommitContributions` INT NOT NULL,
  `qtdIssueContributions` INT NOT NULL,
  `qtdPullRequestContributions` INT NOT NULL,
  `qtdPullRequestReviewContributions` INT NOT NULL,
  `qtdRepositoriesWithContributedCommits` INT NOT NULL,
  `qtdRepositoriesWithContributedIssues` INT NOT NULL,
  `qtdRepositoriesWithContributedPullRequestReviews` INT NOT NULL,
  `qtdRepositoryContributions` INT NOT NULL,
  `qtdRepositoriesWithContributedPullRequests` INT NOT NULL,
  PRIMARY KEY (`idContribuition`),
  INDEX `fk_contribuition_user1_idx` (`user_idUser` ASC),
  CONSTRAINT `fk_contribuition_user1`
    FOREIGN KEY (`user_idUser`)
    REFERENCES `github`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `github`.`sonarQualityMetrics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `github`.`sonarQualityMetrics` (
  `idSonarQualityMetrics` INT NOT NULL AUTO_INCREMENT,
  `repositoryFK` INT NOT NULL,
  `userFK` INT NOT NULL,
  `ncloc` INT NULL,
  `qtdVulnerabilities` INT NULL,
  `qtdBugs` INT NULL,
  `qtdCodeSmells` INT NULL,
  `reliabilityRating` FLOAT NULL,
  `qtdDuplicatedFiles` INT NULL,
  `testCoverage` INT NULL,
  `commentLinesDensity` FLOAT NULL,
  `fileComplexity` FLOAT NULL,
  `qtdViolation` INT NULL,
  `manutenibilityRating` FLOAT NULL,
  `securityRating` FLOAT NULL,
  PRIMARY KEY (`idSonarQualityMetrics`),
  INDEX `fk_sonarQualityMetrics_repository1_idx` (`repositoryFK` ASC),
  INDEX `fk_sonarQualityMetrics_user1_idx` (`userFK` ASC),
  CONSTRAINT `fk_sonarQualityMetrics_repository1`
    FOREIGN KEY (`repositoryFK`)
    REFERENCES `github`.`repository` (`idRepository`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sonarQualityMetrics_user1`
    FOREIGN KEY (`userFK`)
    REFERENCES `github`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
