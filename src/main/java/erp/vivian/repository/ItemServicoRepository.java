package erp.vivian.repository;

import erp.vivian.dto.RelatorioComissaoDTO;
import erp.vivian.model.ItemServico;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ItemServicoRepository extends JpaRepository<ItemServico, Long> {

    @Query("SELECT new erp.vivian.dto.RelatorioComissaoDTO(i.tecnico, COUNT(i), SUM(i.valorTotal)) " +
            "FROM ItemServico i JOIN i.ordemServico os " +
            "WHERE os.situacao = 'Encerrada' " +
            "AND os.dataEntrega >= :inicio AND os.dataEntrega <= :fim " +
            "GROUP BY i.tecnico ORDER BY SUM(i.valorTotal) DESC")
    List<RelatorioComissaoDTO> gerarRelatorioComissoes(@Param("inicio") LocalDateTime inicio, @Param("fim") LocalDateTime fim);

}