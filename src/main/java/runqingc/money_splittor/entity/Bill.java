package runqingc.money_splittor.entity;

import jakarta.persistence.*;

import java.sql.Timestamp;

@Entity
@Table(name = "bill1")
public class Bill {

    // define fields
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "BillID")
    private Integer billID;


    @Column(name = "BillName")
    private String billName;

    @Column(name = "Amount")
    private Double amount;

    @Column(name = "Payer")
    private String payer;

    @Column(name = "SplitBetween")
    private String splitBetween;

    @Column(name = "SplitBetween")
    private Boolean isSplit;

    @Column(name = "BillDate")
    private Timestamp billDate;

    // define constructor
    public Bill() {
    }

    public Bill(Integer billId, String billName, Double amount, String payer, String splitBetween) {
        this.billID = billId;
        this.billName = billName;
        this.amount = amount;
        this.payer = payer;
        this.splitBetween = splitBetween;
    }

    public Bill(Integer billId, String billName, Double amount, String payer, String splitBetween, Boolean isSplit, Timestamp billDate) {
        this.billID = billId;
        this.billName = billName;
        this.amount = amount;
        this.payer = payer;
        this.splitBetween = splitBetween;
        this.isSplit = isSplit;
        this.billDate = billDate;
    }

    // define getter and setter
    public Integer getBillID() {
        return billID;
    }

    public void setBillID(Integer billId) {
        this.billID = billId;
    }

    public String getBillName() {
        return billName;
    }

    public void setBillName(String billName) {
        this.billName = billName;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getPayer() {
        return payer;
    }

    public void setPayer(String payer) {
        this.payer = payer;
    }

    public String getSplitBetween() {
        return splitBetween;
    }

    public void setSplitBetween(String splitBetween) {
        this.splitBetween = splitBetween;
    }

    public Boolean getSplit() {
        return isSplit;
    }

    public void setSplit(Boolean split) {
        isSplit = split;
    }

    public Timestamp getBillDate() {
        return billDate;
    }

    public void setBillDate(Timestamp billDate) {
        this.billDate = billDate;
    }

    // define toString methods

    @Override
    public String toString() {
        return "Bill{" +
                "billId=" + billID +
                ", billName='" + billName + '\'' +
                ", amount=" + amount +
                ", payer='" + payer + '\'' +
                ", splitBetween='" + splitBetween + '\'' +
                ", isSplit=" + isSplit +
                ", billDate=" + billDate +
                '}';
    }
}
