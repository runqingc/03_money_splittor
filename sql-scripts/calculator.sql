USE bills;
DROP VIEW IF EXISTS TotalSplit;

CREATE VIEW TotalSplit AS
SELECT 'CRQ应该付给SSC的钱'
UNION
# SSC->CRQ - (CRQ->SSC)
SELECT (
    IFNULL((SELECT SUM(Amount)
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'CRQ'),0)
    +
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'CRQ&JMH'),0)
        +
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'SSC&CRQ'),0)
    +
    IFNULL((SELECT SUM(Amount)/3
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'ALL'),0)
    +
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM rentRatio WHERE Name='CRQ')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'RENT'),0)
    +
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM foodRatio WHERE Name='CRQ')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'FOOD'),0)
    -
    IFNULL((SELECT SUM(Amount)
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'SSC'),0)
    -
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1 
     WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'SSC&JMH'),0)
        -
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'SSC&CRQ'),0)
    -
    IFNULL((SELECT SUM(Amount)/3
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'ALL'),0)
    -
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM rentRatio WHERE Name='SSC')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'RENT'),0)
    -
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM foodRatio WHERE Name='SSC')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'FOOD'),0)
    )

UNION
SELECT 'JMH应该付给SSC的钱'
UNION
# SSC->JMH - (JMH->SSC)
SELECT (
    IFNULL((SELECT SUM(Amount)
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'JMH'),0)
    +
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'CRQ&JMH'),0)
    +
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'SSC&JMH'),0)
    +
    IFNULL((SELECT SUM(Amount)/3
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'ALL'),0)
    +
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM rentRatio WHERE Name='JMH')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'RENT'),0)
    +
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM foodRatio WHERE Name='JMH')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'SSC' AND SplitBetween = 'FOOD'),0)
    -
    IFNULL((SELECT SUM(Amount)
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'SSC'),0)
    -
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'SSC&CRQ'),0)
        -
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'SSC&JMH'),0)
    -
    IFNULL((SELECT SUM(Amount)/3
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'ALL'),0)
    -
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM rentRatio WHERE Name='SSC')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'RENT'),0)
    -
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM foodRatio WHERE Name='SSC')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'FOOD'),0)
    )

UNION
SELECT 'JMH应该付给CRQ的钱'
UNION
# CRQ->JMH - (JMH->CRQ)
SELECT (
    IFNULL((SELECT SUM(Amount)
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'JMH'),0)
    +
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'SSC&JMH'),0)
        +
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'CRQ&JMH'),0)
    +
    IFNULL((SELECT SUM(Amount)/3
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'ALL'),0)
    +
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM rentRatio WHERE Name='JMH')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'RENT'),0)
    +
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM foodRatio WHERE Name='JMH')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'CRQ' AND SplitBetween = 'FOOD'),0)
    -
    IFNULL((SELECT SUM(Amount)
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'CRQ'),0)
    -
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'SSC&CRQ'),0)
        -
    IFNULL((SELECT SUM(Amount)/2
     FROM bill1
     WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'CRQ&JMH'),0)
    -
    IFNULL((SELECT SUM(Amount)/3
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'ALL'),0)
    -
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM rentRatio WHERE Name='CRQ')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'RENT'),0)
    -
    IFNULL((SELECT SUM(Amount)*(SELECT Ratio FROM foodRatio WHERE Name='CRQ')
    FROM bill1
    WHERE IsSplit is FALSE AND Payer = 'JMH' AND SplitBetween = 'FOOD'),0)
    ) ;
