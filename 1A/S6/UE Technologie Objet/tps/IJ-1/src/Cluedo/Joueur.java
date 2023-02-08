package Cluedo;

import java.util.ArrayList;
import java.awt.image.BufferedImage;
import java.io.IOException;
/* Joueur humain */
public class Joueur {
    
    private String nom;
    protected Position position; /* position du joueur sur le plateau */
    private Personnage personnage;
    private ArrayList<Carte> main; /* cartes possédées par le joueur */
    private Carnet carnet; /* carnet de notes du joueur */
    private int numero; /* numéro du joueur, compris entre 1 et 6 */
    protected Salle ancienneSalle; /* la dernière salle visitée par le joueur */
    /** Construire un joueur à partir de son nom. */
    public Joueur(String nom) {
        this.nom = nom;
        this.main = new ArrayList<Carte>();
    }

    /** Construire un joueur à partir de son nom et de son numéro. */
    public Joueur(String nom, int numero) {
        this(nom);
        this.numero = numero;
    }

    /** Construire un joueur à partir de son nom et sa position. */
     public Joueur(String nom, Position pos) {
        this(nom);
        this.position = pos;
    }

    /** Construire un joueur à partir de son nom, sa position et son personnage. */
    public Joueur(String nom, Position pos, Personnage personnage) {
        this(nom, pos);
        this.personnage = personnage;
    }

    /** Retourne le nom du joueur. */
    public String getNom() {
        return this.nom;
    }

    /** Retourne le personnage du joueur. */
    public Personnage getPersonnage() {
        return this.personnage;
    }

    /** Retourne la main du joueur. */
    public ArrayList<Carte> getMain() {
        return this.main;
    }

    /** Retourne la position du joueur */
    public Position getPos() {
        return this.position;
    }

    /** Retourne la dernière salle visitée par le joueur */
    public Salle getSalle() {
        return this.ancienneSalle;
    }

    /** Retourne le carnet de notes du joueur. */
    public Carnet getCarnet() {
        return this.carnet;
    }

    /** Retourne le numéro du joueur. */
    public int getNumero() {
        return this.numero;
    }

    /** Modifier le nom du joueur. */
    public void setNom(String nom) {
        this.nom = nom;
    }

    /** Associer au joueur le personnage qu'il a choisi. 
     * @throws IOException*/
    public void setPersonnage(NomCarte nomPersonnage) throws IOException {
        this.personnage = new Personnage(nomPersonnage);
    }

    /** Positionner le joueur. */
    public void setPos(Position pos) {
        this.position = pos;
    }

    /** Définir la dernière salle visitée par le joueur. */
    public void setSalle(Salle salle) {
        this.ancienneSalle = salle;
    }

    /** Ajouter la carte c à la main du joueur. */
    public void ajouterCarte(Carte c) {
        this.main.add(c);
    }

    /** Le joueur possède-t-il la carte Arme de l'hypothèse formulée par un autre joueur ?
     * @param h l'hypothèse formulée par un autre joueur
     */
    public boolean possedeArme(Hypothese h) {
        return this.main.contains(h.getArme());
    }

    /** Le joueur possède-t-il la carte Salle de l'hypothèse formulée par un autre joueur ?
     * @param h l'hypothèse formulée par un autre joueur
     */
    public boolean possedeSalle(Hypothese h) {
        return this.main.contains(h.getSalle());
    }

    /** Le joueur possède-t-il la carte Personnage de l'hypothèse formulée par un autre joueur ?
     * @param h l'hypothèse formulée par un autre joueur
     */
    public boolean possedePersonnage(Hypothese h) {
        return this.main.contains(h.getPersonnage());
    }

    /** Le joueur possède-t-il la carte 'carte' ?
     * @param c la carte en question
     */
    public boolean possedeCarte(Carte c) {
        return this.main.contains(c);
    }

    /** Numéro de la colonne du carnet associée au joueur. */
    public int indiceColonneCarnet() {
        return this.numero + 1;
        // le carnet contient 7 colonnes, la première n'est assignée à aucun joueur
        // puis colonne 2 = joueur 1, colonne 3 = joueur 2... etc
    }

    /** Formuler une hypothèse. */
    public Hypothese formulerHypothese() { // ce qui se passe quand on appuie sur le bouton 'hypothèse'
        // TODO : à faire avec un bouton "Formuler une hypothèse"
        // Quel personnage ? On clique sur perso, puis
        // Quelle arme ? On clique sur arme, puis
        // Quelle pièce ? On clique sur pièce
        return new Hypothese(choisirPersonnage(), choisirArme(), choisirSalle());
    }

    /** Formuler une accusation. */
    public Hypothese formulerAccusation() {
        // TODO : à faire avec un bouton
        // demander si on est sûr de vouloir accuser
        return new Hypothese(choisirPersonnage(), choisirArme(), choisirSalle());
    }

    /** Montrer une carte à partir de l'hypothèse d'un autre joueur. */
    public Carte montrerCarte(Hypothese hypothese) {
        Carte aMontrer = null;
        return null;
        // TODO : à faire avec interface graphique/bouton
        // Bouton "Montrer une carte"
        // Afficher toutes les cartes du joueur + Bouton "Je ne possède aucune des cartes citées"
        // On clique sur la carte qu'on veut montrer
        // Puis fenêtre "Voulez-vous montrer la carte <nom> ? Oui, Non"
        // Qd on clique sur oui, la carte est montrée au joueur
    }

    /** Se déplacer sur le plateau de jeu en fonction de son score aux dés. */
    public void seDeplacer() {
        
    }

    /** Le joueur possède-t-il au moins 2 cartes dans l'hypothèse formulée par un autre joueur ?
     * @param h l'hypothèse formulée par un autre joueur
    */
    public boolean aPlusieursCartes(Hypothese h) {
        return (this.main.contains(h.getArme()) && this.main.contains(h.getSalle()))
            || (this.main.contains(h.getArme()) && this.main.contains(h.getPersonnage()))
            || (this.main.contains(h.getPersonnage()) && this.main.contains(h.getSalle()));
    }

    /** Le joueur a-t-il vu la carte 'carte' ? */
    public boolean aVu(Carte carte) {
        int i = carte.indiceLigneCarnet();
        return !this.getCarnet().ligneVide(i);
        // si la ligne n'est pas vide, c'est que le joueur a vu la carte chez quelqu'un
    }

    /** Choisir un personnage pour l'hypothèse ou l'accusation formulée.
     * @return le personnage choisi
     */
    public Carte choisirPersonnage() {
        Carte persoChoisi = null;
        // utiliser ChoixPersonnage : faire une classe générique
        return persoChoisi;
    }

    /** Choisir une arme pour l'hypothèse ou l'accusation formulée.
     * @return l'arme choisie
     */
    public Carte choisirArme() {
        return null;
    }

    /** Choisir une salle pour l'hypothèse ou l'accusation formulée.
     * @return la salle choisie
     */
    public Carte choisirSalle() {
        return null;
    }

}