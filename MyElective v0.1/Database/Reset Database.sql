SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS electives;
DROP TABLE IF EXISTS hours_per_week;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE  TABLE `my_elective`.`electives` (
  `id` int NOT NULL auto_increment,
  `elective_name` VARCHAR(200) NOT NULL ,  
  `description` VARCHAR(5000) NOT NULL,
  PRIMARY KEY (`id`) );   

CREATE  TABLE `my_elective`.`users` (
  `id` int NOT NULL auto_increment,
  `user_name` VARCHAR(200) NOT NULL ,  
  `password` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(75) NOT NULL,
  `program` VARCHAR(200) NOT NULL,
  `email_address` VARCHAR(200) NOT NULL,
  `status` VARCHAR(5),
  PRIMARY KEY (`id`) );

CREATE  TABLE `my_elective`.`ratings` (
  `id` int NOT NULL auto_increment,
  `rating` int NOT NULL,
  `electives_id` int NOT NULL,
  `users_id` int NOT NULL,
  FOREIGN KEY (`electives_id`) REFERENCES electives(`id`),
  PRIMARY KEY (`id`) );

CREATE  TABLE `my_elective`.`hours_per_week` (
  `id` int NOT NULL auto_increment,
  `hours_spent` int NOT NULL,
  `electives_id` int NOT NULL,
  `users_id` int NOT NULL,
  FOREIGN KEY (`electives_id`) REFERENCES electives(`id`),
  FOREIGN KEY (`users_id`) REFERENCES users(`id`),
  PRIMARY KEY (`id`) );

CREATE  TABLE `my_elective`.`comments` (
  `id` int NOT NULL auto_increment,
  `comment` varchar(5000) NOT NULL,
  `date` datetime NOT NULL,
  `electives_id` int NOT NULL,
  `users_id` int NOT NULL,
  FOREIGN KEY (`electives_id`) REFERENCES electives(`id`),
  FOREIGN KEY (`users_id`) REFERENCES users(`id`),
  PRIMARY KEY (`id`) );

INSERT INTO `my_elective`.`users` (`user_name`, `password`, `first_name`, `last_name`, `program`, `email_address`, `status`) VALUES ('admin', 'password', 'Kyle', 'Usherwood', 'Computer Engineering - Computer Science', 'ushe0010@algonquinlive.com', 'admin');