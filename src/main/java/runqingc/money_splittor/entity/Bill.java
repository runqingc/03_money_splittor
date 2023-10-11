package runqingc.money_splittor.entity;

import jakarta.persistence.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.sql.Timestamp;

@Entity
@EntityListeners(AuditingEntityListener.class)
@Table(name="bill")
public class Bill {
    // define fields
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bill_id")
    private int bill_id;

    @Column(name="bill_name")
    private String billName;

    @Column(name="amount")
    private double amount;

    @Column(name="payer")
    private String payer;

    @Column(name="split_between")
    private String splitBetween;

    @Column(name="complete")
    private Boolean complete;

    @Temporal(TemporalType.DATE)
    @Column(name="bill_date")
    @CreatedDate
    private String billDate;

    public Bill() {
    }


    // define constructor
    public Bill(int bill_id, String billName, double amount, String payer, String splitBetween, Boolean complete, String billDate) {
        this.bill_id = bill_id;
        this.billName = billName;
        this.amount = amount;
        this.payer = payer;
        this.splitBetween = splitBetween;
        this.complete = complete;
        this.billDate = billDate;
    }

    // define getter and setter
    public int getBill_id() {
        return bill_id;
    }

    public void setBill_id(int bill_id) {
        this.bill_id = bill_id;
    }

    public String getBillName() {
        return billName;
    }

    public void setBillName(String billName) {
        this.billName = billName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
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

    public Boolean getComplete() {
        return complete;
    }

    public void setComplete(Boolean complete) {
        this.complete = complete;
    }

    public String getBillDate() {
        return billDate;
    }

    public void setBillDate(String billDate) {
        this.billDate = billDate;
    }

    // define toString methods
    @Override
    public String toString() {
        return "Bill{" +
                "bill_id=" + bill_id +
                ", billName='" + billName + '\'' +
                ", amount=" + amount +
                ", payer='" + payer + '\'' +
                ", splitBetween='" + splitBetween + '\'' +
                ", complete=" + complete +
                ", billDate='" + billDate + '\'' +
                '}';
    }

}
