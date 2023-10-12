package runqingc.money_splittor.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import runqingc.money_splittor.dao.BillRepository;
import runqingc.money_splittor.entity.Bill;

import java.util.List;
import java.util.Optional;

@Service
public class BillServiceImpl implements BillService{

    private BillRepository billRepository;

    @Autowired
    public BillServiceImpl(BillRepository theBillRepository){
        billRepository = theBillRepository;
    }

    @Override
    public List<Bill> findAll(Sort sort) {
        return billRepository.findAll(sort);
    }

    @Override
    public void save(Bill theBill) {
        billRepository.save(theBill);
    }

    @Override
    public Bill findById(int theId) {
        Optional<Bill> result = billRepository.findById(theId);

        Bill theBill = null;

        if(result.isPresent()){
            theBill = result.get();
        }else{
            throw new RuntimeException("Did not find bill id : " + theId);
        }
        return theBill;
    }

    @Override
    public void deleteById(int theId) {
        billRepository.deleteById(theId);
    }


}
