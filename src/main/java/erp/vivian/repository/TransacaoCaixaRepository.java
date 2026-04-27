package erp.vivian.repository;

import erp.vivian.model.TransacaoCaixa;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface TransacaoCaixaRepository extends JpaRepository<TransacaoCaixa, Long> {

    // Busca as transações de um mês específico
    List<TransacaoCaixa> findByDataRegistroBetweenOrderByDataRegistroDesc(LocalDateTime inicio, LocalDateTime fim);

    // Soma os valores por tipo (Entrada ou Saída) num determinado período
    @Query("SELECT COALESCE(SUM(t.valor), 0) FROM TransacaoCaixa t WHERE t.tipo = :tipo AND t.dataRegistro >= :inicio AND t.dataRegistro <= :fim")
    BigDecimal somarPorTipo(@Param("tipo") String tipo, @Param("inicio") LocalDateTime inicio, @Param("fim") LocalDateTime fim);
}