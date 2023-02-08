package Cluedo;

public class StrategiePassif implements Strategie {

    /** Un bot ayant la stratégie passive ne joue pas réellement.
     * Son pion peut être déplacé uniquement par les autres joueurs si ceux-ci formulent
     * une hypothèse impliquant le personnage du bot.
     */

    @Override
    public Hypothese formulerHypothese() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Carte montrerCarte(Hypothese hypothese, Joueur joueur) {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Hypothese formulerAccusation() {
        // TODO Auto-generated method stub
        return null;
    }
    
}
