package erp.vivian.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class BackupService {

    @Value("${spring.datasource.username}")
    private String dbUser;

    @Value("${spring.datasource.password}")
    private String dbPassword;

    public File gerarBackup() throws IOException, InterruptedException {
        // 1. Cria um nome de ficheiro com a data e hora atual (ex: backup_cambiomatic_20260222_1530.sql)
        String timeStamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
        String fileName = "backup_cambiomatic_" + timeStamp + ".sql";

        // 2. Define onde o ficheiro temporário será criado
        File backupFile = new File(System.getProperty("java.io.tmpdir"), fileName);

        // 3. Monta o comando do PostgreSQL (pg_dump)
        ProcessBuilder pb = new ProcessBuilder(
                "pg_dump",
                "-U", dbUser,
                "-h", "localhost",
                "-p", "5432",
                "-F", "p", // Formato texto SQL
                "-f", backupFile.getAbsolutePath(),
                "vivian_erp" // Nome do seu banco de dados
        );

        // Injeta a senha no terminal de forma invisível
        pb.environment().put("PGPASSWORD", dbPassword);

        // Executa a extração
        Process process = pb.start();
        int exitCode = process.waitFor();

        if (exitCode != 0) {
            throw new RuntimeException("Erro ao gerar backup. Código: " + exitCode);
        }

        return backupFile;
    }
}