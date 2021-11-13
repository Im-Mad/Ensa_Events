/*
CREATE USER 'ensa_event'@'localhost' IDENTIFIED BY 'ensa_event';

GRANT ALL PRIVILEGES ON * . * TO 'ensa_event'@'localhost';

#
# Starting with MySQL 8.0.4, the MySQL team changed the 
# default authentication plugin for MySQL server 
# from mysql_native_password to caching_sha2_password.
#
# The command below will make the appropriate updates for your user account.
#
# See the MySQL Reference Manual for details: 
# https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html
#
ALTER USER 'ensa_event'@'localhost' IDENTIFIED WITH mysql_native_password BY 'ensa_event';

*/
DROP DATABASE  IF EXISTS `ensa_events`;

CREATE DATABASE  IF NOT EXISTS `ensa_events`;
USE `ensa_events`;

CREATE TABLE `users` (
	`id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` char(68) NOT NULL,
  `first_name` char(50) NOT NULL,
  `last_name` char(50) NOT NULL,
  `email` char(50) NOT NULL,
  `avatar` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Club` (
	`id` INT  NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `description` char(50) NOT NULL,
  `logo` char(50) NOT NULL,
  `coverphoto` char(50) NOT NULL,
  `user_id` INT NOT NULL,
  FOREIGN KEY (user_id) references user (id) on delete cascade,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Event` (
	`id` INT  NOT NULL AUTO_INCREMENT,
  `date` char(50) NOT NULL,
  `name` char(68) NOT NULL,
  `description` varchar(100) NOT NULL,
  `coverphoto` varchar(50) NOT NULL,
  `club_id` INT NOT NULL,
  FOREIGN KEY (club_id) references club (id) on delete cascade,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE Review(
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    description varchar(50),
    rating INT,
    PRIMARY KEY (user_id, event_id),
    FOREIGN KEY (user_id) references user (id) on delete cascade,
    FOREIGN KEY (event_id)  references Event  (id) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


CREATE TABLE `users_roles` (
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  
  PRIMARY KEY (`user_id`,`role_id`),
  
  KEY `FK_ROLE_idx` (`role_id`),
  
  CONSTRAINT `FK_USER_05` FOREIGN KEY (`user_id`) 
  REFERENCES `user` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  
  CONSTRAINT `FK_ROLE` FOREIGN KEY (`role_id`) 
  REFERENCES `role` (`id`)
  ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;