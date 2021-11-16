/*
SCRIPT 2
*/
DROP DATABASE  IF EXISTS `ensa_events`;

CREATE DATABASE  IF NOT EXISTS `ensa_events`;
USE `ensa_events`;

CREATE TABLE `role` (
                        `id` INT NOT NULL AUTO_INCREMENT,
                        `name` varchar(50) DEFAULT NULL,
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
                         `id` int NOT NULL AUTO_INCREMENT,
                         `username` varchar(50) NOT NULL,
                         `password` char(68) NOT NULL,
                         `first_name` char(50) NOT NULL,
                         `last_name` char(50) NOT NULL,
                         `email` char(50) NOT NULL,
                         `avatar` varchar(50) NOT NULL,
                         `enabled` tinyint(1) NOT NULL DEFAULT 1,
                         `id_role` INT NOT NULL,
                         PRIMARY KEY (`id`),
                         FOREIGN KEY (id_role) references role (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Club` (
                        `id` INT  NOT NULL AUTO_INCREMENT,
                        `name` char(50) NOT NULL,
                        `description` char(50) NOT NULL,
                        `logo` char(50) NOT NULL,
                        `coverphoto` char(50) NOT NULL,
                        `user_id` INT NOT NULL,
                        FOREIGN KEY (user_id) references users (id) on delete cascade,
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
                       id	INT NOT NULL auto_increment,
                       user_id INT NOT NULL,
                       event_id INT NOT NULL,
                       description varchar(50),
                       rating INT,
                       PRIMARY KEY (id),
                       FOREIGN KEY (user_id) references users (id) on delete cascade,
                       FOREIGN KEY (event_id)  references Event  (id) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



INSERT INTO role VALUES (1,'ROLE_USER');


SET FOREIGN_KEY_CHECKS = 1;
