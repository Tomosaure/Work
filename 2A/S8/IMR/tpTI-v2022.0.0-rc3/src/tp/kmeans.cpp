#include "ocv_utils.hpp"

#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <iostream>

using namespace cv;
using namespace std;

// fonction kmoyenne : réalise l'algorithme k-means sur une image
// Données en entrée : Mat& data : image à segmenter
//                     int k : nombre de clusters
//                     Mat& centers : matrice des centres
//                     vector<int>& labels : vecteur des labels
// Données en sortie : void
void kmoyenne(Mat& data, int k, Mat& centers, vector<int>& labels) {

    // On convertit l'image en niveau de gris
    cvtColor(data, data, COLOR_BGR2GRAY);

    //srand(time(0));

    // On initialise les centres
    for (int i = 0; i < k; i++) {
        // On travail en niveaux de gris, un seul canal est donc nécessaire
        // On initialise les centres avec un pas de 255/k
        centers.at<float>(i,2) = (255/k)*i;
        //centers.at<float>(i,2) = rand() % 255;
    }

    // On initialise les labels à 0
    for (int i = 0; i < data.total(); i++) {
        labels.push_back(0);
    }

    bool convergence = false; // Booléen pour vérifier la convergence
    double EPSILON = 0.0001;  // Critère de précision pour la convergence

    // on attribue une étiquette de cluster à chaque pixel en calculant la distance euclidienne entre le pixel et chaque centre
    // on attribue l'étiquette du centre le plus proche
    while(!convergence) {

        // On attribue chaque pixel à un cluster
        for (int i = 0; i < data.total(); i++) {
            int min = 255;
            int index = 0;
            for (int j = 0; j < k; j++) {
                // On travail en niveaux de gris, la distance est donc la différence de niveau de gris
                if (abs(data.at<float>(i) - centers.at<float>(j,2)) < min) {
                    // Le centre le plus proche est celui qui minimise la distance
                    min = abs(data.at<float>(i) - centers.at<float>(j,2));
                    // On stocke l'index du centre le plus proche
                    index = j;
                }
            }
            // On attribue le label au pixel
            labels.at(i) = index;
        }

        // On recalcule les centres
        for (int j = 0; j < k; j++) {
            float sum = 0;
            float count = 0;
            for (int i = 0; i < data.total(); i++) {
                // On chercher les pixels appartenant au centre j, c'est à dire a un même cluster
                if (labels.at(i) == j) {
                    // On additionne les niveaux de gris des pixels du cluster
                    sum += data.at<float>(i);
                    // On compte le nombre de pixels du cluster
                    count++;
                }
            }

            // On calcule la moyenne des niveaux de gris des pixels du cluster
            // Cette valeur est le nouveau centre du cluster
            float newCenter = sum / count; 

            // Si le centre n'a pas bougé, on a convergé
            if (abs(newCenter - centers.at<float>(j,2)) < EPSILON) {
                convergence = true;
            // Sinon on met à jour le centre
            } else {
                convergence = false;
                centers.at<float>(j,2) = newCenter;
            }            
        }
    }

    // On repasse l'image en couleur
    cvtColor(data, data, COLOR_GRAY2BGR);

    return;
}


void printHelp(const string& progName)
{
    cout << "Usage:\n\t " << progName << " <image_file> <K_num_of_clusters> [<image_ground_truth>]" << endl;
}

int main(int argc, char** argv) {
    
    if (argc != 3 && argc != 4)
    {
        cout << " Incorrect number of arguments." << endl;
        printHelp(string(argv[0]));
        return EXIT_FAILURE;
    }

    const auto imageFilename = string(argv[1]);
    const string groundTruthFilename = (argc == 4) ? string(argv[3]) : string();
    const int k = stoi(argv[2]);

    // just for debugging
    {
        cout << " Program called with the following arguments:" << endl;
        cout << " \timage file: " << imageFilename << endl;
        cout << " \tk: " << k << endl;
        if(!groundTruthFilename.empty()) cout << " \tground truth segmentation: " << groundTruthFilename << endl;
    }

    // load the color image to process from file
    Mat m;
    Mat gt;

    // for debugging use the macro PRINT_MAT_INFO to print the info about the matrix, like size and type
    PRINT_MAT_INFO(m);
    PRINT_MAT_INFO(gt);
    
    // 1) in order to call kmeans we need to first convert the image into floats (CV_32F)
    // see the method Mat.convertTo()
    
    m = imread(imageFilename, IMREAD_COLOR);
    if(m.empty())
    {
        cout << "Could not open or find the image" << std::endl;
        return EXIT_FAILURE;
    }

    if (argc == 4) {
        gt = imread(groundTruthFilename, IMREAD_COLOR);
        if(gt.empty())
        {
            cout << "Could not open or find the image" << std::endl;
            return EXIT_FAILURE;
        }
    }

    Mat src = m.clone();
    m.convertTo(m, CV_32F);
    
    // 2) kmeans asks for a mono-dimensional list of "points". Our "points" are the pixels of the image that can be seen as 3D points
    // where each coordinate is one of the color channel (e.g. R, G, B). But they are organized as a 2D table, we need
    // to re-arrange them into a single vector.
    // see the method Mat.reshape(), it is similar to matlab's reshape
    Mat vect = m.reshape(3, m.total());

    // now we can call kmeans(...)
    Mat centers;
    centers.create(k, 3, CV_32F);
    vector<int> labels;
    //kmeans(vect, k, labels, TermCriteria(TermCriteria::EPS+TermCriteria::COUNT, 10, 1.0), 3, KMEANS_PP_CENTERS, centers);
    kmoyenne(vect, k, centers, labels);

    for (int i = 0; i < 3; i++) {
        centers.at<float>(0,i) = 255;
        centers.at<float>(1,i) = 0;
    }

    for (int i = 0; i < m.total(); i++) {
        vect.at<float>(i,0) = centers.at<float>(labels.at(i),0);
        vect.at<float>(i,1) = centers.at<float>(labels.at(i),1);
        vect.at<float>(i,2) = centers.at<float>(labels.at(i),2);
    }

    Mat vect_r = vect.reshape(3, m.rows);

    vect_r.convertTo(vect_r, CV_8U);

    long TP = 0, FP = 0, FN = 0;

    if(!gt.empty()) {

    for (int i = 0; i < m.rows; i++)
    {
        for (int j = 0; j < m.cols; j++)
        {
            if (gt.at<uchar>(i,j) == 255 && vect_r.at<uchar>(i,j) == 255)
                TP++;
            else if (gt.at<uchar>(i,j) == 0 && vect_r.at<uchar>(i,j) == 255)
                FP++;
            else if (gt.at<uchar>(i,j) == 255 && vect_r.at<uchar>(i,j) == 0)
                FN++;
        }
    }

        double Precision   = (double) TP/(TP+FP);
        double Sensibilite = (double) TP/(TP+FN);
        double DICE_coef   = (double) (2*TP)/(2*TP+FP+FN);

        cout << "TP: " << TP << endl;
        cout << "FP: " << FP << endl;
        cout << "FN: " << FN << endl;
        cout << "Précision: " << Precision << endl;
        cout << "Sensibilité: " << Sensibilite << endl;
        cout << "DICE Coefficient: " << DICE_coef << endl;
    }
  
    imwrite("kmeans.jpg", vect_r);

    namedWindow(imageFilename, cv::WINDOW_AUTOSIZE);
    namedWindow("kmeans image", cv::WINDOW_AUTOSIZE);

    imshow(imageFilename, src);
    imshow("kmeans image", vect_r);

    if (!groundTruthFilename.empty()) {
        namedWindow(groundTruthFilename, cv::WINDOW_AUTOSIZE);
        imshow(groundTruthFilename, gt);
    }

    // Wait for a keystroke in the window
    waitKey(0);

    return EXIT_SUCCESS;
}
