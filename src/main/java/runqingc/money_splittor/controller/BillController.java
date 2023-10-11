package runqingc.money_splittor.controller;


import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import runqingc.money_splittor.entity.Bill;
import runqingc.money_splittor.service.BillService;

import java.util.List;

@Controller
@RequestMapping("/bills")
public class BillController {

    private BillService billService;

    public BillController(BillService theBillService) {
        billService = theBillService;
    }

    @GetMapping("/list")
    public String listBills(Model theModel){

        Sort sort = Sort.by(Sort.Order.desc("billId"));

        List<Bill> theBills = billService.findAll(sort);


        theModel.addAttribute("bills", theBills);

        return "list-bills";

    }

}
