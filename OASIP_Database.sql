-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema int221
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema int221
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `int221` DEFAULT CHARACTER SET utf8 ;
USE `int221` ;

-- -----------------------------------------------------
-- Table `int221`.`eventcategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `int221`.`eventcategory`;

CREATE TABLE IF NOT EXISTS `int221`.`eventcategory` (
  `eventCategoryID` INT NOT NULL AUTO_INCREMENT,
  `eventCategoryName` VARCHAR(100) NOT NULL,
  `eventCategoryDescription` VARCHAR(500) NULL,
  `eventDuration` INT NOT NULL check (eventDuration between 1 and 480),
  PRIMARY KEY (`eventCategoryID`),
  UNIQUE INDEX `eventCategoryName_UNIQUE` (`eventCategoryName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `int221`.`event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `int221`.`event`;

CREATE TABLE IF NOT EXISTS `int221`.`event` (
  `bookingID` INT NOT NULL AUTO_INCREMENT,
  `bookingName` VARCHAR(100) NOT NULL,
  `bookingEmail` VARCHAR(50) NOT NULL,
  `eventCategory` INT NOT NULL,
  `eventStartTime` DATETIME NOT NULL,
  `eventDuration` INT NOT NULL check (eventDuration between 1 and 480),
  `eventNotes` VARCHAR(500) NULL,
  PRIMARY KEY (`bookingID`),
  INDEX `fk_event_eventcategory_idx` (`eventcategory` ASC) VISIBLE,
  CONSTRAINT `fk_event_eventCategory`
    FOREIGN KEY (`eventcategory`)
    REFERENCES `int221`.`eventcategory` (`eventCategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `int221`.`event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `int221`.`user`;

CREATE TABLE IF NOT EXISTS `int221`.`user` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) UNIQUE NOT NULL,
  `email` VARCHAR(50) UNIQUE NOT NULL,
  `role` ENUM('admin', 'lecturer', 'student') DEFAULT 'student',
  `password` VARCHAR(100) NOT NULL,
  `createdOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userId`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `int221`.`eventcategoryowner` (
  `eventCategoryOwnerID` INT NOT NULL AUTO_INCREMENT,
  `userID` INT NOT NULL,
  `eventCategoryID` INT NOT NULL,
  INDEX `userID_idx` (`userID` ASC) VISIBLE,
  INDEX `eventCategoryID_idx` (`eventCategoryID` ASC) VISIBLE,
  PRIMARY KEY (`eventCategoryOwnerID`),
  CONSTRAINT `userID`
    FOREIGN KEY (`userID`)
    REFERENCES `int221`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `eventCategoryID`
    FOREIGN KEY (`eventCategoryID`)
    REFERENCES `int221`.`eventcategory` (`eventCategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET NAMES 'UTF8';

insert into eventcategory 
values ('1', 'Project Management Clinic', 'ตารางนัดหมายนี้ใช้สําหรับนัดหมาย project management clinic ในวิชา INT221 integrated project I ให้นักศึกษาเตรียมเอกสารที่เกี่ยวข้องเพื่อแสดงระหว่างขอคําปรึกษา', 30),
('2', 'DevOps/Infra Clinic', 'Use this event category for DevOps/Infra clinic.', 20),
('3', 'Database Clinic', 'ตารางนัดหมายนี้ใช้ํสำหรับนัดหมาย database clinic ในวิชา INT221 integrated project I', 15),
('4', 'Client-side Clinic', 'ตารางนัดหมายนี้ใช้สําหรับนัดหมาย client-side clinic ในวิชา INT221 integrated project I', 30),
('5', 'Server-side Clinic', null, 30);

insert into event
values(1,'Somchai Jaidee (OR-7)' , 'somchai.jai@mail.kmutt.ac.th' , 2 , '2022-05-23 13:30' , 30 , null),
(2,'Somsri Rakdee (SJ-3)' , 'somsri.rak@mail.kmutt.ac.th', 2 ,'2022-04-27 9:30' , 30 , 'ขอปรึกษาปัญหาเพื่อนไม่ช่วยงาน'),
(3,'สมเกียรติ ขยันเรียน กลุ่ม TT-4' , 'somkiat.kay@kmutt.ac.th' , 4 , '2022-05-23 16:30' , 15 , null);

-- insert into event
-- values(9999,'test past category somsri' , 'somsri.rak@mail.kmutt.ac.th', 1 ,'2022-05-22 15:30' , 30 ,null);

-- insert into event
-- values(4,' Quanah Zazil ' , 'Quanah.Q@mail.kmutt.ac.th' , 1 , '2021-05-20 13:10' , 30 , null),
-- (5,' Naoki Yoshida ' , 'ysdNao@mail.kmutt.ac.th' , 2 , '2014-05-20 12:00' , 20 , null),
-- (6,' Kenojuak Quanah ' , 'Keno.qua@mail.kmutt.ac.th' , 3 , '2032-11-25 14:00' , 15 , null),
-- (7,' Walela Antinanco ' , 'antinanco.w@mail.kmutt.ac.th' , 4 , '2023-06-21 16:00' , 30 , null),
-- (8,' Yuuto Matsumoto ' , 'matsu.yuuto@mail.kmutt.ac.th' , 5 , '2022-12-03 15:30' , 30 , null),
-- (9,' Reggie Fletcher ' , 'reggie.me@hotmail.com' , 1 , '2022-05-22 20:00' , 30 , null),
-- (10,' Vikki Hayleigh ' , 'vikkie.hay@mail.kmutt.ac.th' , 2 , '2021-05-18 12:50' , 20 , null),
-- (11,' Maynerd Jada ' , 'jada.may@mail.kmutt.ac.th' , 3 , '2022-05-23 00:00' , 15 , null),
-- (12,' Anisa Mokhtar Azzarà ' , 'anisa007@mail.kmutt.ac.th' , 4 , '2022-05-17 01:00' , 30 , null),
-- (13,' Miroslava Elchanan Fini ' , 'finiInw@hotmail.com' , 5 , '2021-05-19 14:00' , 30 , null),
-- (14,' Intira Wattana ' , 'intira.th@mail.kmutt.ac.th' , 4 , '2025-01-08 08:25' , 30 , null),
-- (15,' Suk-Ja Choe ' , 'choe@mail.kmutt.ac.th' , 3 , '2022-05-24 02:35' , 15 , null),
-- (16,' Timon Nunes ' , 'itstim@outlook.com' , 2 , '2022-05-25 15:00' , 20 , null),
-- (17,' Darshana Holguín ' , 'dars.hol@mail.kmutt.ac.th' , 1 , '2022-05-28 07:30' , 30 , null),
-- (18,' Hyun-Joo Jung ' , 'h00jung@mail.kmutt.ac.th' , 2 , '2034-08-08 08:45' , 20 , null),
-- (19,' Effie Mortimer ' , 'effie.me@mail.kmutt.ac.th' , 3 , '2021-07-21 19:00' , 15 , null),
-- (20,' Soo-Jin Cho ' , 'soojincho@mail.kmutt.ac.th' , 4 , '2022-05-21 16:00' , 30 , null),
-- (21,' Ralphie Harlow ' , 'iamralph@mail.kmutt.ac.th' , 5 , '2012-09-11 17:50' , 30 , null),
-- (22,' Hye Shin ' , 'Shin.hye@mail.kmutt.ac.th' , 1 , '2022-02-20 10:00' , 30 , null),
-- (23,' Cristal Moores ' , 'mooresMe@mail.kmutt.ac.th' , 2 , '2011-11-11 11:11' , 20 , null),
-- (24,' Seong-Ho Shin ' , 'seongho.shine@mail.kmutt.ac.th' , 3 , '2025-07-08 01:30' , 15 , null),
-- (25,' Rosanne Czinege ' , 'rosanne@outlook.com' , 4 , '2022-05-11 06:45' , 30 , null),
-- (26,' Shouhei Hagihara ' , 'hagi.jp@mail.kmutt.ac.th' , 5 , '2024-05-23 14:00' , 30 , null),
-- (27,' Samiye Rennell ' , 'rennell.en@hotmail.com' , 4 , '2028-05-23 19:00' , 30 , null),
-- (28,' Jun Gang ' , 'hi.imjun@mail.kmutt.ac.th' , 3 , '2022-05-24 02:00' , 15 , null),
-- (29,' Spencer Moors ' , 'moors@mail.kmutt.ac.th' , 2 , '2027-05-25 15:00' , 20 , null),
-- (30,' Jalil Balázs ' , 'jalil.navidad@mail.kmutt.ac.th' , 1 , '2002-05-28 07:30' , 30 , null),
-- (31,' Terrence Hobbes ' , 'hobbesnothobby@mail.kmutt.ac.th' , 3 , '2013-06-23 00:00' , 15 , null),
-- (32,' Koen Watts ' , 'watts.ko@mail.kmutt.ac.th' , 4 , '2022-03-13 12:00' , 30 , null),
-- (33,' Jákob Van Houtem ' , 'jakob.notjacob@mail.kmutt.ac.th' , 5 , '1998-01-01 16:30' , 30 , null),
-- (34,' Alaiya Bonhomme ' , 'alaiya.here@mail.kmutt.ac.th' , 4 , '2021-08-10 10:45' , 30 , null),
-- (35,' Kostis Kerner ' , 'kerner.bank@mail.kmutt.ac.th' , 3 , '2004-05-14 02:00' , 15 , null),
-- (36,' Jeong-Suk Oh ' , 'ohjeongsuk@mail.kmutt.ac.th' , 2 , '2019-05-15 15:00' , 20 , null),
-- (37,' Erlingur Hass ' , 'hxassie@mail.kmutt.ac.th' , 1 , '2022-05-28 07:30' , 30 , null),
-- (38,' Saori Hirano ' , 'saori.jp@hotmail.com' , 2 , '2022-05-20 12:00' , 20 , null),
-- (39,' Philis Bishop ' , 'phill.bish@mail.kmutt.ac.th' , 3 , '2022-04-21 14:00' , 15 , null),
-- (40,' Jennigje Schultheis ' , 'jenniee@mail.kmutt.ac.th' , 4 , '2022-01-28 16:00' , 30 , null),
-- (41,' Fredrik Aarts ' , 'amaarts@mail.kmutt.ac.th' , 5 , '2020-02-11 21:30' , 30 , null),
-- (42,' Ricki Tod ' , 'tod.notcome@mail.kmutt.ac.th' , 1 , '2022-10-12 23:00' , 30 , null),
-- (43,' Leith Angenent ' , 'leithzgo@mail.kmutt.ac.th' , 2 , '2023-11-20 11:00' , 20 , null),
-- (44,' Orianne Trengove ' , 'orianne.coming@hotmail.com' , 3 , '2022-05-11 12:00' , 15 , null),
-- (45,' Haralampi Alan ' , 'alanwake@mail.kmutt.ac.th' , 4 , '2021-03-08 02:00' , 30 , null),
-- (46,' Helene Mortimer ' , 'lelene@gmail.com' , 5 , '2022-12-20 15:50' , 30 , null),
-- (47,' Ichiro Maeda ' , 'maeda.jp@mail.kmutt.ac.th' , 5 , '2021-10-22 04:00' , 30 , null),
-- (48,' Larisa Böhler ' , 'lorial@mail.kmutt.ac.th' , 5 , '2022-08-11 11:00' , 30 , null),
-- (49,' Ismael Beneš ' , 'bartley@gmail.com' , 5 , '2022-11-22 17:00' , 30 , null),
-- (50,' Aina Katō ' , 'kato.cute@mail.kmutt.ac.th' , 5 , '2027-11-20 09:30' , 30 , null),
-- (51,' Dionisio Penners ' , 'penny@mail.kmutt.ac.th' , 3 , '2023-01-10 12:00' , 15 , null),
-- (52,' Aveline Argyris ' , 'eveline@gmail.com' , 4 , '2020-10-22 08:00' , 30 , null),
-- (53,' Hugo Krastev ' , 'hugothree@mail.kmutt.ac.th' , 5 , '2021-04-23 14:00' , 30 , null),
-- (54,' Sanne Schmeling ' , 'sandy.shore@gmail.com' , 4 , '2020-10-10 18:30' , 30 , null),
-- (55,' Paula Forest ' , 'itsmepaula@mail.kmutt.ac.th' , 3 , '2022-11-24 02:00' , 15 , null),
-- (56,' Cristal Pettersson ' , 'cristal.petterson@mail.kmutt.ac.th' , 2 , '2022-12-20 15:00' , 20 , null),
-- (57,' Félix Reuter ' , 'feliz.navidad@yahoo.com' , 1 , '2022-05-30 07:30' , 30 , null),
-- (58,' Riku Moto ' , 'rikute@mail.kmutt.ac.th' , 2 , '2022-05-31 22:00' , 20 , null),
-- (59,' Onofre Alexandersson ' , 'alxme.ono@mail.kmutt.ac.th' , 3 , '2021-06-21 14:00' , 15 , null),
-- (60,' Anatole Boesch ' , 'anatole.boesch@mail.kmutt.ac.th' , 4 , '2022-06-10 16:00' , 30 , null),
-- (61,' Goro Hamasaki ' , 'goro.your@outlook.com' , 5 , '2022-05-11 18:00' , 30 , null),
-- (62,' Ayane Kita ' , 'kita.kawaii@gmail.com' , 1 , '2022-05-12 20:00' , 30 , null),
-- (63,' Hikari Shibuya ' , 'shibuya.hikari@mail.kmutt.ac.th' , 2 , '2022-03-11 22:00' , 20 , null),
-- (64,' Kiyoshi Kita ' , 'cuteyochi@gmail.com' , 3 , '2022-06-10 00:00' , 15 , null),
-- (65,' Min-Su Yi ' , 'minniee@mail.kmutt.ac.th' , 4 , '2022-07-07 12:00' , 30 , null),
-- (66,' Sung Kim ' , 'sung.sam@mail.kmutt.ac.th' , 5 , '2022-08-14 14:00' , 30 , null),
-- (67,' Dae-Seong Park ' , 'mr.park@mail.kmutt.ac.th' , 2 , '2021-06-22 22:00' , 20 , null),
-- (68,' Eun-Ji Gang ' , 'gang.eunji@gmail.com' , 3 , '2025-06-23 00:00' , 15 , null),
-- (69,' Ji-Yu Jeong ' , 'jeongGU@mail.kmutt.ac.th' , 4 , '2021-06-20 02:00' , 30 , null),
-- (70,' Seo-Jun Park ' , 'seojun.nice@mail.kmutt.ac.th' , 4 , '2022-07-31 09:00' , 30 , null);


INSERT INTO `user` VALUES
(1,'OASIP ADMIN','oasip.admin@kmutt.ac.th','admin','$argon2id$v=19$m=4096,t=3,p=1$sYXzbUOqBoHY1NfhJ8cjnw$H6+adWySiFPgcUogJK3hEhcF6Y4fusy7tcXYEL+f0cQ','2022-08-01 07:00:00','2022-08-01 07:00:00'),
(2,'Olarn Rojanapornpun','olarn.roj@kmutt.ac.th','lecturer','$argon2id$v=19$m=4096,t=3,p=1$Sx7y2jxKZSjpWUV4srd8eg$AMH09iFiPQgAZ00cAdN3Gucqfhx2kRo3tQbHeLSR0RE','2022-08-08 23:00:00','2022-08-08 23:00:00'),
(3,'Pichet Limvachiranan','pichet.limv@kmutt.ac.th','lecturer','$argon2id$v=19$m=4096,t=3,p=1$46EB43gQ46Z1/EmdqxtKNA$7m6cWGO2iDlFl/ETDYuYf+ArnSjRnsNwXLIP18DTYQY','2022-08-08 23:00:01','2022-08-08 23:00:01'),
(4,'Umaporn Supasitthimethee','umaporn.sup@kmutt.ac.th','lecturer','$argon2id$v=19$m=4096,t=3,p=1$1Z2UK1zC76FIQeLH54GVAQ$qfXcHF31LnuWpt37QAcWyNp8PdbOQ+jjaV1xWXixS0M','2022-08-16 16:00:00','2022-08-16 16:00:00'),
(5,'Siam Yamsaengsung','siam.yam@kmutt.ac.th','lecturer','$argon2id$v=19$m=4096,t=3,p=1$C4pPaNWKTnZQX2mPs14jlg$rQ5W5NYKqGOu1B4GkUWq8cFbcg2peFWGjpUMr9Nkm8g','2022-08-08 23:00:00','2022-08-08 23:00:00'),
(6,'Sunisa Sathapornvajana','sunisa.sat@kmutt.ac.th','lecturer','$argon2id$v=19$m=4096,t=3,p=1$29/ffaszvjvi3CZO45bSCg$kKpfq5WEswoqa/LfyIZzQaQ6AFdjhyiYjXRCfMiTnwg','2022-08-08 23:00:01','2022-08-08 23:00:01'),
(7,'Somchai Jaidee','somchai.jai@kmutt.ac.th','student','$argon2id$v=19$m=4096,t=3,p=1$dmsOy7LPTjmooPu+P2oTZA$NZFTFd3f0K1Sp19aaUwyn3jgiy15yFcXhp8E4/1yXoI','2022-08-16 16:00:00','2022-08-16 16:00:00'),
(8,'Komkrid Rakdee','komkrid.rak@mail.kmutt.ac.th','student','$argon2id$v=19$m=4096,t=3,p=1$8W61ZOC5RU7sJP5kKRbSqg$OLwZNPeMqxp+g0Vbn+odcA47XMClFN+IswTueVah7F0','2022-08-08 23:00:00','2022-08-08 23:00:00'),
(9,'สมเกียรติ ขยันเรียน','somkiat.kay@kmutt.ac.th','student','$argon2id$v=19$m=4096,t=3,p=1$gBqgjspF45FcIKQEw8GmaQ$alrOCZ0YrDqOu8/aZiLDMGZo4vFkSEAXA0YoHhY0BDQ','2022-08-08 23:00:01','2022-08-08 23:00:01');


insert into eventcategoryowner (userID,eventCategoryID) values
(2,1),(2,2),(2,5),(5,2),
(6,3),(4,4),(3,5);
