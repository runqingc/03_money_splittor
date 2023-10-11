# DATABASE DEFINITION
USE bills;

CREATE TABLE bill1(
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    BillName VARCHAR(50),
    Amount double,
    Payer VARCHAR(10),
    SplitBetween VARCHAR(10),
    IsSplit boolean DEFAULT false,
    BillDate timestamp default (CURRENT_TIMESTAMP)
);

CREATE TABLE rentRatio(
    Name VARCHAR(20) PRIMARY KEY ,
    Ratio double,
    Remark VARCHAR(50)
);

INSERT INTO rentRatio(Name, Ratio) VALUES
  ('SSC', '0.37'),
  ('CRQ', '0.32'),
  ('JMH', '0.31');

CREATE TABLE foodRatio(
    Name VARCHAR(20) PRIMARY KEY ,
    Ratio double,
    Remark VARCHAR(50)
);

INSERT INTO foodRatio(Name, Ratio) VALUES
  ('SSC', '0.3'),
  ('CRQ', '0.4'),
  ('JMH', '0.3');



