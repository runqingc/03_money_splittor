CREATE DATABASE  IF NOT EXISTS `bill_tracker`;
USE `bill_tracker`;

--
-- Table structure for table `bill`
--

DROP TABLE IF EXISTS `bill`;

CREATE TABLE bill(
                     bill_id INT AUTO_INCREMENT PRIMARY KEY,
                     bill_name VARCHAR(50),
                     amount double,
                     payer VARCHAR(10),
                     split_between VARCHAR(10),
                     complete boolean DEFAULT false,
                     bill_date timestamp not null default (CURRENT_TIMESTAMP)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

