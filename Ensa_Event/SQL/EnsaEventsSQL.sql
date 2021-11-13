
/*
CREATE USER 'hbstudent'@'localhost' IDENTIFIED BY 'hbstudent';

GRANT ALL PRIVILEGES ON * . * TO 'hbstudent'@'localhost';

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
ALTER USER 'hbstudent'@'localhost' IDENTIFIED WITH mysql_native_password BY 'hbstudent';

*/

DROP DATABASE  IF EXISTS `ensa_events`;

CREATE DATABASE  IF NOT EXISTS `ensa_events`;
USE `ensa_events`;

CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `password` char(68) NOT NULL,
  `first_name` char(50) NOT NULL,
  `last_name` char(50) NOT NULL,
  `email` char(50) NOT NULL,
  `avatar` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Club` (
	`id` INT  NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `description` char(50) NOT NULL,
  `logo` char(50) NOT NULL,
  `coverphoto` char(50) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  FOREIGN KEY (user_id) references users (username) on delete cascade,
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
    user_id varchar(50) NOT NULL,
    event_id INT NOT NULL,
    description varchar(50),
    rating INT,
    PRIMARY KEY (user_id, event_id),
    FOREIGN KEY (user_id) references users (username) on delete cascade,
    FOREIGN KEY (event_id)  references Event  (id) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



CREATE TABLE `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  UNIQUE KEY `authorities_idx_1` (`username`,`authority`),
  CONSTRAINT `authorities_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

