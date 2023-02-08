package Cluedo;

// TODO : à repenser. -> classe plutôt qu'interface ?
public interface Strategie {
    
    /** Formuler une hypothèse. */
    public Hypothese formulerHypothese();

    /** Choisir la carte à montrer suite à l'hypothèse d'un autre joueur. */
    // en paramètre : joueur est le joueur qui joue (donc qui montre la carte)
    public Carte montrerCarte(Hypothese hypothese, Joueur joueur);

    /** Formuler une accusation. */
    public Hypothese formulerAccusation();

}
