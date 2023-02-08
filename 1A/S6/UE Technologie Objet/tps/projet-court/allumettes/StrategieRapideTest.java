package allumettes;

import org.junit.*;

import static org.junit.Assert.*;

public class StrategieRapideTest {

	public final static double EPSILON = 0.001;
    private static final int NbAllumettesInit = 13;
    private Joueur joueur;
    private Jeu jeu;

    @Before
    public void setUp() {
    	joueur = new Joueur("joueur", new StrategieRapide());
    }

    @Test
    public void Test1() throws CoupInvalideException {
    	int Nb_Allumettes = 0;
        jeu = new JeuSimple(NbAllumettesInit);
    	assertEquals(jeu.getNombreAllumettes(), 13, EPSILON);
    	
    	Nb_Allumettes = joueur.getPrise(jeu);
    	assertEquals(Nb_Allumettes, 3, EPSILON);
    	jeu.retirer(Nb_Allumettes);
    	assertEquals(jeu.getNombreAllumettes(), 10, EPSILON);

    	jeu.retirer(1);
    	assertEquals(jeu.getNombreAllumettes(), 9, EPSILON);

    	Nb_Allumettes = joueur.getPrise(jeu);
    	assertEquals(Nb_Allumettes, 3, EPSILON);
    	jeu.retirer(Nb_Allumettes);
    	assertEquals(jeu.getNombreAllumettes(), 6, EPSILON);
    	
    	jeu.retirer(1);
    	assertEquals(jeu.getNombreAllumettes(), 5, EPSILON);
    	
    	Nb_Allumettes = joueur.getPrise(jeu);
    	assertEquals(Nb_Allumettes, 3, EPSILON);
    	jeu.retirer(Nb_Allumettes);
    	assertEquals(jeu.getNombreAllumettes(), 2, EPSILON);
    	
    	jeu.retirer(1);
    	assertEquals(jeu.getNombreAllumettes(), 1, EPSILON);
    	
    	Nb_Allumettes = joueur.getPrise(jeu);
    	assertEquals(Nb_Allumettes, 1, EPSILON);
    	jeu.retirer(Nb_Allumettes);
    	assertEquals(jeu.getNombreAllumettes(), 0, EPSILON);
    	
    	System.out.println("Test1 passé");
    }

    @Test
    public void Test2() throws CoupInvalideException {
    	int Nb_Allumettes = 0;
        jeu = new JeuSimple(NbAllumettesInit);
        assertEquals(jeu.getNombreAllumettes() , 13, EPSILON);
    	
    	Nb_Allumettes = joueur.getPrise(jeu);
    	assertEquals(Nb_Allumettes, 3, EPSILON);
    	jeu.retirer(Nb_Allumettes);
    	assertEquals(jeu.getNombreAllumettes(), 10, EPSILON);

    	jeu.retirer(2);
    	assertEquals(jeu.getNombreAllumettes(), 8, EPSILON);

    	Nb_Allumettes = joueur.getPrise(jeu);
    	assertEquals(Nb_Allumettes, 3, EPSILON);
    	jeu.retirer(Nb_Allumettes);
    	assertEquals(jeu.getNombreAllumettes(), 5, EPSILON);
    	
    	jeu.retirer(3);
    	assertEquals(jeu.getNombreAllumettes(), 2, EPSILON);
    	
    	Nb_Allumettes = joueur.getPrise(jeu);
    	assertEquals(Nb_Allumettes, 2, EPSILON);
    	jeu.retirer(Nb_Allumettes);
    	assertEquals(jeu.getNombreAllumettes(), 0, EPSILON);

    	System.out.println("Test2 passé");
    }

    @Test
    public void Test3() throws CoupInvalideException {
    	int Nb_Allumettes = 0;
        jeu = new JeuSimple(NbAllumettesInit);
        assertEquals(jeu.getNombreAllumettes(), 13, EPSILON);
    	
    	Nb_Allumettes = joueur.getPrise(jeu);
    	assertEquals(Nb_Allumettes, 3, EPSILON);
    	jeu.retirer(Nb_Allumettes);
    	assertEquals(jeu.getNombreAllumettes(), 10, EPSILON);

    	jeu.retirer(3);
    	assertEquals(jeu.getNombreAllumettes(), 7, EPSILON);

    	Nb_Allumettes = joueur.getPrise(jeu);
    	assertEquals(Nb_Allumettes, 3, EPSILON);
    	jeu.retirer(Nb_Allumettes);
    	assertEquals(jeu.getNombreAllumettes(),  4, EPSILON);
    	
    	jeu.retirer(1);
    	assertEquals(jeu.getNombreAllumettes(), 3, EPSILON);
    	
    	Nb_Allumettes = joueur.getPrise(jeu);
    	assertEquals(Nb_Allumettes, 3, EPSILON);
    	jeu.retirer(Nb_Allumettes);
    	assertEquals(jeu.getNombreAllumettes(), 0, EPSILON);

    	System.out.println("Test3 passé");
    }
    public static void main(String[] args) {
        org.junit.runner.JUnitCore.main(StrategieRapideTest.class.getName());
    }

}