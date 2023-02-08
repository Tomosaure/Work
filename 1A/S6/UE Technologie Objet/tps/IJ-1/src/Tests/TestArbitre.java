package Tests;

import org.junit.*;

import Cluedo.*;

public class TestArbitre {
    private Arbitre arbitre;
    Joueur[] joueurs = new Joueur[3];

    @Before
    public void setUp(){
        joueurs[0] = new Joueur("joueur1", null);
        joueurs[1] = new Joueur("joueur2", null);
        joueurs[2] = new Joueur("joueur3", null);
        arbitre = new Arbitre(joueurs);
    }

    @Test
    public void testerJoueurCourant(){
        assert(arbitre.joueurCourant().equals(joueurs[0]));
    }

    @Test
    public void testerJoueurSuivant(){
        arbitre.joueurSuivant();
        assert(arbitre.joueurCourant().equals(joueurs[1]));
        arbitre.joueurSuivant();
        assert(arbitre.joueurCourant().equals(joueurs[2]));
        arbitre.joueurSuivant();
        assert(arbitre.joueurCourant().equals(joueurs[0]));
    }
}
