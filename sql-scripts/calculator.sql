USE bill_tracker;

DROP VIEW IF EXISTS Balance;

CREATE VIEW Balance AS
WITH
    crq_should_pay_ssc AS (
        SELECT (
                           IFNULL((SELECT SUM(amount)
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'CRQ'),0)
                           +
                           IFNULL((SELECT SUM(amount)/2
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'CRQ&JMH'),0)
                           +
                           IFNULL((SELECT SUM(amount)/2
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'CRQ&SSC'),0)
                           +
                           IFNULL((SELECT SUM(amount)/3
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'ALL'),0)
                           +
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM rentRatio WHERE Name='CRQ')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'RENT'),0)
                           +
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM foodRatio WHERE Name='CRQ')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'FOOD'),0)
                       -
                           IFNULL((SELECT SUM(amount)
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'SSC'),0)
                       -
                           IFNULL((SELECT SUM(amount)/2
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'SSC&JMH'),0)
                       -
                           IFNULL((SELECT SUM(amount)/2
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'CRQ&SSC'),0)
                       -
                           IFNULL((SELECT SUM(amount)/3
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'ALL'),0)
                       -
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM rentRatio WHERE Name='SSC')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'RENT'),0)
                       -
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM foodRatio WHERE Name='SSC')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'FOOD'),0)
                   ) AS Totalamount
    ) ,

    jmh_should_pay_ssc AS (
        SELECT (
                           IFNULL((SELECT SUM(amount)
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'JMH'),0)
                           +
                           IFNULL((SELECT SUM(amount)/2
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'CRQ&JMH'),0)
                           +
                           IFNULL((SELECT SUM(amount)/3
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'ALL'),0)
                           +
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM rentRatio WHERE Name='JMH')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'RENT'),0)
                           +
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM foodRatio WHERE Name='JMH')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'SSC' AND split_between = 'FOOD'),0)
                       -
                           IFNULL((SELECT SUM(amount)
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'JMH' AND split_between = 'SSC'),0)
                       -
                           IFNULL((SELECT SUM(amount)/2
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'JMH' AND split_between = 'SSC&CRQ'),0)
                       -
                           IFNULL((SELECT SUM(amount)/3
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'JMH' AND split_between = 'ALL'),0)
                       -
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM rentRatio WHERE Name='SSC')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'JMH' AND split_between = 'RENT'),0)
                       -
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM foodRatio WHERE Name='SSC')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'JMH' AND split_between = 'FOOD'),0)
                   ) AS Totalamount
    ),
    jmh_should_pay_crq AS (
        SELECT (
                           IFNULL((SELECT SUM(amount)
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'JMH'),0)
                           +
                           IFNULL((SELECT SUM(amount)/2
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'SSC&JMH'),0)
                           +
                           IFNULL((SELECT SUM(amount)/3
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'ALL'),0)
                           +
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM rentRatio WHERE Name='JMH')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'RENT'),0)
                           +
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM foodRatio WHERE Name='JMH')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'CRQ' AND split_between = 'FOOD'),0)
                       -
                           IFNULL((SELECT SUM(amount)
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'JMH' AND split_between = 'CRQ'),0)
                       -
                           IFNULL((SELECT SUM(amount)/2
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'JMH' AND split_between = 'SSC&CRQ'),0)
                       -
                           IFNULL((SELECT SUM(amount)/3
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'JMH' AND split_between = 'ALL'),0)
                       -
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM rentRatio WHERE Name='CRQ')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'JMH' AND split_between = 'RENT'),0)
                       -
                           IFNULL((SELECT SUM(amount)*(SELECT Ratio FROM foodRatio WHERE Name='CRQ')
                                   FROM bill
                                   WHERE complete is FALSE AND Payer = 'JMH' AND split_between = 'FOOD'),0)
                   ) AS Totalamount
    )

SELECT
    COALESCE(crq_should_pay_ssc.Totalamount, 0) AS CRQ应该付给SSC的钱,
    COALESCE(jmh_should_pay_ssc.Totalamount, 0) AS JMH应该付给SSC的钱,
    COALESCE(jmh_should_pay_crq.Totalamount, 0) AS JMH应该付给CRQ的钱
FROM
    crq_should_pay_ssc,
    jmh_should_pay_ssc,
    jmh_should_pay_crq