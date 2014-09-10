
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import utfpr.ct.dainf.if62c.avaliacao.Ordenador;

/**
 * IF62C Fundamentos de Programação 2
 * Avaliação parcial.
 * @author 
 */
public class Avaliacao5 {
    
    public static void main(String[] args) {
        final List<Ordenador> ordenadores = new ArrayList<>();
        final Scanner scn = new Scanner(System.in);
        String path;
        do {
            System.out.print("Ordenar> ");
            path = scn.nextLine();
            if (path.trim().length() > 0) {
                Ordenador ord = new Ordenador(path);
                ordenadores.add(ord);
                ord.start();
            }
        } while (path.trim().length() > 0);
        
        int n = 0;
        for (Ordenador o: ordenadores) {
            if (o.executando()) n++;
        }
        System.out.printf("Aguardando o processamento de %d arquivo...%n", n);
    }
}
