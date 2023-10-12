USE bill_tracker;

INSERT INTO bill(bill_name, amount, payer, split_between) VALUES
                                                              ('电池和面', '4.87','CRQ','JMH'),
                                                              ('薯片', '4.99','CRQ','SSC'),
                                                              ('88购物', '91.29','CRQ','ALL'),
                                                              ('88购物', '91.29','CRQ','FOOD'),
                                                              ('88打车来回', 14.84+14.77,'CRQ','ALL'),
                                                              ('target买碗杯子hdmi等', 32,'CRQ','ALL'),
                                                              ('jewel osco', 0.99+1.5,'CRQ','SSC'),
                                                              ('jewel osco', 0.99+1.47,'CRQ','JMH'),
                                                              ('jewel osco', 101.05-0.99-1.5-0.99-1.47,'CRQ','FOOD'),
                                                              ('缺德舅三文鱼', 9.81,'CRQ','JMH'),
                                                              ('缺德舅纸巾', 3.99+0.41,'CRQ','ALL'),
                                                              ('缺德舅食品', 17.44-3.99-0.41,'CRQ','FOOD'),
                                                              ('88购物', 48.61,'JMH','FOOD');