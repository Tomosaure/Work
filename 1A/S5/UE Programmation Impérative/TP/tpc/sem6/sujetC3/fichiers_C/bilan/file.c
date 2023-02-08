/**
 *  \author Xavier CrŽgut <nom@n7.fr>
 *  \file file.c
 *
 *  Objectif :
 *	Implantation des opŽrations de la file
*/

#include <stdlib.h>
#include <assert.h>

#include "file.h"


void initialiser(File *f)
{
    f->tete = malloc(sizeof(Cellule));
    f->queue = NULL;
    f->tete = NULL;
    assert(est_vide(*f));
}


void detruire(File *f)
{
    if (f->tete == NULL) {
    } else {
        free(f->tete);
        f->tete = NULL;
    }
}

char tete(File f)
{
    assert(! est_vide(f));
    return f.tete->valeur;
}


bool est_vide(File f)
{
    return (f.tete == NULL && f.queue == NULL);
}

/**
 * Obtenir une nouvelle cellule allouŽe dynamiquement
 * initialisŽe avec la valeur et la cellule suivante prŽcisŽ en paramtre.
 */
static Cellule * cellule(char valeur, Cellule *suivante)
{
    Cellule* cellule = malloc(sizeof(Cellule));
    cellule->valeur = valeur;
    cellule->suivante = suivante;
    return cellule;
}

void inserer(File *f, char v)
{
    assert(f != NULL);
    if (f->tete == NULL){
        f->tete = cellule(v,NULL);
        f->queue = f->tete;
    } else {
        f->queue->suivante = cellule(v,NULL);
        f->queue = f->queue->suivante;
    }
}

void extraire(File *f, char *v)
{
    assert(f != NULL);
    assert(! est_vide(*f));
    *v = f->tete->valeur;
    if (f->tete == f->queue) {
      detruire(f);
    } else {
      f->tete = f->tete->suivante;
    }
}


int longueur(File f)
{
    if (f.tete == NULL){
        return 0;
    } else {
        File fsuivante;
        fsuivante.tete = f.tete->suivante;
        return 1 + longueur(fsuivante);
    }
}
