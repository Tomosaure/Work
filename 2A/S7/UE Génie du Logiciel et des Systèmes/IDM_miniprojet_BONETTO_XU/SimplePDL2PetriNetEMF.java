package simplePDLtoPetriNetEMF1;


import java.io.IOException;
import java.util.Collections;
import java.util.Map;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;

import petrinet.Noeud;
import petrinet.Arc;
import petrinet.arcType;
import petrinet.PetriNetElement;
import petrinet.PetrinetFactory;
import petrinet.PetrinetPackage;
import petrinet.PetriNet;
import petrinet.Place;
import petrinet.Transition;
import petrinet.impl.PlaceImpl;
import simplepdl.Process;
import simplepdl.Request;
import simplepdl.SimplepdlFactory;
import simplepdl.SimplepdlPackage;
import simplepdl.WorkDefinition;
import simplepdl.WorkSequence;
import simplepdl.WorkSequenceType;


public class simplePDLtoPetriNetEMF1 {

	public static void main(String[] args) {
		
		// Charger le package SimplePDL afin de l'enregistrer dans le registre d'Eclipse.
		SimplepdlPackage packagePDLInstance = SimplepdlPackage.eINSTANCE;
		// Charger le package SimplePDL afin de l'enregistrer dans le registre d'Eclipse.
		PetrinetPackage packagePetriNetInstance = PetrinetPackage.eINSTANCE;
		
		// Enregistrer l'extension ".xmi" comme devant etre ouverte Ã 
		// l'aide d'un objet "XMIResourceFactoryImpl"
		Resource.Factory.Registry reg = Resource.Factory.Registry.INSTANCE;
		Map<String, Object> m = reg.getExtensionToFactoryMap();
		m.put("xmi", new XMIResourceFactoryImpl());
		
		// Créer un objet resourceSetImpl qui contiendra une ressource EMF (notre modèle)
		ResourceSet resSet = new ResourceSetImpl();
		ResourceSet resSetPetri = new ResourceSetImpl();

		// Charger la ressource (notre modèle)
		URI modelURI = URI.createURI("models/sujetPDL.xmi");
		Resource resource = resSet.getResource(modelURI, true);
		
		// RÃ©cupÃ©rer le premier Ã©lÃ©ment du modÃ¨le (Ã©lÃ©ment racine)
		Process process = (Process) resource.getContents().get(0);
		
		URI modelURIPetri = URI.createURI("models/PetriNet_" + process.getName() + ".xmi");
		Resource resourcePetri = resSetPetri.createResource(modelURIPetri);

		// La fabrique pour fabriquer les éléments de PetriNet
	    PetrinetFactory myFactory = PetrinetFactory.eINSTANCE;
	    
		 // Créer un élément PetriNet
		PetriNet petrinet = myFactory.createPetriNet();
		petrinet.setName(process.getName());
		
	 	resourcePetri.getContents().add(petrinet);



 		process.getProcessElements().stream().forEach(pe -> {
 			if (pe instanceof WorkDefinition) {		// WorkDefinition
				WorkDefinition wd = (WorkDefinition) pe;


 				// WorkDefinition Places
 				Place ready = myFactory.createPlace();
 	 			ready.setName(wd.getName() + "_ready");
 	 			ready.setJetons(1);
 	 			ready.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(ready);

 	 			Place inProgress = myFactory.createPlace();
 	 			inProgress.setName(wd.getName() + "_inProgress");
 	 			inProgress.setJetons(0);
 	 			inProgress.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(inProgress);

 	 			Place started = myFactory.createPlace();
 	 			started.setName(wd.getName() + "_started");
 	 			started.setJetons(0);
 	 			started.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(started);

 	 			Place finished = myFactory.createPlace();
 	 			finished.setName(wd.getName() + "_finished");
 	 			finished.setJetons(0);
 	 			finished.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(finished);


 	 			// WorkDefinition Transitions
 	 			Transition start = myFactory.createTransition();
 	 			start.setName(wd.getName() + "_start");
 	 			start.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(start);

 	 			Transition finish = myFactory.createTransition();
 	 			finish.setName(wd.getName() + "_finish");
 	 			finish.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(finish);


 	 			// WorkDefinition Arcs
 	 			Arc ready2start = myFactory.createArc();
 	 			ready2start.setPoids(1);
 	 			ready2start.setType(arcType.NORMAL_ARC);
 	 			ready2start.setSource(ready);
 	 			ready2start.setDestination(start);
 	 			ready2start.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(ready2start);

 	 			Arc start2inProgress = myFactory.createArc();
 	 			start2inProgress.setPoids(1);
 	 			start2inProgress.setType(arcType.NORMAL_ARC);
 	 			start2inProgress.setSource(start);
 	 			start2inProgress.setDestination(inProgress);
 	 			start2inProgress.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(start2inProgress);

 	 			Arc start2started = myFactory.createArc();
 	 			start2started.setPoids(1);
 	 			start2started.setType(arcType.NORMAL_ARC);
 	 			start2started.setSource(start);
 	 			start2started.setDestination(started);
 	 			start2started.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(start2started);

 	 			Arc inProgress2finish = myFactory.createArc();
 	 			inProgress2finish.setPoids(1);
 	 			inProgress2finish.setType(arcType.NORMAL_ARC);
 	 			inProgress2finish.setSource(inProgress);
 	 			inProgress2finish.setDestination(finish);
 	 			inProgress2finish.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(inProgress2finish);

 	 			Arc finish2finished = myFactory.createArc();
 	 			finish2finished.setPoids(1);
 	 			finish2finished.setType(arcType.NORMAL_ARC);
 	 			finish2finished.setSource(finish);
 	 			finish2finished.setDestination(finished);
 	 			finish2finished.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(finish2finished);
 			} else if (pe instanceof WorkSequence) {		// WorkSequence
 				WorkSequence ws = (WorkSequence) pe;

 				Arc aws = myFactory.createArc();
 	 			aws.setPoids(1);
 	 			aws.setType(arcType.READ_ARC);
 	 			aws.setSource((Noeud) petrinet.getPetriNetElements().stream().filter(p -> p instanceof Noeud).filter(n -> ((Noeud) n).getName()
 	 					.equals(ws.getPredecessor().getName() + (ws.getLinkType() == WorkSequenceType.START_TO_START
 	 					|| ws.getLinkType() == WorkSequenceType.START_TO_FINISH ? "_started" : "_finished")) ).toArray()[0]);
 	 			aws.setDestination((Noeud) petrinet.getPetriNetElements().stream().filter(p -> p instanceof Noeud).filter(n -> ((Noeud) n).getName()
 	 					.equals(ws.getSuccessor().getName() + (ws.getLinkType() == WorkSequenceType.START_TO_START
 	 					|| ws.getLinkType() == WorkSequenceType.FINISH_TO_START ? "_start" : "_finish")) ).toArray()[0]);
 	 			aws.setPetrinet(petrinet);
 	 			petrinet.getPetriNetElements().add(aws);
 	 			
 			} else if (pe instanceof simplepdl.Resource) {		// Resources
 				simplepdl.Resource rs = (simplepdl.Resource) pe;

 				Place prs = myFactory.createPlace();
 				prs.setName(rs.getName() + "_resource");
 				prs.setJetons(rs.getAmount());
 				prs.setPetrinet(petrinet);
 				petrinet.getPetriNetElements().add(prs);

 				for (Request ne : rs.getRequest()) {		// Request
 					Arc anLoad = myFactory.createArc();
 	 				anLoad.setPoids(ne.getOccurrence());
 	 				anLoad.setType(arcType.NORMAL_ARC);
 	 				anLoad.setSource(prs);
 	 				anLoad.setDestination((Noeud) petrinet.getPetriNetElements().stream().filter(p -> p instanceof Noeud).filter(n -> ((Noeud) n).getName()
 	 	 					.equals(ne.getWorkdefinition().getName() + "_start")).toArray()[0]);
 	 				anLoad.setPetrinet(petrinet);
 	 				petrinet.getPetriNetElements().add(anLoad);

 	 				Arc anRelease = myFactory.createArc();
 	 				anRelease.setPoids(ne.getOccurrence());
 	 				anRelease.setType(arcType.NORMAL_ARC);
 	 				anRelease.setSource((Noeud) petrinet.getPetriNetElements().stream().filter(p -> p instanceof Noeud).filter(n -> ((Noeud) n).getName()
 	 	 					.equals(ne.getWorkdefinition().getName() + "_finish")).toArray()[0]);
 	 				anRelease.setDestination(prs);
 	 				anRelease.setPetrinet(petrinet);
 	 				petrinet.getPetriNetElements().add(anRelease);
 				}
 			}
 		});
	 	
	 	
	    try {
	    	resourcePetri.save(Collections.EMPTY_MAP);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	
}