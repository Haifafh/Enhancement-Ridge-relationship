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

#ifndef PO_HPP
#define PO_HPP

#include <iostream>
#include <string>
#include <vector>
#include <queue>
#include <algorithm>
#include <iterator>
#include <cassert>

#include "image.hpp"
#include "sort_functions.hpp"
#include "image_operations.hpp"
#include"image_png.hpp"


/* Return the up and down lists of offsets for a given orientation.
 *
 * Input: "nb_col" (number of columns in the image)
 *        "orientation" (vector coding the orientation. e.g. [0,1])
 *
 * Output: "upList" (vector of the up offsets)
 *         "downList" (vector of the down offsets)
 */
void createNeighbourhood2D(int nb_col,
                           const std::vector<int> & orientation,
                           std::vector<int> & upList,
                           std::vector<int> & downList){


/* The four 2D orientations {o1, o2, o3, o4}. The "x" represent the pixels.
         x     x      x
          \    |     /
           o4  o1  o3
             \ | /
         x     x -o2- x

   orientation coding (col, line):
   o1 = (0,1)
   o2 = (1,0)
   o3 = (1,1)
   o4 = (-1,1)
 */


    int col_shift = orientation[0];
    int line_shift = orientation[1];



    // o1 orientation ( South - North )
    if((line_shift == 1 && col_shift == 0) ||
      (line_shift == -1 && col_shift == 0)) {

       upList.push_back( - nb_col - 1);
       upList.push_back( - nb_col + 1);
       upList.push_back( - nb_col);

       downList.push_back( nb_col + 1);
       downList.push_back( nb_col - 1);
       downList.push_back( nb_col);
    }



    // o2 orientation ( West - East )
    if((line_shift == 0 && col_shift == 1) ||
       (line_shift == 0 && col_shift == -1) ) {

       upList.push_back( -nb_col + 1);
       upList.push_back( nb_col + 1);
       upList.push_back( 1);

       downList.push_back( nb_col - 1);
       downList.push_back( -nb_col - 1);
       downList.push_back( -1);
    }



    // o3 orientation (South/West - North/East )
    if((line_shift == 1 && col_shift == 1) ||
      (line_shift == -1 && col_shift == -1)) {

           upList.push_back( -1);
           upList.push_back( nb_col);
           upList.push_back( nb_col - 1);

           downList.push_back( 1 );
           downList.push_back( -nb_col  );
           downList.push_back( -nb_col + 1);
   }


    // o4 orientation (North/West - South/East )
    if((line_shift == -1 && col_shift == 1) ||
      (line_shift == 1 && col_shift == -1)) {

           upList.push_back(1);
           upList.push_back( nb_col + 1);
           upList.push_back( nb_col);

           downList.push_back( -1);
           downList.push_back( -nb_col - 1);
           downList.push_back( -nb_col);
    }
}

/* Path propagation from pixel "p" according to offsets lists nf and nb.
 * See "Hendriks, C. L. L. (2010). Constrained and dimensionality-independent path openings. IEEE Transactions on Image Processing, 19(6), 1587-1595." Fig.2
 *
 * Input: "p" (indice of the current pixel)
 *        "lambda" (image of the current propagation values)
 *        "nf", "nb" (vector of up and down offsets)
 *        "b" (image of activated pixels)
 *        "Qc" (queue of pixels indices)
 *
 * Output: "lambda" (modifies the propagation valuess)
 *         "Qc" (modifies the queue)
 *
*/
template<typename PixelType, typename IndexType>
void propagate(IndexType p, std::vector<int>& lambda, std::vector<int>& nf,std::vector<int>& nb, std::vector<bool>& b,std::queue<IndexType> & Qc){
// Propagation from pixel p

    std::queue<IndexType> Qq;
    lambda[p] = 0;

    std::vector<int>::iterator it;
    for (it = nf.begin(); it != nf.end();++it)
    {
        if ((p+*it)<lambda.size() and b[p+*it])
        {
            Qq.push(p+*it);
        }
    }

    while (not Qq.empty())
    {
        IndexType q = Qq.front();
        Qq.pop();
        int l=0;
        for (it = nb.begin(); it != nb.end(); ++it)
        {
            l=std::max(lambda[q+*it],l);
        }
        l+=1;

        if (l < lambda[q])
        {
            lambda[q] = l;
            Qc.push(q);
            for (it = nf.begin(); it != nf.end(); ++it)
            {
                if (b[q+*it])
                {
                    Qq.push(q+*it);
                }
            }
        }
    }
}

/* Compute the 2D path opening on "imageWithBorder" with path length "L" according orientation "orientations".
 * "IndexImage" is the matrix of the sorted index of imageWithBorder (see function "sort_image_value" in sort_functions.hpp).
 * The result is stored in "outputWithoutBorder".
 * See "Hendriks, C. L. L. (2010). Constrained and dimensionality-independent path openings. IEEE Transactions on Image Processing, 19(6), 1587-1595." Fig.2
 *
 * Input: "imageWithBorder" (initial image with a border)
 *        "L" (path length)
 *        "indexImage"
*/
template<typename PixelType>
void PO_2D(const Image2D<PixelType> &imageWithBorder,
           int L,
           std::vector<int32_t> &indexImage,
           std::vector<int> &orientations,
           Image2D<PixelType> &outputWithoutBorder) {

    int dimY = imageWithBorder.dimy();
    int dimX = imageWithBorder.dimx();

    Image2D<PixelType> outputWithBorder = imageWithBorder;

    // Create the temporary image b  (0 for a 1-pixel border, 1 elsewhere)
    std::vector<bool>b(imageWithBorder.image_size(),1);

    // x = 0
    for (int y = 0 ; y < dimY ; ++y){
            b[y*dimX]=0;

    }

    // x = dimx-1
    for (int y = 0 ; y < dimY ; ++y){
            b[y*dimX+dimX-1]=0;
    }

    // y = 0
    for (int x = 0 ; x < dimX ; ++x){
            b[x]=0;
    }

    // y = dimy-1
    for (int x = 0 ; x < dimX ; ++x){
            b[(dimY-1)*dimX+x]=0;
    }


    // Create the offset np and nm
    std::vector<int>np;
    std::vector<int>nm;
    createNeighbourhood2D(dimX, orientations, np, nm);

    //Create other temporary images
    std::vector<int>Lp(imageWithBorder.image_size(),L);
    std::vector<int>Lm(imageWithBorder.image_size(),L);


    //Create FIFO queue Qc
    std::queue<int32_t> Qc;

    // Propagate
    std::vector<int32_t>::iterator it;
    int indice;
    for (it = indexImage.begin(), indice = 0 ; it != indexImage.end() ; ++it , ++indice)
    {
        if (b[*it])
        {
            propagate<PixelType>(*it, Lm, np, nm, b, Qc);
            propagate<PixelType>(*it, Lp, nm, np, b, Qc);

            while (not Qc.empty())
            {
                int32_t q = Qc.front();
                Qc.pop();
                if (Lp[q] + Lm[q]-1 < L)
                {
                    outputWithBorder.get_data()[q] =
                            outputWithBorder.get_data()[*it];
                    b[q] = 0;
                    Lp[q] = 0;
                    Lm[q] = 0;
                }
            }
        }
    }

    outputWithoutBorder = outputWithBorder.remove_border();

    return ;

}

#endif // PO_HPP

