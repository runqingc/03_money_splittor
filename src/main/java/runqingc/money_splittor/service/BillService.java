package runqingc.money_splittor.service;

import org.springframework.data.domain.Sort;
import runqingc.money_splittor.entity.Bill;

import java.util.List;

public interface BillService {

    List<Bill> findAll(Sort sort);

}
