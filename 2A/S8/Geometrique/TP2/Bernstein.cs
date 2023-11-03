﻿using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine;
using UnityEngine.UI;

//////////////////////////////////////////////////////////////////////////
///////////////// Classe qui gère les polys de Bernstein /////////////////
//////////////////////////////////////////////////////////////////////////
public class Bernstein : MonoBehaviour
{

    // Nombre de polynmes de Bernstein a dessiner
    public int nombrePolynomesBernstein = 1;
    // Slider : permet de choisir le nombre de poly depuis la simulation
    public Slider slider;
    // pas d'échantillonage pour affichage
    private float pas = 0.01f;
    // Liste des couleurs pour affichage
    private Color[] listeCouleurs = new Color[] { Color.blue, Color.cyan, Color.green, Color.magenta, Color.red, Color.yellow };
    // Listes des différents points composants les polynomes de Bernstein
    // ListePoints[0] : liste des points composant le poly de Bernstein 0 sur n-1
    private List<List<Vector2>> ListePoints = new List<List<Vector2>>();

    //////////////////////////////////////////////////////////////////////////
    // fonction : buildPolysBernstein                                       //
    // semantique : remplit le vecteur ListePoints avec les listes des points//
    //              composant les polys de Bernstein                        //
    // params : aucun                                                       //
    // sortie : aucune                                                      //
    //////////////////////////////////////////////////////////////////////////
    void buildPolysBernstein() {

        List<float> echant = buildEchantillonnage();

        for (int i = 0; i <= nombrePolynomesBernstein; i++)
        {
            List<Vector2> points = new List<Vector2>();
            long coefBinomial = KparmiN(i, nombrePolynomesBernstein);
            for (int k = 0; k < echant.Count; k++)
            {
                float t = echant[k];
                float polynome = coefBinomial * (float) Math.Pow(t, i) * (float) Math.Pow(1 - t, nombrePolynomesBernstein - i); 
                points.Add(new Vector2(t, polynome));
            }
            ListePoints.Add(points);
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // Fonction KparmiN                                                       //
    // Semantique : etant donnés k et n, calcule k parmi n                     //
    // Entrees : - int k                                                      //
    //           - int n                                                      //
    // Sortie : k parmi n                                                     //
    ////////////////////////////////////////////////////////////////////////////
    
    long KparmiN(int k, int n)
    {
        return factorielle(n) / (factorielle(k) * factorielle(n - k));
    }

    int factorielle(int n)
    {
        int result = 1;
        for (int i = 1; i <= n; i++)
        {
            result *= i;
        }
        return result;
    }
    
    //////////////////////////////////////////////////////////////////////////
    // fonction : buildEchantillonnage                                      //
    // semantique : construit un échantillonnage regulier                   //
    // params : aucun                                                       //
    // sortie :                                                             //
    //          - List<float> tToEval : échantillonnage regulier            //
    //////////////////////////////////////////////////////////////////////////
    List<float> buildEchantillonnage()
    {
        List<float> tToEval = new List<float>();
        for (float t = 0; t <= 1; t += pas)
        {
            tToEval.Add(t);
        }
        return tToEval;
    }

    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////// NE PAS TOUCHER //////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
     void Start()
    {
        buildPolysBernstein();
    }

    void Update()
    {
        if (slider.value != nombrePolynomesBernstein) {
            nombrePolynomesBernstein = (int)slider.value;
            ListePoints.Clear();
            buildPolysBernstein();
        }
    }

    void OnDrawGizmosSelected()
    {
        float profondeur = -2.0f;
        for (int i = 0; i < ListePoints.Count; ++i)
        {
            Gizmos.color = listeCouleurs[i % listeCouleurs.Length];
            List<Vector2> listePointsPolynome = ListePoints[i];
            for (int j = 0; j < listePointsPolynome.Count - 1; ++j)
            {
                Vector3 p1 = new Vector3(listePointsPolynome[j].x, profondeur, listePointsPolynome[j].y);
                Vector3 p2 = new Vector3(listePointsPolynome[j + 1].x, profondeur, listePointsPolynome[j + 1].y);
                Gizmos.DrawLine(p1, p2);
            }
        }
        Gizmos.color = Color.black;
        Gizmos.DrawLine(new Vector3(1.0f,profondeur,0.0f), new Vector3(0.0f,profondeur,0.0f));
        Gizmos.DrawLine(new Vector3(0.0f,profondeur,0.0f), new Vector3(0.0f,profondeur,1.0f));
    }
}