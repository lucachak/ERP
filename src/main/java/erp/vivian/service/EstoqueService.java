package erp.vivian.service;

import erp.vivian.dto.PecaDTO;
import erp.vivian.model.Peca;
import erp.vivian.repository.PecaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EstoqueService {

    private final PecaRepository repository;

    public List<Peca> listarTodas() {
        // Traz as peças ordenadas por ordem alfabética
        return repository.findAll(Sort.by(Sort.Direction.ASC, "descricao"));
    }

    @Transactional
    public void salvarPeca(PecaDTO dto) {
        Peca peca = new Peca();
        peca.setCodigo(dto.codigo());
        peca.setDescricao(dto.descricao().toUpperCase());
        peca.setQuantidadeEstoque(dto.quantidadeEstoque());
        peca.setPrecoCusto(dto.precoCusto());
        peca.setPrecoVenda(dto.precoVenda());
        repository.save(peca);
    }
}