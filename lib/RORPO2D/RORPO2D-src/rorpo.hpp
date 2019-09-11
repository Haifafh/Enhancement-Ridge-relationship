/* Copyright Odyssee Merveille (2017)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>. 1

 */

#ifndef RORPO_HPP
#define RORPO_HPP

#include <vector>
#include <iostream>
#include <limits>
#include <stdlib.h>
#include <math.h>

#include "po.hpp"
#include "image.hpp"
#include "image_operations.hpp"
#include "basic_operators.hpp"
#include "sort_functions.hpp"
#include "image_png.hpp"


//Return the angle in degree from an angle in radian.
template<typename PixelType>
float get_degrees(PixelType rad){
    return (rad * 180) / M_PI;
}

// Perfom the dot product between to vectors "v1" and "v2"
template<typename PixelType>
PixelType dot_product(std::vector<PixelType> v1, std::vector<PixelType> v2){

    PixelType res = 0;
    for (int i = 0 ; i < v1.size() ; ++i){
        res += v1[i] * v2[i];
    }

    return res;
}

// Return the euclidean norm of a vector
template<typename PixelType>
float vector_norm(std::vector<PixelType> v){
    float res  = sqrt(dot_product(v,v));
    return res;
}


// Compute the angle (in radian) between two vectors "v1" and "v2".
template<typename PixelType>
float angle(std::vector<PixelType> v1, std::vector<PixelType> v2){
    float res;

    res = dot_product(v1, v2) / (vector_norm(v1) * vector_norm(v2));

    if (res > 1)
        res = 1;
    if (res < -1)
        res = -1;

    res = acos(res);

    return res;
}

// Compute the angle (in degree) between two vectors "v1" and "v2".
template<typename PixelType>
float angle_degree(std::vector<PixelType> v1, std::vector<PixelType> v2){
    float res;

    res = dot_product(v1, v2) / (vector_norm(v1) * vector_norm(v2));

    if (res > 1)
        res = 1;
    if (res < -1)
        res = -1;

    res = acos(res);

    return get_degrees(res);
}

// Return the cartesian coordinates of the 2D path opening orientation number "num".
template<typename PixelType>
std::vector<float> cartesian_coord_from_ori(int num){

    std::vector<float> vec(2);
    if (num == 0){       // o1
        vec[0] = 0;
        vec[1] = 1;
    }
    else if (num == 1){  // o2
        vec[0] = 1;
        vec[1] = 0;
    }
    else if (num == 2){  // o3
        vec[0] = 1;
        vec[1] = 1;
    }
    else{                // 04
        vec[0] = -1;
        vec[1] = 1;
    }

    return vec;
}

// Compute the sum of "n" vectors (vx.size = vy.size = n), and return the normalized vector.
template<typename PixelTYpe>
std::vector<float> sum_vectors(std::vector<float> vx, std::vector<float> vy){

    std::vector<float> sumVec(2, 0);
    for (int i = 0 ; i < vx.size() ; ++i){
        sumVec[0] += vx[i];
        sumVec[1] += vy[i];
    }

    // normalize vector
    float norm = sqrt(pow(sumVec[0],2) + pow(sumVec[1],2));
    sumVec[0] /= norm;
    sumVec[1] /= norm;


    return sumVec;

}

/* Correct the orientations coded in "vx" and "vy" in order to be able to combine them meaningfuly.
 * For more information, see "Odyssée Merveille. RORPO: A morphological framework for curvilinear structure analysis.
 * Application to the filtering and segmentation of blood vessels. Phd thesis",
 * Section 5.3.2 (https://hal.archives-ouvertes.fr/tel-01462887/).
 *
 * Input: "vx" and "vy" (vectors coordinates)
 * Output: "vx" and "vy" (modifies the input)
 */
template<typename PixelType>
void correction_orientations(std::vector<float> &vx, std::vector<float> &vy){

    std::vector<int> combi(2);
    combi[0] = 1;
    combi[1] = -1;
    std::vector<int>::iterator it, it2, it3;

    int sumAngle = 360;

    if (vx.size() == 3) // 3 orientations of interest
    {
        std::vector<int> bestCombi(2);
        for (it = combi.begin() ; it < combi.end() ; ++it){
            for (it2 = combi.begin() ; it2 < combi.end() ; ++it2){

                std::vector<float> v1(2), v2(2), v3(2);
                v1[0] =  vx[0];
                v1[1] =  vy[0];
                v2[0] = *it * vx[1];
                v2[1] = *it * vy[1];
                v3[0] = *it2 * vx[2];
                v3[1] = *it2 * vy[2];

                int sum = angle_degree(v1,v2) +  angle_degree(v1,v3) +  angle_degree(v2,v3);

                if (sum < sumAngle){
                    sumAngle = sum;
                    bestCombi[0] = *it;
                    bestCombi[1] = *it2;
                }
            }
        }


        // Correct the orientations
        vx[1] = bestCombi[0] * vx[1];
        vy[1] = bestCombi[0] * vy[1];
        vx[2] = bestCombi[1] * vx[2];
        vy[2] = bestCombi[1] * vy[2];
    }

    if (vx.size() == 2) // 2 orientations of interest
    {
        int bestCombi = 0;
        for (it = combi.begin() ; it < combi.end() ; ++it){

            std::vector<float> v1(2), v2(2);
            v1[0] = vx[0];
            v1[1] = vy[0];
            v2[0] = *it * vx[1];
            v2[1] = *it * vy[1];

            int sum = angle_degree(v1,v2);

            if (sum < sumAngle){
                sumAngle = sum;
                bestCombi = *it;
            }
        }

        //Correct the orientations
        vx[1] = bestCombi * vx[1];
        vy[1] = bestCombi * vy[1];
    }
}

/* Compute RORPO on image "image" with path length "L" and robust parameter "robustParameter".
 * Return the intensity feature along with the directional feature ("directionVectorX" and "directionVectorY")
 *
 * Input:  "image" (initial image)
 *         "L" (path length)
 *         "robustParameter" (robust parameter, usually 0 or 1)
 *
 * Output: "intensityFeature" (image of the intensity feature)
 *         "directionVectorX" and "directionVectorY" (images with x and y coordinates of the directional feature)
*/
template<typename PixelType>
Image2D<PixelType> RORPO(const Image2D<PixelType> &image,
                         int L,
                         Image2D<float> &directionVectorX,
                         Image2D<float> &directionVectorY,
                         int robustParameter){

    int dimX = image.dimx();
    int dimY = image.dimy();

    Image2D<PixelType> imageWithBorder = image.add_border();

    // Dilation of the initial image (required for the robust version of PO)
    Image2D<PixelType> dilat = dilation_rect(imageWithBorder,robustParameter);

   // Orientation vectors encoding
    std::vector<int> orientation1(2);
    orientation1[0] = 0;
    orientation1[1] = 1;
    std::vector<int> orientation2(2);
    orientation2[0] = 1;
    orientation2[1] = 0;
    std::vector<int> orientation3(2);
    orientation3[0] = 1;
    orientation3[1] = 1;
    std::vector<int> orientation4(2);
    orientation4[0] = -1;
    orientation4[1] = 1;

    // Compute the path openings (PO) in each orientation
    Image2D<PixelType> poOri1(dimX, dimY);
    Image2D<PixelType> poOri2(dimX, dimY);
    Image2D<PixelType> poOri3(dimX, dimY);
    Image2D<PixelType> poOri4(dimX, dimY);

    // sort index of imageWithBorder (required for the PO algorithm).
    std::vector<int32_t> indexImage=
            sort_image_value<unsigned char,int32_t>(dilat.get_pointer(),
                                                 dilat.image_size());

    PO_2D<PixelType>(dilat, L, indexImage, orientation1, poOri1);
    PO_2D<PixelType>(dilat, L, indexImage, orientation2, poOri2);
    PO_2D<PixelType>(dilat, L, indexImage, orientation3, poOri3);
    PO_2D<PixelType>(dilat, L, indexImage, orientation4, poOri4);

    // Min with the initial image (required for the robust version of PO)
    poOri1 = min_images<PixelType>(image, poOri1);
    poOri2 = min_images<PixelType>(image, poOri2);
    poOri3 = min_images<PixelType>(image, poOri3);
    poOri4 = min_images<PixelType>(image, poOri4);

    // Rank the RPO responses
    Image2D<PixelType> poOri1Sorted(poOri1);
    Image2D<PixelType> poOri2Sorted(poOri2);
    Image2D<PixelType> poOri3Sorted(poOri3);
    Image2D<PixelType> poOri4Sorted(poOri4);

    Image2D<int> indicePoSorted1(dimX, dimY);
    Image2D<int> indicePoSorted2(dimX, dimY);
    Image2D<int> indicePoSorted3(dimX, dimY);
    Image2D<int> indicePoSorted4(dimX, dimY);

    sort_argsort_images<PixelType>(poOri1Sorted,
                                   poOri2Sorted,
                                   poOri3Sorted,
                                   poOri4Sorted,
                                   indicePoSorted1,
                                   indicePoSorted2,
                                   indicePoSorted3,
                                   indicePoSorted4);

    // Compute the RORPO intensity feature
    Image2D<PixelType> intensityFeature = image_substraction<PixelType>(poOri4Sorted ,
                                                                        poOri1Sorted);

    // #############################################################
    //                      Directional feature
    // #############################################################

    Image2D<unsigned char> thresholdImage = threshold_image<PixelType>(intensityFeature, 1);

    PixelType stdClass;
    int indice;

    for (int i = 0 ; i < dimX ; ++i){
        for (int j = 0 ; j < dimY ; ++j){
            if (thresholdImage(i,j) != 0){

                std::vector<PixelType> vec1(4);
                vec1[0] = poOri1Sorted(i,j); // min RPO response
                vec1[1] = poOri2Sorted(i,j);
                vec1[2] = poOri3Sorted(i,j);
                vec1[3] = poOri4Sorted(i,j);  // max RPO response

                PixelType minStd = std::numeric_limits<PixelType>::max();
                std::vector<PixelType> vec2;

                // Compute the sum of the intra-class standard deviation for each class
                // Keep the class with the smallest std.
                for (int ind = 0; ind < 3 ; ++ind){
                    vec2.push_back(vec1.back());
                    vec1.pop_back();

                    stdClass = standard_deviation(vec1) + standard_deviation(vec2);

                    // Chose min std
                    if (stdClass < minStd){
                        minStd = stdClass;
                        indice = ind;
                    }
                }

                /* Select the orientations of interest
                - indice = 0
                    1 orientation of interest (indicePoSorted4)
                - indice = 1
                   2 orientations of interest (indicePoSorted4, indicePoSorted3)
                - indice = 2
                   3 orientations of interest (indicePoSorted4, indicePoSorted3, indicePoSorted2)
                */
                std::vector<float> vx;
                std::vector<float> vy;
                std::vector<float> temp2(2);
                std::vector<float> temp3(2);

                // indice = 0
                std::vector<float> temp = cartesian_coord_from_ori<PixelType>(indicePoSorted4(i,j));
                vx.push_back(temp[0]);
                vy.push_back(temp[1]);

                if (indice > 0){ // indice = 1
                    temp2 = cartesian_coord_from_ori<PixelType>(indicePoSorted3(i,j));
                    vx.push_back(temp2[0]);
                    vy.push_back(temp2[1]);
                }

                if (indice > 1 ){ // indice = 2
                    temp3 = cartesian_coord_from_ori<PixelType>(indicePoSorted2(i,j));
                    vx.push_back(temp3[0]);
                    vy.push_back(temp3[1]);
                }

                // Correct the vectors if required
                if (indice > 0){
                    correction_orientations<PixelType>(vx,vy);
                }

                // Compute the final orientation from orientations of interest
                std::vector<float> directionVec = sum_vectors<PixelType>(vx, vy);

                // Update the final orientation
                directionVectorX(i,j) = directionVec[0];
                directionVectorY(i,j) = directionVec[1];

            } //end if thresholdImage
        }
    }


    return intensityFeature;
}

/* Compute RORPO multiscale on image "image".
 *
 * Input:  "image" (inital image)
 *         "Lmin" (minimum path length)
 *         "factor" (factor to compute the scales)
 *         "nbScales" (number of scales)
 *         "robustParameter" (robust parameter, usually 0 or 1)
 *
 * Output: "multiScaleIntensityFeature" (image of the intensity feature)
 *         "multiScaleDirectionVectorX" and "multiScaleDirectionVectorY" (images with x and y coordinates of the directional feature)
*/
template<typename PixelType>
Image2D<PixelType> RORPO_multiscale(const Image2D<PixelType> &image,
                         int Lmin,
                         float factor,
                         int nbScales,
                         Image2D<float> &multiScaleDirectionVectorX,
                         Image2D<float> &multiScaleDirectionVectorY,
                         int robustParameter){


    int dimX = image.dimx();
    int dimY = image.dimy();
    Image2D<PixelType> multiScaleIntensityFeature(dimX, dimY);

    // Compute the scales
    std::vector<int> vecScales(nbScales);
    std::cout<<"Scales: ";
    for (int i = 0; i < nbScales; ++i){
        vecScales[i] = Lmin * pow(factor,i);
        std::cout<<vecScales[i]<< " ";
    }
    std::cout<<std::endl;

    // For each scale compute RORPO
    for (int i= 0; i<nbScales; ++i){

        Image2D<float> directionVectorX(dimX, dimY);
        Image2D<float> directionVectorY(dimX, dimY);

        Image2D<PixelType> intensityFeature = RORPO(image, vecScales[i], directionVectorX, directionVectorY, robustParameter);

        // Merge the results between scales.
        for (int i = 0; i < dimX; ++i){
            for (int j = 0; j < dimY ; ++j){
                if (intensityFeature(i,j) > multiScaleIntensityFeature(i,j)){
                    multiScaleIntensityFeature(i,j) = intensityFeature(i,j);
                    multiScaleDirectionVectorX(i,j) = directionVectorX(i,j);
                    multiScaleDirectionVectorY(i,j) = directionVectorY(i,j);
                }
            }
        }
    }
    return multiScaleIntensityFeature;
}



#endif // RORPO_HPP

