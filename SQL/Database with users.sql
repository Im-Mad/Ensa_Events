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
                         `enabled` int NOT NULL DEFAULT 1,
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
INSERT INTO role VALUES (2,'ROLE_MANAGER');
INSERT INTO role VALUES (3,'ROLE_ADMIN');

INSERT INTO users (username,password,first_name,last_name,email,avatar,enabled,id_role) VALUES ('imad','$2a$12$oZEDTV31MEz/J1FyE9LRZel.S5mR6sd9wntQ7J5ZOfqc8Wz.TYJva','imad','chaichaa','imadchai2@gmail.com','default.png',1,3);
INSERT INTO users (username,password,first_name,last_name,email,avatar,enabled,id_role) VALUES ('rachid','$2a$12$oZEDTV31MEz/J1FyE9LRZel.S5mR6sd9wntQ7J5ZOfqc8Wz.TYJva','rachid','el aissaoui','rachid@gmail.com','default.png',1,2);
INSERT INTO users (username,password,first_name,last_name,email,avatar,enabled,id_role) VALUES ('hajarE','$2a$12$oZEDTV31MEz/J1FyE9LRZel.S5mR6sd9wntQ7J5ZOfqc8Wz.TYJva','hajar','el ansary','hajarE@gmail.com','default.png',1,2);
INSERT INTO users (username,password,first_name,last_name,email,avatar,enabled,id_role) VALUES ('hajarS','$2a$12$oZEDTV31MEz/J1FyE9LRZel.S5mR6sd9wntQ7J5ZOfqc8Wz.TYJva','hajar','saadani','hajarS@gmail.com','default.png',1,2);
INSERT INTO users (username,password,first_name,last_name,email,avatar,enabled,id_role) VALUES ('iliass','$2a$12$oZEDTV31MEz/J1FyE9LRZel.S5mR6sd9wntQ7J5ZOfqc8Wz.TYJva','mohamed iliass','boutahar','iliass@gmail.com','default.png',1,2);
INSERT INTO users (username,password,first_name,last_name,email,avatar,enabled,id_role) VALUES ('user1','$2a$12$oZEDTV31MEz/J1FyE9LRZel.S5mR6sd9wntQ7J5ZOfqc8Wz.TYJva','user1','user_lastname','user_email@gmail.com','default.png',1,1);
INSERT INTO users (username,password,first_name,last_name,email,avatar,enabled,id_role) VALUES ('user2','$2a$12$oZEDTV31MEz/J1FyE9LRZel.S5mR6sd9wntQ7J5ZOfqc8Wz.TYJva','user2','user_lastname','user_email@gmail.com','default.png',1,1);
INSERT INTO users (username,password,first_name,last_name,email,avatar,enabled,id_role) VALUES ('user3','$2a$12$oZEDTV31MEz/J1FyE9LRZel.S5mR6sd9wntQ7J5ZOfqc8Wz.TYJva','user3','user_lastname','user_email@gmail.com','default.png',1,1);

INSERT INTO club (name,description,logo,coverphoto,user_id) VALUES ('RachidClub','DESCRIPTION RACHID CLUB','default.png','default.png',2);
INSERT INTO club (name,description,logo,coverphoto,user_id) VALUES ('HajarEClub','DESCRIPTION HAJAR EL ANSARY CLUB','default.png','default.png',3);
INSERT INTO club (name,description,logo,coverphoto,user_id) VALUES ('HajarSClub','DESCRIPTION HAJAR SAADANI CLUB','default.png','default.png',4);
INSERT INTO club (name,description,logo,coverphoto,user_id) VALUES ('IliassClub','DESCRIPTION ILIASS CLUB','default.png','default.png',5);

INSERT INTO event (date,name,description,coverphoto,club_id) VALUES ('8 November 2021','Club Meeting','A meeting to know each others !','default.png',1);
INSERT INTO event (date,name,description,coverphoto,club_id) VALUES ('17 Septembre 2021','Movie Partie','Let\'t watch a movie all together !','default.png',1);
INSERT INTO event (date,name,description,coverphoto,club_id) VALUES ('20 April 2021','Let\'s Code','Coding Party !','default.png',1);
INSERT INTO event (date,name,description,coverphoto,club_id) VALUES ('7 February 2021','Integration','A day to know new people !','default.png',1);

INSERT INTO review (user_id,event_id,description,rating) VALUES (6,2,'Great',4);
INSERT INTO review (user_id,event_id,description,rating) VALUES (6,4,'Bad',1);
INSERT INTO review (user_id,event_id,description,rating) VALUES (7,1,'NIIICE MEETING',5);
INSERT INTO review (user_id,event_id,description,rating) VALUES (8,2,'YAAAAHOUUUW',5);
INSERT INTO review (user_id,event_id,description,rating) VALUES (8,3,'???',2);

SET FOREIGN_KEY_CHECKS = 1;
