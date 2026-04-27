package erp.vivian.repository;

import erp.vivian.model.Peca;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PecaRepository extends JpaRepository<Peca, Long> {

    // NOVO: Conta quantas peças estão com estoque abaixo ou igual a um valor (ex: 2.0)
    long countByQuantidadeEstoqueLessThanEqual(Double quantidadeMinima);
}