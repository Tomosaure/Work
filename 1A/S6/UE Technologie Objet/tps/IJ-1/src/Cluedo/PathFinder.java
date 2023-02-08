package Cluedo;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class PathFinder {

    /** Savoir si un noeud est empruntable.
     * 
     * @param map la matrice de 0 et de 1 représentant le plateau 
     * @param noeud le noeud que l'on souhhaite emprunter
     * @return un boolean, true si empruntable false sinon
     */
    public static boolean Umprentable(int[][] map, Position noeud, Plateau plateau) {
        if (noeud.y < 0 || noeud.y > map.length - 1) {
            return false;
        } else if (noeud.x < 0 || noeud.x > map[0].length - 1) {
            return false;
        } else if (plateau.getCase(new Position(noeud.x, noeud.y)).joueurPresent()) {
            return false;
        } else {
        return map[noeud.y][noeud.x] == 0;
        }
    }

    /** Déterminer les voisins d'un noeud.
     * 
     * @param map la matrice de 0 et de 1 représentant le plateau 
     * @param noeud le noeud dont on cherche les voisins
     * @return la liste des voisins du noeud
     */
    public static List<Position> trouverVoisins(int[][] map, Position noeud, Plateau plateau) {
        List<Position> neighbors = new ArrayList<>();
        Position haut = noeud.decalage(0,  1);
        Position bas = noeud.decalage(0,  -1);
        Position gauche = noeud.decalage(-1, 0);
        Position droite = noeud.decalage(1, 0);
        if (Umprentable(map, haut, plateau)) neighbors.add(haut);
        if (Umprentable(map, bas, plateau)) neighbors.add(bas);
        if (Umprentable(map, gauche, plateau)) neighbors.add(gauche);
        if (Umprentable(map, droite, plateau)) neighbors.add(droite);
        return neighbors;
    }

    /** Trouver le plus court chemin entre le noeud de départ et le noeud d'arrivée.
     * 
     * @param map la matrice de 0 et de 1 représentant le plateau 
     * @param depart le noeud de départ 
     * @param arrivee le noeud d'arrivée
     * @return la liste des noeuds composant le chemin
     */
    public static List<Position> trouverChemin(int[][] map, Position depart, Position arrivee, Plateau plateau) {
        boolean fini = false;
        List<Position> noeudUmprente = new ArrayList<>();
        noeudUmprente.add(depart);
        
        while (!fini) {
            
            /* parcourir tous les noeuds */
            List<Position> nouveauNoeud = new ArrayList<>();
            for(int i = 0; i < noeudUmprente.size(); ++i){
                Position noeud = noeudUmprente.get(i);
                for (Position voisins : trouverVoisins(map, noeud, plateau)) {
                    if (!noeudUmprente.contains(voisins) && !nouveauNoeud.contains(voisins)) {
                        nouveauNoeud.add(voisins);
                    }
                }
            }

            /* condition d'arrêt */
            for(Position noeud : nouveauNoeud) {
                noeudUmprente.add(noeud);
                if (arrivee.equals(noeud)) {
                    fini = true;
                    break;
                }
            }

            /* chemin pas trouvé */
            if (!fini && nouveauNoeud.isEmpty())
                return null;
        }

        /* reconstituer le chemin */
        List<Position> chemin = new ArrayList<>();
        Position noeud = noeudUmprente.get(noeudUmprente.size() - 1);
        while(noeud.precedente != null) {
            chemin.add(0, noeud);
            noeud = noeud.precedente;
        }
        return chemin;
    }

    /** Créer la matrice sur laquelle va s'appuyer l'algorithme du plus court chemin.
     * 
     * @return la matrice de 0 et de 1 représentant le plateau
     * @throws FileNotFoundException si le fichier n'est pas trouvé
     */
    public static int[][] creerMap() throws FileNotFoundException {
        int[][] map = new int[25][24];
        /* On utilise le plateau.txt pour retranscrire la map */
        String plateau_txt =  "../src/Ressources/txt/plateau.txt";
        try {
            Scanner scan_fic = new Scanner(new File(plateau_txt));
            int j = 0;
            // boucle tant qu'il y a une prochaine ligne
            while (scan_fic.hasNextLine()) {
                // Récupère la ligne dans un scanner
                String line = scan_fic.nextLine();
                try (Scanner scan_line = new Scanner(line)) {
                    // boucle tant qu'il y a un prochain token
                    int i = 0;
                    while(scan_line.hasNext()) {
                        String letter = scan_line.next();
                        /* les cases couloirs et portes sont empruntables et valent 0 */
                        if (letter.equals("C") || letter.equals("P")) {
                            map[j][i] = 0;
                        /* le reste équivaut à des noeuds non empruntables et valent 1 */
                        } else {
                            map[j][i] = 1;
                        }
                        i++;
                    }
                }
                j++;
                }
        } catch (FileNotFoundException e){
            System.out.println("Fichier non trouvé : " + plateau_txt);
        }
        return map;
    } 

    /** Trouver le plus court chemin et prendre en compte le score aux dés.
     * 
     * @param depart le noeud de départ 
     * @param arrivee le noeud d'arrivée
     * @param scoreDe le score obtenu aux dés
     * @return la case d'arrivée si le score aux dés est suffisant pour se déplacer jusqu'à celle-ci
     * sinon si le score aux dés est insuffisant retourne la case atteignable la plus proche 
     * @throws FileNotFoundException si le fichier n'est pas trouvé
     */
    public static Position chemin(Position depart, Position arrivee, int scoreDe, Plateau plateau) throws FileNotFoundException {
        int[][] map = creerMap();
        List<Position> chemin = trouverChemin(map, depart, arrivee, plateau);
        Position noeudFinal = null;
        if (chemin != null) {
            int i = 1;
            for (Position noeud : chemin) {
                if (i == scoreDe || i == chemin.size()) {
                    noeudFinal = noeud;
                    break;
                }
                i++;
            }
        }
        return noeudFinal;
    }
    /** Trouver la salle la plus proche qui n'a pas été visitée dernièrement.
     * 
     * @param pos la position actuelle
     * @param plateau le palteau de jeu
     * @param salle la salle visitée dernièrement
     * @return la position de la porte la plus proche de la position actuelle et dont la salle n'a pas été visitée avant
     * @throws FileNotFoundException si fichier non trouvé
     */
    public static Position trouverSalle(Position pos, Plateau plateau, Salle salle) throws FileNotFoundException {
        int[][] map = creerMap();
        boolean fini = false;
        List<Position> noeudUmprente = new ArrayList<>();
        noeudUmprente.add(pos);
        
        while (!fini) {
            
            /* parcourir tous les noeuds */
            List<Position> nouveauNoeud = new ArrayList<>();
            for(int i = 0; i < noeudUmprente.size(); ++i){
                Position noeud = noeudUmprente.get(i);
                for (Position voisins : trouverVoisins(map, noeud, plateau)) {
                    if (!noeudUmprente.contains(voisins) && !nouveauNoeud.contains(voisins)) {
                        nouveauNoeud.add(voisins);
                    }
                }
            }

            /* condition d'arrêt */
            for(Position noeud : nouveauNoeud) {
                noeudUmprente.add(noeud);
                pos = new Position(noeud.x, noeud.y);
                if (plateau.getCase(pos).estPorte()) {
                    Porte porte = (Porte) plateau.getCase(pos);
                    if ( salle != null) {
                        if (porte.getSalle() != salle.getNomSalle()) {
                            fini = true;
                            return new Position(noeud.x, noeud.y);
                        }
                    } else {
                        fini = true;
                        return new Position(noeud.x, noeud.y);
                    }                  
                }
            }
        }
        return null;            
    }

}