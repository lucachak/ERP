package erp.vivian.service;

import erp.vivian.dto.ServicoPadraoDTO;
import erp.vivian.model.ServicoPadrao;
import erp.vivian.repository.ServicoPadraoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ServicoPadraoService {

    private final ServicoPadraoRepository repository;

    public List<ServicoPadrao> listarTodos() {
        return repository.findAll(Sort.by(Sort.Direction.ASC, "descricao"));
    }

    public void salvarServico(ServicoPadraoDTO dto) {
        ServicoPadrao servico;
        if (dto.id() != null) {
            servico = repository.findById(dto.id()).orElseThrow(() -> new IllegalArgumentException("Serviço não encontrado"));
        } else {
            servico = new ServicoPadrao();
        }
        servico.setDescricao(dto.descricao().toUpperCase());
        servico.setValorPadrao(dto.valorPadrao());
        repository.save(servico);
    }

    public void excluir(Long id) {
        repository.deleteById(id);
    }

    public ServicoPadrao buscarPorId(Long id) {
        return repository.findById(id).orElseThrow(() -> new IllegalArgumentException("Serviço não encontrado"));
    }
}