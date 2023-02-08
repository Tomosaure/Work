package Tests;
import Cluedo.*;
import java.io.FileNotFoundException;
import java.util.List;

public class testPathfinding {
     /* test du pathfinder et de la recherche de salle */
     public static void main(String[] args) throws FileNotFoundException {
        Plateau plateau = new Plateau();
        int[][] map = PathFinder.creerMap();
        System.out.println();
        for (int i = 0; i < map.length; i++) {
            for (int j = 0; j < map[0].length; j++) {
                System.out.print(map[i][j]);
            }
            System.out.println();
        }
        int scoreDe = 5;
        Position depart = new Position(7, 0, null);
        Position arrivee = new Position(15, 12, null);
        List<Position> chemin = PathFinder.trouverChemin(map, depart, arrivee, plateau);
        if (chemin != null) {
            int i = 0;
            for (Position noeud : chemin) {               
                if (i <= scoreDe) {
                    System.out.println(noeud);
                    i++;
                }
            }
        } else {
            System.out.println("aucun chemin trouvé");
        }
        System.out.println();
        System.out.println(((Salle) plateau.getCase(new Position(11, 19))).getNomSalle());
        Position destination = PathFinder.trouverSalle(new Position (11, 16), plateau, (Salle) plateau.getCase(new Position(11, 19)));
        System.out.println(destination);
    }
}
