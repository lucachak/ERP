package erp.vivian.repository;

import erp.vivian.model.Cliente;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ClienteRepository extends JpaRepository<Cliente, Long> {

    // Pesquisa Inteligente: Busca pelo Nome do Cliente, CPF ou até pela Placa do Carro dele!
    @Query("SELECT DISTINCT c FROM Cliente c LEFT JOIN Veiculo v ON v.cliente = c WHERE " +
            "LOWER(c.nome) LIKE LOWER(CONCAT('%', :termo, '%')) OR " +
            "c.cpfCnpj LIKE CONCAT('%', :termo, '%') OR " +
            "LOWER(v.placaChassi) LIKE LOWER(CONCAT('%', :termo, '%'))")
    Page<Cliente> pesquisarCRM(@Param("termo") String termo, Pageable pageable);
}