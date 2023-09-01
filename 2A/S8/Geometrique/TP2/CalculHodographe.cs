using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CalculHodographe : MonoBehaviour
{
    // Nombre de subdivision dans l'algo de DCJ
    public int NombreDeSubdivision = 3;
    // Liste des points composant la courbe de l'hodographe
    private List<Vector3> ListePoints = new List<Vector3>();
    // Donnees i.e. points cliqués

    public GameObject Donnees;
    public GameObject particle;

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

        for (int i = n - 1; i >= 0; i--) {
            for (int j = 0; j < i; j++) {
                X[j] = (X[j + 1] + X[j])/2f;
                Y[j] = (Y[j + 1] + Y[j])/2f;
            }
            Qx.Add(X[0]);
            Qy.Add(Y[0]);

            Rx.Add(X[i]);
            Ry.Add(Y[i]);

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
    // fonction : Hodographe                                                //
    // semantique : renvoie la liste des vecteurs vitesses entre les paires //
    //              consécutives de points de controle                      //
    //              approximante selon un nombre de subdivision données     //
    // params : - List<float> X : abscisses des point de controle           //
    //          - List<float> Y : odronnees des point de controle           //
    //          - float Cx : offset d'affichage en x                        //
    //          - float Cy : offset d'affichage en y                        //
    // sortie :                                                             //
    //          - (List<float>, List<float>) : listes composantes des       //
    //            vecteurs vitesses sous la forme (Xs,Ys)                   //
    //////////////////////////////////////////////////////////////////////////
    (List<float>, List<float>) Hodographe(List<float> X, List<float> Y, float Cx = 1.5f, float Cy = 0.0f)
    {
        List<float> Xs = new List<float>();
        List<float> Ys = new List<float>();

        int n = X.Count;
        
        for (int i = 0; i < n-1; i++)
        {
            Xs.Add(n * (X[i + 1] - X[i]) - Cx);
            Ys.Add(n * (Y[i + 1] - Y[i]) - Cy);
        }

        return (Xs, Ys);
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
            Instantiate(particle, new Vector3(1.5f, -4.0f, 0.0f), Quaternion.identity);
            var ListePointsCliques = GameObject.Find("Donnees").GetComponent<Points>();
            if (ListePointsCliques.X.Count > 0)
            {
                List<float> XSubdivision = new List<float>();
                List<float> YSubdivision = new List<float>();
                List<float> dX = new List<float>();
                List<float> dY = new List<float>();
                
                (dX, dY) = Hodographe(ListePointsCliques.X, ListePointsCliques.Y);

                (XSubdivision, YSubdivision) = DeCasteljauSub(dX, dY, NombreDeSubdivision);
                for (int i = 0; i < XSubdivision.Count; ++i)
                {
                    ListePoints.Add(new Vector3(XSubdivision[i], -4.0f, YSubdivision[i]));
                }
            }

        }
    }

    void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.blue;
        for (int i = 0; i < ListePoints.Count - 1; ++i)
        {
            Gizmos.DrawLine(ListePoints[i], ListePoints[i + 1]);
        }
    }
}
