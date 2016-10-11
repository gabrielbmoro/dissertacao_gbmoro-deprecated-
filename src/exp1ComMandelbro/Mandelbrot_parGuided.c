/* 
    c program:
    --------------------------------
    1. draws Mandelbrot set for Fc(z)=z*z +c
    using Mandelbrot algorithm ( boolean escape time )
    -------------------------------         
    2. technique of creating ppm file is  based on the code of Claudio Rocchini
    http://en.wikipedia.org/wiki/Image:Color_complex_plot.jpg
    create 24 bit color graphic file ,  portable pixmap file = PPM 
    see http://en.wikipedia.org/wiki/Portable_pixmap
    to see the file use external application ( graphic viewer)
*/

 #include <stdio.h>
 #include <stdlib.h>
 #include "cmp134.h"
 #include <omp.h>
 #include <math.h>

    void printerOfMatrix(int *, int);

    int main(int argc, char *argv[])
    {
    	int iX,iY;
    	int iXmax = 800; 
    	int iYmax = 800;
    	double Cx,Cy;
    	const double CxMin=-2.5;
    	const double CxMax=1.5;
    	const double CyMin=-2.0;
    	const double CyMax=2.0;
    	double PixelWidth=(CxMax-CxMin)/iXmax;
    	double PixelHeight=(CyMax-CyMin)/iYmax;
    	const int MaxColorComponentValue=255;         
    	char *filename="new1.ppm";
    	char *comment="# ";
    	static unsigned char color[3];
    	double Zx, Zy;
    	double Zx2, Zy2;
    	int Iteration;

    	const int IterationMax=200;
    	const double EscapeRadius=2;
    	double ER2=EscapeRadius*EscapeRadius;
    	
    	#ifdef DEBUG
    	int *mat;
    	#endif
    	
    	if(argc == 2)
    	{
    		iXmax = atoi(argv[1]);
    		iYmax = atoi(argv[1]);
    	}
		
		#ifdef DEBUG
    	mat = calloc(iYmax * iXmax, sizeof(int));
    	int i=0;
    	#endif

    	CMP134_DECLARE_TIMER;
    	CMP134_START_TIMER;

        #pragma omp parallel for private(PixelHeight,PixelWidth,color,Zx2,Zy2,Zx,Zy,Cx,Cy,iX,iY,Iteration) schedule(guided)
    	for(iY=0;iY<iYmax;iY++)
    	{
    		Cy= CyMin + iY * PixelHeight;
    		
    		if (fabs(Cy) < PixelHeight/2) Cy=0.0; 
    		for(iX=0;iX < iXmax;iX++)
    		{         
    			Cx=CxMin + iX*PixelWidth;
    			Zx=0.0;
    			Zy=0.0;
    			Zx2=Zx*Zx;
    			Zy2=Zy*Zy;

    			for (Iteration=0; Iteration < IterationMax && ((Zx2+Zy2)<ER2);Iteration++)
    			{
    				Zy=2*Zx*Zy + Cy;
    				Zx=Zx2-Zy2 +Cx;
    				Zx2=Zx*Zx;
    				Zy2=Zy*Zy;
    			};
    			if (Iteration==IterationMax)
    			{
    				color[0]=0;
    				color[1]=0;
    				color[2]=0;                           
    			}
    			else 
    			{ 
    				color[0]=255; 
    				color[1]=255;  
    				color[2]=255;
    			};
    		}
    	
    		#ifdef DEBUG
    		if((i+3) < iYmax*iXmax)
    		{
    			mat[iY * iYmax + i] = color[0];
    			mat[iY * iYmax + (i+1)] = color[1];
    			mat[iY * iYmax + (i+2)] = color[2];
    			i=+3;
    		}
    		#endif
    	
    	}
    	CMP134_END_TIMER;
    	CMP134_REPORT_TIMER;
    	
    	#ifdef DEBUG
    	printerOfMatrix(mat, iYmax);
    	free(mat);
    	#endif
    	
    	return 0;
    }

    void printerOfMatrix(int *mat, int d)
    {
    	int i,j;

    	for(i=0; i < d;i++)
    	{
    		for(j=0; j < d; j++)
    			printf("%d\t", mat[i * d + j]);
    		printf("\n");
    	}
    }
