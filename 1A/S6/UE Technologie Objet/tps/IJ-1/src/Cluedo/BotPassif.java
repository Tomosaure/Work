package Cluedo;

public class BotPassif extends Joueur {
    
    /** Un bot ayant la stratégie passive ne joue pas réellement.
     * Son pion peut être déplacé uniquement par les autres joueurs si ceux-ci formulent
     * une hypothèse impliquant le personnage du bot.
     */

    /** Construire un bot passif à partir de son personnage. */
    public BotPassif(NomCarte personnage) {
        super(personnage.name(), personnage);
    }

}
