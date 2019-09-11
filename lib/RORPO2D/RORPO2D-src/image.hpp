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


#ifndef IMAGE_HPP
#define IMAGE_HPP

#include <stdlib.h>
#include <iostream>
#include <string>
#include <vector>


template<typename T>
class Image2D {

    public :

        Image2D():
            m_nImageSize(0){}

        Image2D(int dimX, int dimY, int value=0):
             m_nDimx(dimX), m_nDimy(dimY), m_nImageSize(dimX*dimY), m_vImage(dimX*dimY, value){}

        //Copy constructor
        Image2D(Image2D const& copy):
            m_nDimx(copy.m_nDimx), m_nDimy(copy.m_nDimy), m_nImageSize(copy.m_nImageSize), m_vImage(copy.m_vImage){}

        
        ~Image2D(){}


        T& operator ()(int x, int y) {
            return m_vImage[x + y * m_nDimx];
        }
        const T& operator ()(int x, int y) const {
            return m_vImage[x + y * m_nDimx];
        }

        T& operator ()(int i) {
            return m_vImage[i];
        }
        const T& operator ()(int i) const {
            return m_vImage[i];
        }

        const int dimx() const {
            return m_nDimx;
        }

        const int dimy() const {
            return m_nDimy;
        }

        const int image_size() const {
            return m_nImageSize;
        }

        bool empty() const {
            return m_nImageSize == 0;
        }

        std::vector<T>& get_data() {
            return m_vImage;
        }
        const std::vector<T>& get_data() const {
            return m_vImage;
        }

        T* get_pointer(){
            return m_vImage.data();
        }

        int indice(int x, int y){
            return x + y * m_nDimx;
        }

        T return_max(){
            T maxi=0;

            for (int i = 0; i < m_nImageSize ; ++i){
                    if (m_vImage[i] > maxi){
                        maxi = m_vImage[i];
                }
            }
            return maxi;
        }

        T return_min(){
            T mini=0;

            for (int i = 0; i < m_nImageSize ; ++i){
                    if (m_vImage[i] < mini){
                        mini = m_vImage[i];
                }
            }
            return mini;
        }

        // Fill the image with data pointed by pPointer
        void add_data_from_pointer(T* pPointer){
            for (int y = 0 ; y < m_nDimy ; ++y){
                for (int x = 0 ; x < m_nDimx ; ++x){
                    m_vImage[x + y * m_nDimx] = pPointer[x + y * m_nDimx];
                }
            }
        }

        // Add border of 1 pixel
        Image2D<T> add_border() const {

            Image2D<T> imageWithBorder(m_nDimx+2, m_nDimy+2);
            for (int y = 1 ; y < m_nDimy + 1 ; ++y){
                for (int x = 1 ; x < m_nDimx + 1 ; ++x){
                    imageWithBorder(x,y) = m_vImage[x-1 + (y-1) * m_nDimx];
                }
            }
            return imageWithBorder;
        }

        // Remove border of 1 pixel
        Image2D<T> remove_border() const {

            Image2D<T> imageWithoutBorder(m_nDimx-2, m_nDimy-2);
            for (int y = 1 ; y < m_nDimy - 1 ; ++y){
                for (int x = 1 ; x < m_nDimx - 1 ; ++x){
                    imageWithoutBorder(x-1,y-1) = m_vImage[x + y * m_nDimx];
                }
            }
            return imageWithoutBorder;

        }

        void clear_image(){
            m_vImage.clear();
            std::vector<T>().swap(m_vImage);
            m_nImageSize=0;

        }

    private :
        int m_nDimx;
        int m_nDimy;
        int m_nImageSize;
        std::vector<T>m_vImage;

};

#endif // IMAGE_HPP

