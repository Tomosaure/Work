import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

public class ComplementsCercleTest {

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.001;

	// Les points du sujet
	private Point A, B, C, D, E;

	// Les cercles du sujet
	private Cercle C1, C2, C3;

	@Before public void setUp() {
		// Construire les points
		A = new Point(1, 2);
		B = new Point(200000, 100000);
		C = new Point(4, 1);
		D = new Point(8, 1);
		E = new Point((A.getX() + B.getX()) / 2, (A.getY() + B.getY()) / 2); // Centre du segment (AB)

		// Construire les cercles
		C1 = new Cercle(A, B);
		C2 = new Cercle(A, C, Color.orange);
		C3 = Cercle.creerCercle(A,D);
	}

	/** Vérifier si deux points ont mêmes coordonnées.
	  * @param p1 le premier point
	  * @param p2 le deuxième point
	  */
	static void memesCoordonnees(String message, Point p1, Point p2) {
		assertEquals(message + " (x)", p1.getX(), p2.getX(), EPSILON);
		assertEquals(message + " (y)", p1.getY(), p2.getY(), EPSILON);
	}

	@Test public void testerSetRayon() {
		C1.setRayon(500000);	
		assertEquals("setRayon : Rayon de C1 incorrect",
				500000, C1.getRayon(), EPSILON);
		memesCoordonnees("setRayon : Centre de C1 incorrect", E, C1.getCentre());
	}
	
	@Test public void testerTranslater() {
		C1.translater(-100000, -100000);	
		C1.translater(50000, 50000);
		C1.translater(50000, 50000);
		memesCoordonnees("translater: Centre de C1 incorrect", E, C1.getCentre());
	}
	
	@Test public void testerSetCouleur() {
		C1.setCouleur(Color.magenta);
		C2.setCouleur(Color.lightGray);
		C3.setCouleur(Color.darkGray);
		assertEquals("SetCouleur", Color.magenta, C1.getCouleur());
		assertEquals("SetCouleur", Color.lightGray, C2.getCouleur());
		assertEquals("SetCouleur", Color.darkGray, C3.getCouleur());
	}
	
	@Test public void testerSetDiametre() {
		C3.setDiametre(9999999);
		assertEquals("SetDiametre : Diamètre de C3 incorrect", C3.getDiametre(), C3.getRayon()*2, EPSILON);
	}
}
