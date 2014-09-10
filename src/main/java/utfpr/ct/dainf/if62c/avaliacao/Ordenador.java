package utfpr.ct.dainf.if62c.avaliacao;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * IF62C Fundamentos de Programação 2
 * Avaliação parcial.
 * @author 
 */
public class Ordenador extends Thread {

    private final String path;
    private final List<String> linhas = new ArrayList<>();
    private boolean carregado, gravado, executando;
    
    public Ordenador(String path) {
        this.path = path;
    }
    
    private void carrega() {
        try (FileReader fr = new FileReader(path);
             BufferedReader br = new BufferedReader(fr)) {
            String linha;
            while ((linha = br.readLine()) != null) {
                linhas.add(linha);
            }
            carregado = true;
        } catch (IOException ex) {
            System.out.printf("Erro na leitura do arquivo '%s': %s%n", path,
                    ex.getLocalizedMessage());        
        } 
    }
    
    private void grava() {
        try (FileWriter fw = new FileWriter(path + ".ord");
             BufferedWriter bw = new BufferedWriter(fw)) {
            for (String linha: linhas) {
                bw.write(linha);
                bw.newLine();
            }
            gravado = true;
        } catch (IOException ex) {
            System.out.printf("Erro na gravação do arquivo '%s': %s%n", path + ".ord",
                    ex.getLocalizedMessage());        
        } 
    }
    
    public void ordena() {
        carrega();
        if (carregado) {
            Collections.sort(linhas);
            grava();
        }
    }

    public boolean executando() {
        return executando;
    }
    
    @Override
    public void run() {
        executando = true;
        ordena();
        executando = false;
    }
    
}
