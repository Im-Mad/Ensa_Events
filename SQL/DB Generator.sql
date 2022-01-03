/*
SCRIPT 2
*/
DROP DATABASE  IF EXISTS `ensa_events`;

CREATE DATABASE  IF NOT EXISTS `ensa_events`;
USE `ensa_events`;

CREATE TABLE `roles` (
                        `id` INT NOT NULL AUTO_INCREMENT,
                        `name` varchar(500) DEFAULT NULL,
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
                         `id` int NOT NULL AUTO_INCREMENT,
                         `username` varchar(50) NOT NULL,
                         `password` char(68) NOT NULL,
                         `first_name` char(50) NOT NULL,
                         `last_name` char(50) NOT NULL,
                         `email` char(50) NOT NULL,
                         `avatar` varchar(50) NOT NULL DEFAULT 'default.png',
                         `enabled` boolean NOT NULL DEFAULT true,
                         `id_role` INT NOT NULL,
                         PRIMARY KEY (`id`),
                         FOREIGN KEY (id_role) references roles (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `clubs` (
                        `id` INT  NOT NULL AUTO_INCREMENT,
                        `name` char(50) NOT NULL,
                        `description` varchar(500),
                        `logo` char(50) DEFAULT 'default.png',
                        `cover_photo` char(50) DEFAULT 'default.png',
                        `user_id` INT NOT NULL,
                        FOREIGN KEY (user_id) references users (id),
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `events` (
                         `id` INT  NOT NULL AUTO_INCREMENT,
                         `date` DATETIME NOT NULL,
                         `end_date` DATETIME NOT NULL,
                         `name` char(68) NOT NULL,
                         `description` varchar(500) ,
                         `cover_photo` varchar(50) NOT NULL DEFAULT 'default.png',
                         `club_id` INT NOT NULL,
                         `location` VARCHAR(20) NOT NULL,
                         FOREIGN KEY (club_id) references clubs (id) ,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `reviews` (
                       id	INT NOT NULL auto_increment,
                       user_id INT NOT NULL,
                       event_id INT NOT NULL,
                       description varchar(500),
                       date datetime DEFAULT now(),
                       rating INT DEFAULT 4,
                       PRIMARY KEY (id),
                       FOREIGN KEY (user_id) references users (id),
                       FOREIGN KEY (event_id)  references events  (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `participants` (
                       user_id INT NOT NULL,
                       event_id INT NOT NULL,
                       PRIMARY KEY (user_id,event_id),
                       FOREIGN KEY (user_id) references users (id) ,
                       FOREIGN KEY (event_id)  references events  (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `members` (
                       user_id INT NOT NULL,
                       club_id INT NOT NULL,
                       PRIMARY KEY (user_id,club_id),
                       FOREIGN KEY (user_id) references users (id) ,
                       FOREIGN KEY (club_id)  references clubs  (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS = 1;

