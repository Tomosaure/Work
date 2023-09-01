using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

//////////////////////////////////////////////////////////////////////////
///////////////// Classe qui gère la subdivision via DCJ /////////////////
//////////////////////////////////////////////////////////////////////////
public class DeCasteljauSubdivision : MonoBehaviour
{
    // Pas d'échantillonage pour affichage
    public float pas = 1 / 100;
    // Nombre de subdivision dans l'algo de DCJ
    public int NombreDeSubdivision = 3;
    // Liste des points composant la courbe
    private List<Vector3> ListePoints = new List<Vector3>();
    // Donnees i.e. points cliqués
    public GameObject Donnees;
    // Coordonnees des points composant le polygone de controle
    private List<float> PolygoneControleX = new List<float>();
    private List<float> PolygoneControleY = new List<float>();

    //////////////////////////////////////////////////////////////////////////
    // fonction : DeCasteljauSub                                            //
    // semantique : renvoie la liste des points composant la courbe         //
    //              approximante selon un nombre de subdivision données     //
    // params : - List<float> X : abscisses des point de controle           //
    //          - List<float> Y : odronnees des point de controle           //
    //          - int nombreDeSubdivision : nombre de subdivision           //
    // sortie :                                                             //
    //          - (List<float>, List<float>) : liste des abscisses et liste //
    //            des ordonnées des points composant la courbe              //
    //////////////////////////////////////////////////////////////////////////
    (List<float>, List<float>) DeCasteljauSub(List<float> X, List<float> Y, int nombreDeSubdivision)
    {
        int n = X.Count;

        List<float> Qx = new List<float>();
        List<float> Qy = new List<float>();

        List<float> Rx = new List<float>();
        List<float> Ry = new List<float>();

        Qx.Add(X[0]);
        Qy.Add(Y[0]);

        Rx.Add(X[n - 1]);
        Ry.Add(Y[n - 1]);

        for (int i = n - 1; i > 0; i--) {
            for (int j = 0; j < i; j++) {
                X[j] = (X[j + 1] + X[j])/2f;
                Y[j] = (Y[j + 1] + Y[j])/2f;
            }
            Qx.Add(X[0]);
            Qy.Add(Y[0]);

            Rx.Add(X[i-1]);
            Ry.Add(Y[i-1]);

        }
        Rx.Reverse();
        Ry.Reverse();

        if (nombreDeSubdivision == 1) {
            
            Rx.RemoveAt(0);
            Ry.RemoveAt(0);
            Qx.AddRange(Rx);
            Qy.AddRange(Ry);

            return (Qx, Qy);

        } else {

            (List<float> Qx_sub, List<float> Qy_sub) = DeCasteljauSub(Qx, Qy, nombreDeSubdivision - 1);
            (List<float> Rx_sub, List<float> Ry_sub) = DeCasteljauSub(Rx, Ry, nombreDeSubdivision - 1);
            Qx_sub.AddRange(Rx_sub);
            Qy_sub.AddRange(Ry_sub);

            return (Qx_sub, Qy_sub);
        }

    }

    //////////////////////////////////////////////////////////////////////////
    //////////////////////////// NE PAS TOUCHER //////////////////////////////
    //////////////////////////////////////////////////////////////////////////
    void Start()
    {

    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Return))
        {
            var ListePointsCliques = GameObject.Find("Donnees").GetComponent<Points>();
            if (ListePointsCliques.X.Count > 0)
            {
                for (int i = 0; i < ListePointsCliques.X.Count; ++i)
                {
                    PolygoneControleX.Add(ListePointsCliques.X[i]);
                    PolygoneControleY.Add(ListePointsCliques.Y[i]);
                }
                List<float> XSubdivision = new List<float>();
                List<float> YSubdivision = new List<float>();

                (XSubdivision, YSubdivision) = DeCasteljauSub(ListePointsCliques.X, ListePointsCliques.Y, NombreDeSubdivision);
                for (int i = 0; i < XSubdivision.Count; ++i)
                {
                    ListePoints.Add(new Vector3(XSubdivision[i], -4.0f, YSubdivision[i]));
                }
            }

        }
    }

    void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        for (int i = 0; i < PolygoneControleX.Count - 1; ++i)
        {
            Gizmos.DrawLine(new Vector3(PolygoneControleX[i], -4.0f, PolygoneControleY[i]), new Vector3(PolygoneControleX[i + 1], -4.0f, PolygoneControleY[i + 1]));
        }

        Gizmos.color = Color.blue;
        for (int i = 0; i < ListePoints.Count - 1; ++i)
        {
            Gizmos.DrawLine(ListePoints[i], ListePoints[i + 1]);
        }
    }
}