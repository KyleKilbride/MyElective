create database my_elective;  
  
use my_elective;  
  
CREATE  TABLE `my_elective`.`electives` (
  `id` int NOT NULL,
  `elective_name` VARCHAR(200) NOT NULL ,  
  `description` VARCHAR(5000) NOT NULL,
  PRIMARY KEY (`id`) );   

CREATE  TABLE `my_elective`.`users` (
  `id` int NOT NULL,
  `user_name` VARCHAR(200) NOT NULL ,  
  `password` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(75) NOT NULL,
  `program` VARCHAR(200) NOT NULL,
  `email_address` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`) );   

CREATE  TABLE `my_elective`.`ratings` (
  `id` int NOT NULL,
  `rating` int NOT NULL,
  `electives_id` int NOT NULL,
  `users_id` int NOT NULL,
  FOREIGN KEY (`electives_id`) REFERENCES electives(`id`),
  PRIMARY KEY (`id`) );

CREATE  TABLE `my_elective`.`hours_per_week` (
  `id` int NOT NULL,
  `hours_spent` int NOT NULL,
  `electives_id` int NOT NULL,
  `users_id` int NOT NULL,
  FOREIGN KEY (`electives_id`) REFERENCES electives(`id`),
  FOREIGN KEY (`users_id`) REFERENCES users(`id`),
  PRIMARY KEY (`id`) );

CREATE  TABLE `my_elective`.`comments` (
  `id` int NOT NULL,
  `comment` varchar(5000) NOT NULL,
  `date` datetime NOT NULL,
  `electives_id` int NOT NULL,
  `users_id` int NOT NULL,
  FOREIGN KEY (`electives_id`) REFERENCES electives(`id`),
  FOREIGN KEY (`users_id`) REFERENCES users(`id`),
  PRIMARY KEY (`id`) );