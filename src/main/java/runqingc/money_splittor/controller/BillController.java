package runqingc.money_splittor.controller;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import runqingc.money_splittor.entity.Bill;
import runqingc.money_splittor.service.BillService;

import java.util.List;

@Controller
@RequestMapping("/bills")
public class BillController {

    @Value("Chose Payer,CRQ,JMH,SSC")
    private List<String> payers;

    @Value("Chose Split between,CRQ,JMH,SSC,ALL,RENT,SSC&CRQ,CRQ&JMH,SSC&JMH")
    private List<String> splitBetweens;

    private BillService billService;

    public BillController(BillService theBillService) {
        billService = theBillService;
    }

    @GetMapping("/list")
    public String listBills(Model theModel){

        // add unpaid bills
        Sort sort = Sort.by(Sort.Order.desc("billDate"));

        List<Bill> theBills = billService.findByCompleteFalse(sort);

        theModel.addAttribute("bills", theBills);

        // calculate how to split the money
        double crqToSsc = calculateCrqToSscAmount(theBills);
        double jmhToSsc = calculateJmhToSscAmount(theBills);
        double jmhToCrq = calculateJmhToCrqAmount(theBills);

        String simplified = simplifyPayments(crqToSsc, jmhToSsc, jmhToCrq);

        String crq_ssc, jmh_ssc, jmh_crq;
        if(crqToSsc>=0){
            crq_ssc = "CRQ应该付给SSC的钱";
        }else{
            crq_ssc = "SSC应该付给CRQ的钱";
            crqToSsc *= -1;
        }
        if(jmhToSsc>=0){
            jmh_ssc="JMH应该付给SSC的钱";
        }else{
            jmh_ssc = "SSC应该付给JMH的钱";
            jmhToSsc *=-1;
        }
        if(jmhToCrq>=0){
            jmh_crq="JMH应该付给CRQ的钱";
        }else{
            jmh_crq="CRQ应该付给JMH的钱";
            jmhToCrq*=-1;
        }

        theModel.addAttribute("crqToSsc", crqToSsc);
        theModel.addAttribute("crq_ssc", crq_ssc);
        theModel.addAttribute("jmhToSsc", jmhToSsc);
        theModel.addAttribute("jmh_ssc", jmh_ssc);
        theModel.addAttribute("jmhToCrq", jmhToCrq);
        theModel.addAttribute("jmh_crq", jmh_crq);
        theModel.addAttribute("simplified", simplified);



//        add history bills
        List<Bill> historyBills = billService.findByCompleteTrue(sort);
        theModel.addAttribute("historyBills", historyBills);

        return "bills/list-bills";

    }

    @GetMapping("/showFormForAdd")
    public String showFormForAdd(Model theModel){

        //create model attribute to bind form data
        Bill theBill = new Bill();

        theModel.addAttribute(theBill);

        theModel.addAttribute("payers", payers);

        theModel.addAttribute("splitBetweens", splitBetweens);

        return "bills/bill-form";
    }

    @GetMapping("/showFormForUpdate")
    public String showFormForAdd(@RequestParam("billId")int theId, Model theModel){
        // get the bill from the service
        Bill theBill = billService.findById(theId);

        // set employee in the model to prepopulate the form
        theModel.addAttribute("bill", theBill);

        theModel.addAttribute("payers", payers);

        theModel.addAttribute("splitBetweens", splitBetweens);

        return "bills/bill-form";
    }

    @PostMapping("/save")
    public String saveBill(@ModelAttribute("bill") Bill theBill){

        // save the bill
        billService.save(theBill);

        // use a redirect to prevent duplicate submission
        return "redirect:/bills/list";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("billId")int theId){
        // delete the bill item
        billService.deleteById(theId);

        //redirect to the /bills/list
        return "redirect:/bills/list";
    }


    private static final double sscRent = 0.37;
    private static final double crqRent = 0.32;
    private static final double jmhRent = 0.31;

    private double calculateCrqToSscAmount(List<Bill> bills){
        double totalAmount = 0.0;
        for (Bill bill : bills){
            if(bill.getPayer().equals("CRQ")){
                switch (bill.getSplitBetween()) {
                    case "SSC" -> totalAmount -= bill.getAmount();
                    case "SSC&CRQ", "SSC&JMH" -> totalAmount -= bill.getAmount() / 2;
                    case "ALL" -> totalAmount -= bill.getAmount() / 3;
                    case "RENT" -> totalAmount -= bill.getAmount() * sscRent;
                }
            }else if(bill.getPayer().equals("SSC")){
                switch (bill.getSplitBetween()) {
                    case "CRQ" -> totalAmount += bill.getAmount();
                    case "SSC&CRQ", "CRQ&JMH" -> totalAmount += bill.getAmount() / 2;
                    case "ALL" -> totalAmount += bill.getAmount() / 3;
                    case "RENT" -> totalAmount += bill.getAmount() * crqRent;
                }
            }
        }
        return totalAmount;
    }

    private double calculateJmhToSscAmount(List<Bill> bills){
        double totalAmount = 0.0;
        for (Bill bill : bills){
            if(bill.getPayer().equals("JMH")){
                switch (bill.getSplitBetween()) {
                    case "SSC" -> totalAmount -= bill.getAmount();
                    case "SSC&CRQ", "SSC&JMH" -> totalAmount -= bill.getAmount() / 2;
                    case "ALL" -> totalAmount -= bill.getAmount() / 3;
                    case "RENT" -> totalAmount -= bill.getAmount() * sscRent;
                }
            }else if(bill.getPayer().equals("SSC")){
                switch (bill.getSplitBetween()) {
                    case "JMH" -> totalAmount += bill.getAmount();
                    case "SSC&JMH", "CRQ&JMH" -> totalAmount += bill.getAmount() / 2;
                    case "ALL" -> totalAmount += bill.getAmount() / 3;
                    case "RENT" -> totalAmount += bill.getAmount() * jmhRent;
                }
            }
        }
        return totalAmount;
    }

    private double calculateJmhToCrqAmount(List<Bill> bills){
        double totalAmount = 0.0;
        for (Bill bill : bills){
            if(bill.getPayer().equals("JMH")){
                switch (bill.getSplitBetween()) {
                    case "CRQ" -> totalAmount -= bill.getAmount();
                    case "SSC&CRQ", "CRQ&JMH" -> totalAmount -= bill.getAmount() / 2;
                    case "ALL" -> totalAmount -= bill.getAmount() / 3;
                    case "RENT" -> totalAmount -= bill.getAmount() * crqRent;
                }
            }else if(bill.getPayer().equals("CRQ")){
                switch (bill.getSplitBetween()) {
                    case "JMH" -> totalAmount += bill.getAmount();
                    case "SSC&JMH", "CRQ&JMH" -> totalAmount += bill.getAmount() / 2;
                    case "ALL" -> totalAmount += bill.getAmount() / 3;
                    case "RENT" -> totalAmount += bill.getAmount() * jmhRent;
                }
            }
        }
        return totalAmount;
    }

    public static String simplifyPayments(double crqToSsc, double jmhToSsc, double jmhToCrq) {
        return "这里还需要实现一个函数来简化以上计算结果： \n" +
                "public static String simplifyPayments(double crqToSsc, double jmhToSsc, double jmhToCrq). \n" +
                "它的返回值将会显示在这里";
    }
}
