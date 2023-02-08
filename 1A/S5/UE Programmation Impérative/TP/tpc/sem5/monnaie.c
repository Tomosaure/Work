#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#define taille 5

// Definition du type monnaie
struct monnaie {
    char devise;
    float valeur; 
};
typedef struct monnaie monnaie;

typedef monnaie t_porte_monnaie[taille];
/**
 * \brief Initialiser une monnaie 
 * \param[out] m la monnaie a initiliser
 * \param[in] valeur de la monnaie a initiliser
 * \param[in] devise de la monnaie a initiliser
 * \pre valeur > 0
 */
void initialiser(monnaie* m, char devise, float valeur) {
    assert(valeur >= 0);
    m->valeur = valeur;
    m->devise = devise;
}


/**
 * \brief Ajouter une monnaie m2 à une monnaie m1 
 * \param[in] m2 la monnaie à ajouter
 * \param[in out] m1 la monnaie qui va recevoir m2
 */ 
bool ajouter(monnaie* m1, monnaie* m2){
    if (m1 -> devise == m2 -> devise) {
        m1->valeur += m2->valeur;
        return true;
    }
    else {
        return false;
    }
}


/**
 * \brief Tester Initialiser 
 */ 
void tester_initialiser(){
    monnaie m1, m2;
    
    initialiser(&m1,'e',5);
    assert('e' == m1.devise);
    assert(5 == m1.valeur);
    
    initialiser(&m2,'$',7);
    assert('$' == m2.devise);
    assert( 7 == m2.valeur);
    
    printf("\nles tests de la fonction initialiser sont passés \n");
}

/**
 * \brief Tester Ajouter 
 */ 
void tester_ajouter(){
    monnaie m1, m2, m3;
    
    initialiser(&m1,'e',5);
    initialiser(&m2,'$',7);
    initialiser(&m3,'e',3);
    
    assert(!ajouter(&m1,&m2));
    assert(5 == m1.valeur);
    assert(7 == m2.valeur);
    
    assert(ajouter(&m1,&m3));
    assert(8 == m1.valeur);
    assert(3 == m3.valeur);

    printf("les tests de la fonction ajouter sont passés \n");
}



int main(void){
    
    //Programmes de tests
    tester_initialiser();
    tester_ajouter();
    
    //Variables
    float valeur;
    char devise;
    monnaie somme;
    
    // Un tableau de 5 monnaies
    t_porte_monnaie porte_monnaie;

    //Initialiser les monnaies
    for (int i = 0; i<taille ; i++) {
        printf("\nSaisir la devise de la monnaie n°%d : ", i+1);
        scanf("%c",&devise);
        getchar(); //Il semblerai que scanf garde "\n" en mémoire suite au <return> permettant de validé la saisie du caractère
        //Ce qui pose problème puisque le second scanf prendra directement cette valeur stockée dans la mémoire au lieu de la vider 
        //et de prendre la nouvelle saisie de l'utilisateur, une solution qui permet de vider la mémoire tampon de scnaf est d'utilisé getchar();
        printf("\nSaisir la valeur de la monnaie n°%d  : ", i+1);
        scanf("%f", &valeur);
        getchar();
        initialiser(&porte_monnaie[i], devise, valeur);
    }
        
    // Afficher la somme des toutes les monnaies qui sont dans une devise entrée par l'utilisateur.
    printf("\nSaisir la devise pour laquelle vous voulez la somme de la monnaie : ");
    scanf("%c", &devise);
    initialiser(&somme,devise,0.0);
    for (int i =0; i<taille; i++) {
        if (porte_monnaie[i].devise == devise) {
            ajouter(&somme,&porte_monnaie[i]);
        }
    }
    
    printf("\nIl y a %f %c au total dans le porte monnaie", somme.valeur, devise);    

    return EXIT_SUCCESS;
}

