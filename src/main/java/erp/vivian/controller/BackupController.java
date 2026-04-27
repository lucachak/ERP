package erp.vivian.controller;

import erp.vivian.service.BackupService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.File;

@Controller
@RequestMapping("/backup")
@RequiredArgsConstructor
public class BackupController {

    private final BackupService backupService;

    @GetMapping("/download")
    public ResponseEntity<?> baixarBackup() {
        try {
            File arquivo = backupService.gerarBackup();
            FileSystemResource resource = new FileSystemResource(arquivo);

            return ResponseEntity.ok()
                    // Diz ao navegador para forçar o download com o nome do ficheiro gerado
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + arquivo.getName() + "\"")
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .contentLength(arquivo.length())
                    .body(resource);

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Erro ao gerar backup: " + e.getMessage() +
                    ". (Verifique se a pasta 'bin' do PostgreSQL está nas Variáveis de Ambiente do seu computador).");
        }
    }
}