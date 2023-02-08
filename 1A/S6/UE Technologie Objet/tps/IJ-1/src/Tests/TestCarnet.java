package Tests;

import org.junit.*;
import Cluedo.Carnet;
import Cluedo.Symbole;

import java.util.Random;

public class TestCarnet {

    private Carnet carnet;

    @Before
    public void setUp() {
        carnet = new Carnet(3, 3);
    }

    @Test
    public void TesterInitialisation() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                assert (carnet.getCase(i, j).equals(Symbole.VIDE));
            }
        }

    }

    @Test
    public void TesterCocherCase() {
        Random rand = new Random();
        for (int w = 0; w < 10; w++) { // On fait le test 10 fois
            int i = rand.nextInt(3);
            int j = rand.nextInt(3);
            int k = rand.nextInt(Symbole.values().length);
            carnet.cocherCase(i, j, Symbole.values()[k]);
            assert (carnet.getCase(i, j).equals(Symbole.values()[k]));
        }
    }

    @Test
    /** Cette méthode permet également de tester viderLigne, viderColonne et viderCase */
    public void TesterVider() {
        // Rempissage de la grille avec des valeurs quelconques
        Random rand = new Random();
        for (int w = 0; w < 10; w++) { // On fait le test 10 fois
            int i = rand.nextInt(3);
            int j = rand.nextInt(3);
            int k = rand.nextInt(Symbole.values().length);
            carnet.cocherCase(i, j, Symbole.values()[k]);
            assert (carnet.getCase(i, j).equals(Symbole.values()[k]));
        }
        // vidage de la grille
        carnet.vider();

        // vérification que toutes les valeurs sont vide
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                assert (carnet.getCase(i, j).equals(Symbole.VIDE));
            }
        }
    }

    @Test
    public void TesterSymboleSuivant() {
        carnet.symboleSuivant(1, 1);
        assert (carnet.getCase(1, 1).equals(Symbole.CROIX));
        carnet.symboleSuivant(1, 1);
        assert (carnet.getCase(1, 1).equals(Symbole.ROND));
        carnet.symboleSuivant(1, 1);
        assert (carnet.getCase(1, 1).equals(Symbole.EXCLAMATION));
        carnet.symboleSuivant(1, 1);
        assert (carnet.getCase(1, 1).equals(Symbole.INTERROGATION));
        carnet.symboleSuivant(1, 1);
        assert (carnet.getCase(1, 1).equals(Symbole.VIDE));
    }
}
