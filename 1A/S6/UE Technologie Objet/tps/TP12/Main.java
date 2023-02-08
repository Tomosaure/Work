import java.util.*;
import java.util.stream.Collectors;
import java.io.*;
import java.util.zip.*;
import java.time.LocalDateTime;


/**
 * La classe principale.
 *
 * Tous les traitements demandés sont faits dans la mêthode
 * {@code repondreQuestions}.
 * Il serait plus logique d'écrire des méthodes qui pemettraient d'améliorer
 * la structuration et la réutilisation.  Cependant l'objectif est ici la
 * manipulation de l'API des collections, pas la structuration du code
 * en sous-programmes.
 */

public class Main {

	private static void repondreQuestions(Reader in) {
		Iterable<PointDeVente> iterable = PointDeVenteUtils.fromXML(in);

		// Construire un tableau associatif (pdvs) des points de vente avec un
		// accès par identifiant
		Map<Long, PointDeVente> pdvs = new HashMap<>();
		for (PointDeVente pdv : iterable) {
			pdvs.put(pdv.getIdentifiant(), pdv);
		}

		// Nombre de point de vente
		int nbPDV = pdvs.size();
		System.out.println(nbPDV);
		
		// Afficher le nombre de services existants
		int nbServices = 0;
		for (PointDeVente pdv : iterable) {
			nbServices += pdv.getServices().size();
		}
		System.out.println(nbServices);

		// Afficher les services fournis
		for (PointDeVente pdv : iterable) {
			System.out.println(pdv.getServices().toString());
		}

		// Afficher la ville correspondant au point de vente d'identifiant
		// 31075001 et le prix du gazole le 25 janvier 2017 à 10h.	
			System.out.println(pdvs.get(31075001L).getVille());
			System.out.println(pdvs.get(31075001L).getPrix(Carburant.GAZOLE, LocalDateTime.parse("2017-01-25T10:00:00)")));

		// Afficher le nombre de villes offrant au moins un point de vente
			int nb_ville = 0;
			ArrayList<String> ville = new ArrayList<String>();
			for (PointDeVente pdv : iterable) {
				if (!ville.contains(pdv.getVille())) {
					ville.add(pdv.getVille());
				}
			}
			System.out.println(nb_ville);
			
		// Afficher le nombre moyen de points de vente par ville
			int nb = 0;
			for (String la_ville : ville) {
				for (PointDeVente pdv : iterable) {
					if (pdv.getVille().equals(la_ville)) {
						nb += 1;
					}
				}
			}
			float moyenne = nb/ville.size();
			System.out.println(moyenne);

		// le nombre de villes offrants un certain nombre de carburants


		// Afficher le nombre et les points de vente dont le code postal est 31200
			int nb2 = 0;
			for (PointDeVente pdv : iterable) {
				if (pdv.getCodePostal().equals("31200")) {
					System.out.println(pdv.getIdentifiant());
					nb2 += 1;
				}
			}
			System.out.println(nb2);

		// Nombre de PDV de la ville de Toulouse qui proposent et du Gazole
		// et du GPLc.
			int nb3 = 0;
			for (PointDeVente pdv : iterable) {
				if (pdv.getVille().equals("TOULOUSE") && pdv.getPrix().containsKey(Carburant.GPLc) && pdv.getPrix().containsKey(Carburant.GAZOLE)) {
					nb3 += 1;
				}
			}
			System.out.println(nb3);
			
		// Afficher le nom et le nombre de points de vente des villes qui ont au
		// moins 20 points de vente
			
	}


	private static Reader ouvrir(String nomFichier)
			throws FileNotFoundException, IOException
	{
		if (nomFichier.endsWith(".zip")) {
			// On suppose que l'archive est bien formée :
			// elle contient fichier XML !
			ZipFile zfile = new ZipFile(nomFichier);
			ZipEntry premiere = zfile.entries().nextElement();
			return new InputStreamReader(zfile.getInputStream(premiere));
		} else {
			return new FileReader(nomFichier);
		}
	}


	public static void main(String[] args) {
		if (args.length != 1) {
			System.out.println("usage : java Main <fichier.xml ou fichier.zip>");
		} else {
			try (Reader in = ouvrir(args[0])) {
				repondreQuestions(in);
			} catch (FileNotFoundException e) {
				System.out.println("Fichier non trouvé : " + args[0]);
			} catch (Exception e) {
				System.out.println(e.getMessage());
				e.printStackTrace();
			}
		}
	}

}
