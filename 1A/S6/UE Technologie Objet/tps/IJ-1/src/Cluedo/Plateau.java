package Cluedo;

import java.util.ArrayList;
import java.util.HashMap;
import java.awt.image.BufferedImage;
import java.util.Scanner;
import javax.swing.JFrame;
import javax.imageio.ImageIO;
import javax.swing.JPanel;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.awt.Graphics2D;
import javax.swing.WindowConstants;
import java.awt.Graphics;
import java.awt.FlowLayout;
/** Le plateau de jeu.
 * 
 */
public class Plateau {
    /* le plateau de jeu */
    public static Case[][] plateau = new Case[25][24]; 
    /* la liste des salles avec leurs cases */
    public HashMap<Salles, ArrayList<Salle>> listeSalles = new HashMap<>();

    /** Construction du plateau.
     * Création des salles, portes, murs, couloirs
     */
    public Plateau() {
        for (int i = 0; i < plateau.length; i++) {
            for (int k = 0; k < plateau[i].length; k++) {
                plateau[i][k] = new Couloir(new Position(k, i));
            }
        }


        /* Création des différentes salles */

        // Bureau
        ArrayList<Salle> Bureau = new ArrayList<>();
        creerSalle(Bureau, Salles.BUREAU, 0, 5, 0, 0);
        creerSalle(Bureau, Salles.BUREAU, 0, 6, 1, 3);
        listeSalles.put(Salles.BUREAU, Bureau);

        // Hall
        ArrayList<Salle> Hall = new ArrayList<>();
        creerSalle(Hall, Salles.HALL, 9, 14, 1, 6);
        listeSalles.put(Salles.HALL, Hall);

        // Petit salon
        ArrayList<Salle> Petit_Salon = new ArrayList<>();
        creerSalle(Petit_Salon, Salles.PETIT_SALON, 17, 23, 1, 5);
        creerSalle(Petit_Salon, Salles.PETIT_SALON, 18, 23, 0, 0);
        listeSalles.put(Salles.PETIT_SALON, Petit_Salon);

        // Bibliothèque
        ArrayList<Salle> Bibliotheque = new ArrayList<>();
        creerSalle(Bibliotheque, Salles.BIBLIOTHEQUE, 1, 5, 6, 6);
        creerSalle(Bibliotheque, Salles.BIBLIOTHEQUE, 1, 5, 10, 10);
        creerSalle(Bibliotheque, Salles.BIBLIOTHEQUE, 0, 6, 7, 9);
        listeSalles.put(Salles.BIBLIOTHEQUE, Bibliotheque);

        // Salle de billard
        ArrayList<Salle> Salle_De_Billard = new ArrayList<>();
        creerSalle(Salle_De_Billard, Salles.SALLE_DE_BILLARD, 0, 5, 12, 16);
        listeSalles.put(Salles.SALLE_DE_BILLARD, Salle_De_Billard);

        // Veranda
        ArrayList<Salle> Veranda = new ArrayList<>();
        creerSalle(Veranda, Salles.VERANDA, 1, 4, 19, 19);
        creerSalle(Veranda, Salles.VERANDA, 0, 5, 20, 23);
        listeSalles.put(Salles.VERANDA, Veranda);

        // Grand salon
        ArrayList<Salle> Grand_Salon = new ArrayList<>();
        creerSalle(Grand_Salon, Salles.GRAND_SALON, 8, 15, 17, 22);
        creerSalle(Grand_Salon, Salles.GRAND_SALON, 10, 13, 23, 23);
        listeSalles.put(Salles.GRAND_SALON, Grand_Salon);

        // Cuisine
        ArrayList<Salle> Cuisine = new ArrayList<>();
        creerSalle(Cuisine, Salles.CUISINE, 18, 22, 18, 18);
        creerSalle(Cuisine, Salles.CUISINE, 18, 23, 19, 23);
        listeSalles.put(Salles.CUISINE, Cuisine);

        // Salle à manger
        ArrayList<Salle> Salle_a_manger = new ArrayList<>();
        creerSalle(Salle_a_manger, Salles.SALLE_A_MANGER, 16, 23, 9, 14);
        creerSalle(Salle_a_manger, Salles.SALLE_A_MANGER, 19, 23, 15, 15);
        listeSalles.put(Salles.SALLE_A_MANGER, Salle_a_manger);

        
        /* Création des différentes portes */

        // Bureau
        plateau[4][6] = new Porte(new Position(6, 4), Salles.BUREAU);

        // Hall
        plateau[4][8] = new Porte(new Position(8, 4), Salles.HALL);
        plateau[7][1] = new Porte(new Position(11, 7), Salles.HALL);
        plateau[7][12] = new Porte(new Position(12, 7), Salles.HALL);

        // Petit salon
        plateau[6][17] = new Porte(new Position(17, 6), Salles.PETIT_SALON);

        // Salle à manger
        plateau[8][17] = new Porte(new Position(17, 8), Salles.SALLE_A_MANGER);
        plateau[12][15] = new Porte(new Position(15,12), Salles.SALLE_A_MANGER);

        // Cuisine
        plateau[17][19] = new Porte(new Position(19, 17), Salles.CUISINE);    
    
        // Grand salon
        plateau[16][14] = new Porte(new Position(14, 16), Salles.GRAND_SALON);
        plateau[16][9] = new Porte(new Position(9, 16), Salles.GRAND_SALON);
        plateau[19][16] = new Porte(new Position(16, 19), Salles.GRAND_SALON);
        plateau[19][7] = new Porte(new Position(7, 19), Salles.GRAND_SALON);

         // Veranda
         plateau[19][5] = new Porte(new Position(5, 19), Salles.VERANDA);   
         
        // Salle de billard
        plateau[15][6] = new Porte(new Position(6, 15), Salles.SALLE_DE_BILLARD);   
        plateau[11][1] = new Porte(new Position(1, 11), Salles.SALLE_DE_BILLARD); 

        // Bibliothèque
        plateau[11][3] = new Porte(new Position(3, 11), Salles.BIBLIOTHEQUE);   
        plateau[8][7] = new Porte(new Position(7, 8), Salles.BIBLIOTHEQUE);    
        

         /* Création des différents murs */

         ArrayList<Salle> Murs = new ArrayList<>();
         creerSalle(Murs, null, 9, 13, 8, 14); // bloc central
         creerSalle(Murs, null, 6, 6, 0, 0);
         creerSalle(Murs, null, 8, 15, 0, 0);
         creerSalle(Murs, null, 17, 17, 0, 0);
         creerSalle(Murs, null, 23, 23, 6, 6);
         creerSalle(Murs, null, 23, 23, 8, 8);
         creerSalle(Murs, null, 23, 23, 16, 16);
         creerSalle(Murs, null, 23, 23, 18, 18);
         creerSalle(Murs, null, 15, 23, 24, 24);
         creerSalle(Murs, null, 10, 13, 24, 24);
         creerSalle(Murs, null, 17, 17, 23, 23);
         creerSalle(Murs, null, 0, 8, 24, 24);
         creerSalle(Murs, null, 6, 6, 23, 23);
         creerSalle(Murs, null, 0, 0, 19, 19);
         creerSalle(Murs, null, 0, 0, 17, 17);
         creerSalle(Murs, null, 0, 0, 10, 11);
         creerSalle(Murs, null, 0, 0, 6, 6);
         creerSalle(Murs, null, 0, 0, 4, 4);
         listeSalles.put(null, Murs);

         /* Allocation des cases où les joueurs seront placés dans les salles */

         setPlaceJoueur(listeSalles.get(Salles.BUREAU), 2 ,1);
         setPlaceJoueur(listeSalles.get(Salles.HALL), 10 ,3);
         setPlaceJoueur(listeSalles.get(Salles.PETIT_SALON), 18 ,2);
         setPlaceJoueur(listeSalles.get(Salles.SALLE_A_MANGER), 18 ,11);
         setPlaceJoueur(listeSalles.get(Salles.CUISINE), 19 ,20);
         setPlaceJoueur(listeSalles.get(Salles.GRAND_SALON), 10 ,19);
         setPlaceJoueur(listeSalles.get(Salles.VERANDA), 1 ,21);
         setPlaceJoueur(listeSalles.get(Salles.SALLE_DE_BILLARD), 1 ,13);
         setPlaceJoueur(listeSalles.get(Salles.BIBLIOTHEQUE), 2 ,7);
    }
    /** Retourner la largeur du plateau.
     * 
     * @return la largeur du plateau
     */
    public static int getLargeur() {
        return plateau.length;
    }
    /** Retourner la hauteur du plateau.
     * 
     * @return la hauteur du plateau
     */
    public int getHauteur() {
        return plateau[0].length;
    }
    /** Retourner la case située à la position choisie.
     * 
     * @param pos la position choisie
     * @return la case à cette position
     */
    public Case getCase(Position pos) {
        return plateau[pos.y][pos.x];
    }

    /** Affecter une zone de cases du plateau à une salle,
     * ce qui revient à définir l'emplacement de la salle sur le plateau de jeu.
     * @param cases_Salle la liste des cases composant la salle
     * @param x_inf la borne inférieure de la zone selon les abscisses
     * @param x_sup la borne supérieur de la zone selon les abscisses
     * @param y_inf la borne inférieure de la zone selon les ordonnées
     * @param y_sup la borne supérieur de la zone selon les ordonnées
     */
    public void creerSalle(ArrayList<Salle> cases_Salle,Salles nomSalle, int x_inf, int x_sup, int y_inf, int y_sup) {
        for (int i = y_inf; i <= y_sup; i++){
            for (int k = x_inf; k <= x_sup; k++){
                Salle case_Salle = new Salle(new Position(k,i), nomSalle);
                plateau[i][k] = case_Salle;
                cases_Salle.add(case_Salle);
            }
        }
    }

    /** Allouer les places des joueurs à chaque salle.
     * 
     * @param salle la liste des cases qui composent la salle
     * @param x l'abscisse du début de la zone à allouer
     * @param y l'ordonnée du début de la zone à allouer
     */
    public void setPlaceJoueur(ArrayList<Salle> salle, int x, int y) {
        for (Salle s : salle) {
            s.setPlaceJoueur(this, x, y);
        }
    }
                

    /**
     * Construire le plateau de jeu.
     * @return le plateau de jeu
     * @throws FileNotFoundException fichier texte non trouvé
     */
    public BufferedImage[][] creerPlateau() throws FileNotFoundException {
        Case caseActuelle, caseDessus, caseDessous, caseDroite, caseGauche;
        BufferedImage[][] image_plateau = new BufferedImage[25][24];
        String plateau_txt = "Ressources/txt/plateau.txt";

        try {
            //Lire le fichier
            Scanner scan_fic = new Scanner(new File(plateau_txt));
            int ordonnee = 0;

            // boucle tant qu'il y a une prochaine ligne
            while (scan_fic.hasNextLine()) {
                int abscisse = 0;
                // Récupère la ligne dans un scanner
                String line = scan_fic.nextLine();
                Scanner scan_line = new Scanner(line);

                // boucle tant qu'il y a un prochain token
                while(scan_line.hasNext()) {
                    String letter = scan_line.next();
                    // N'affiche rien lorsqu'il s'agit d'un mur
                    if (letter.equals("M")) {
                        image_plateau[ordonnee][abscisse] = null;
                        abscisse++;
                        System.out.print("M ");
                        continue;
                    }

                    StringBuilder fichier = new StringBuilder("Ressources/Image/");
                    caseActuelle = plateau[ordonnee][abscisse];
                    if (ordonnee > 0) {
                        caseDessus = plateau[ordonnee-1][abscisse];
                    } else {
                        caseDessus = null;
                    }
                    if (ordonnee < 24) {
                        caseDessous = plateau[ordonnee+1][abscisse];
                    } else {
                        caseDessous = null;
                    }
                    if (abscisse > 0) {
                        caseGauche = plateau[ordonnee][abscisse-1];
                    } else {
                        caseGauche = null;
                    }
                    if (abscisse < 23) {
                        caseDroite = plateau[ordonnee][abscisse+1];
                    } else {
                        caseDroite = null;
                    }

                    // Vérifie si la case est en surbrillance et prendre l'image associée
                    
                    if (caseActuelle.estSurbrillant()) {
                        fichier.append("CaseSurbrillance/");
                    } else {
                        fichier.append("CaseNormale/");
                    
                    }
                    try {

                        if (letter.equals("C")) {
                            fichier.append("Couloir");
                            System.out.print("C ");
                        } else {
                            fichier.append("Salle");
                            System.out.print("S ");
                            if (letter.equals("S")) {
                                // Mettre des murs pour encadrer les salles
                                if (ordonnee == 0 || caseDessus.estCouloir()) {
                                    fichier.append("N");
                                    System.out.print("N ");
                                } else if (ordonnee >= 24 || caseDessous.estCouloir()) {
                                    fichier.append("S");
                                    System.out.print("S ");
                                }
                                if (abscisse == 0 || caseGauche.estCouloir()) {
                                    fichier.append("O");
                                    System.out.print("O ");
                                } else if (abscisse >= 23 || caseDroite.estCouloir()) {
                                    fichier.append("E");
                                    System.out.print("E ");
                                }
                            }
                            // Mettre les murs manuellement 
                            else if (letter.charAt(0) == 'O') {
                                fichier.append(letter.charAt(1));
                                System.out.println("O ");
                            }
                        }
                        fichier.append(".png");
                        BufferedImage img = ImageIO.read(new File(fichier.toString()));
                        if (caseActuelle.estSalle() || caseActuelle.joueurPresent()) {

                            if (caseActuelle.joueurPresent()){
                                image_plateau[ordonnee][abscisse] = superposerImage(img, caseActuelle.getJoueur().getPersonnage().getPion(), abscisse, ordonnee);
                            } else {
                                image_plateau[ordonnee][abscisse] = superposerImage(img, null, abscisse, ordonnee);
                            }
                        } else {
                            image_plateau[ordonnee][abscisse] = superposerImage(img, null, abscisse, ordonnee);

                        }
                    } catch (IOException e) {
                        System.out.println("Image de case non trouvé");
                    }
                    abscisse++;
                }
                ordonnee++;
                System.out.println();
            }
        } catch (FileNotFoundException e){
            System.out.println("Fichier non trouvé:" + plateau_txt);
        }
        return image_plateau;
    }

    public BufferedImage superposerImage(BufferedImage bg, BufferedImage pion, int abscisse, int ordonnee) {
        BufferedImage image = new BufferedImage(bg.getWidth(), bg.getHeight(), BufferedImage.TYPE_INT_ARGB);
        Graphics2D tmp = image.createGraphics();
        tmp.drawImage(bg, 0, 0, null);
        if (pion != null) {
            tmp.drawImage(pion, 0, 0, null);
        }
        tmp.dispose();
        return image;
    }

}