#ifndef ENSEIGANT_H
#define ENSEIGANT_H

#include "date.h"

struct enseignant {
	char *nom;
	Date *d_naissance;
};
typedef struct enseignant enseignant;

#endif
