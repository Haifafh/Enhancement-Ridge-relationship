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

#ifndef IMAGE_OPERATIONS_HPP
#define IMAGE_OPERATIONS_HPP

#include <iostream>
#include <queue>
#include <algorithm>
#include "image.hpp"



template<typename PixelType>
Image2D<PixelType> min_images(const Image2D<PixelType> &image1, const Image2D<PixelType> &image2){

    Image2D<PixelType> result(image1.dimx(), image1.dimy());
    int i, j;
    for (i = 0; i<image1.dimx() ; ++i){
        for (j = 0 ; j<image1.dimy() ; ++j){
            result(i,j) = std::min(image1(i,j), image2(i,j));
        }
    }
    return result;
}


template<typename PixelType>
Image2D<PixelType> image_substraction(const Image2D<PixelType> &image1, const Image2D<PixelType> &image2){

    if (image1.dimx() != image2.dimx() or image1.dimy() != image2.dimy())
        std::cout<<"Error 'image_substraction': images do not have the same dimensions"<<std::endl;

    int dimX = image1.dimx();
    int dimY = image1.dimy();
    Image2D<PixelType> result(dimX, dimY);

    for (int i = 0 ; i < dimX ; ++i){
        for (int j = 0 ; j < dimY ; ++j){
            result(i,j) = image1(i,j) - image2(i,j);
        }
    }
    return result;
}


template<typename PixelType>
Image2D<unsigned char> threshold_image(const Image2D<PixelType> & image, PixelType threshold){
    Image2D<unsigned char> result(image.dimx(), image.dimy());

    for (int i = 0; i < image.dimx() ; ++i){
        for (int j = 0; j < image.dimy() ; ++j){
            if (image(i,j) > threshold)
                result(i,j) = 1;
            else
                result(i,j) = 0;
        }
    }

    return result;
}


template<typename PixelType>
Image2D<PixelType> dilation_rect(const Image2D<PixelType> &image, int sizeRect){

    Image2D<PixelType> result(image.dimx(), image.dimy());
    int seRadius = sizeRect / 2;

    int i, j;
    for (i = 0 ; i < image.dimx() ; ++i){
        for (j = 0 ; j < image.dimy() ; ++j){

            int xmin = i - seRadius;
            if (xmin < 0){
                xmin = 0;
            }

            int xmax = i + seRadius;
            if (xmax >= image.dimx()){
                xmax = image.dimx() -1;
            }

            int ymin = j - seRadius;
            if (ymin < 0){
                ymin = 0;
            }
            int ymax = j + seRadius;
            if (ymax >= image.dimy()){
                ymax = image.dimy() -1;
            }

            int y, x;
            int maxValue = 0;
            for (x = xmin ; x <= xmax ; ++x){
                for (y = ymin ; y <= ymax ; ++y){

                    if (maxValue < image(x,y)){
                        maxValue = image(x,y);
                    }
                }
            }
            result(i,j) = maxValue;
        }
    }

    return result;
}





#endif // IMAGE_OPERATIONS_HPP

