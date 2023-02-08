import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

public class CercleTest {

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.001;

	// Les points du sujet
	private Point A, B, C, D, E, F;

	// Les cercles du sujet
	private Cercle C1, C2, C3;

	@Before public void setUp() {
		// Construire les points
		A = new Point(1, 2);
		B = new Point(2, 1);
		C = new Point(4, 1);
		D = new Point(8, 1);
		E = new Point((A.getX() + B.getX()) / 2, (A.getY() + B.getY()) / 2); // Centre du segment (AB)
		F = new Point((A.getX() + C.getX()) / 2, (A.getY() + C.getY()) / 2); // Centre du segment (AC)

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

	@Test public void testerE12() {
		memesCoordonnees("E11 : Centre de C1 incorrect", E, C1.getCentre());
		assertEquals("E11 : Rayon de C1 incorrect",
				E.distance(A), C1.getRayon(), EPSILON);
		assertEquals(Color.blue, C1.getCouleur());
	}

	@Test public void testerE13() {
		memesCoordonnees("E11 : Centre de C1 incorrect", F, C2.getCentre());
		assertEquals("E11 : Rayon de C1 incorrect",
				F.distance(A), C2.getRayon(), EPSILON);
		assertEquals(Color.orange, C2.getCouleur());
	}
	
	@Test public void testerE14() {
		memesCoordonnees("E11 : Centre de C1 incorrect", A, C3.getCentre());
		assertEquals("E11 : Rayon de C1 incorrect",
				A.distance(D), C3.getRayon(), EPSILON);
		assertEquals(Color.blue, C3.getCouleur());
	}

}
