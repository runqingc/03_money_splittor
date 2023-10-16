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

    @Value("Chose Split between,CRQ,JMH,SSC,FOOD,RENT,SSC&CRQ,CRQ&JMH,SSC&JMH")
    private List<String> splitBetweens;

    private BillService billService;

    public BillController(BillService theBillService) {
        billService = theBillService;
    }

    @GetMapping("/list")
    public String listBills(Model theModel){

        Sort sort = Sort.by(Sort.Order.desc("billId"));

        List<Bill> theBills = billService.findAll(sort);

        theModel.addAttribute("bills", theBills);

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

}
