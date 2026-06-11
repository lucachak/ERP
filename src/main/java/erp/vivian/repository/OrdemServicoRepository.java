package erp.vivian.repository;

import erp.vivian.model.OrdemServico;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface OrdemServicoRepository extends JpaRepository<OrdemServico, Long> {

    Optional<OrdemServico> findByNumeroOs(String numeroOs);

    @EntityGraph(attributePaths = {"cliente", "veiculo"})
    Page<OrdemServico> findAll(Pageable pageable);

    @EntityGraph(attributePaths = {"cliente", "veiculo"})
    @Query("SELECT os FROM OrdemServico os WHERE " +
            "LOWER(os.numeroOs) LIKE LOWER(CONCAT('%', :termo, '%')) OR " +
            "LOWER(os.cliente.nome) LIKE LOWER(CONCAT('%', :termo, '%')) OR " +
            "LOWER(os.veiculo.placaChassi) LIKE LOWER(CONCAT('%', :termo, '%'))")
    Page<OrdemServico> pesquisar(@Param("termo") String termo, Pageable pageable);

    long countBySituacao(String situacao);

    @Query("SELECT os.situacao, COUNT(os) FROM OrdemServico os GROUP BY os.situacao")
    List<Object[]> countAgrupadoPorSituacao();

    @Query(value = "SELECT COALESCE(AVG(EXTRACT(EPOCH FROM (data_entrega - data_emissao)) / 3600.0), 0) FROM ordens_servico WHERE situacao IN ('Encerrada', 'Paga') AND data_entrega IS NOT NULL AND data_emissao IS NOT NULL", nativeQuery = true)
    Double calcularTempoMedioHoras();

    @Query("SELECT COALESCE(SUM(os.valorTotal), 0) FROM OrdemServico os WHERE (os.situacao = 'Encerrada' OR os.situacao = 'Paga') AND os.dataEntrega >= :inicioMes AND os.dataEntrega <= :fimMes")
    BigDecimal somarFaturamentoMensal(@Param("inicioMes") LocalDateTime inicioMes, @Param("fimMes") LocalDateTime fimMes);

    @EntityGraph(attributePaths = {"cliente", "veiculo"})
    List<OrdemServico> findTop5ByOrderByDataEmissaoDesc();

    List<OrdemServico> findByClienteIdOrderByDataEmissaoDesc(Long clienteId);

    List<OrdemServico> findBySituacao(String situacao);

    // Método para a busca em tempo real do Kanban
    @EntityGraph(attributePaths = {"cliente", "veiculo"})
    @Query("SELECT o FROM OrdemServico o WHERE o.situacao = :situacao AND " +
            "(:termo IS NULL OR :termo = '' OR " +
            "LOWER(o.cliente.nome) LIKE LOWER(CONCAT('%', :termo, '%')) OR " +
            "LOWER(o.numeroOs) LIKE LOWER(CONCAT('%', :termo, '%')) OR " +
            "LOWER(o.veiculo.placaChassi) LIKE LOWER(CONCAT('%', :termo, '%')))")
    List<OrdemServico> buscarNoKanban(@Param("situacao") String situacao, @Param("termo") String termo);
}