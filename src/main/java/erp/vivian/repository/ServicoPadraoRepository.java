package erp.vivian.repository;

import erp.vivian.model.ServicoPadrao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServicoPadraoRepository extends JpaRepository<ServicoPadrao, Long> {
}