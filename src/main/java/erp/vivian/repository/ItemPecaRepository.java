package erp.vivian.repository;

import erp.vivian.model.ItemPeca;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ItemPecaRepository extends JpaRepository<ItemPeca, Long> {
}