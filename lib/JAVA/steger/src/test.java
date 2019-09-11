import ij.ImagePlus;
import ij.io.Opener;
import ij.process.ImageProcessor;

import java.util.ArrayList;

import de.biomedical_imaging.ij.steger.Junctions;
import de.biomedical_imaging.ij.steger.LineDetector;
import de.biomedical_imaging.ij.steger.Lines;


public class test {

	/**
	 * @param args
	 */
	final static double lineWidthDefault = 10;
	double lineWidth = lineWidthDefault;

	final static double contrastHighDefault = 230;
	double contrastHigh = contrastHighDefault;
	
	final  static double contrastLowDefault = 50;
	double contrastLow = contrastLowDefault;
	
	final static double sigmaDefault = 3.39;
	
	final static double lowerThreshDefault = 0.0;
	
	final static double upperThreshDefault = 1.19;

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		ArrayList<Lines> result; 
		ArrayList<Junctions> resultJunction;
		boolean isDarkLine = true;
		boolean doCorrectPosition = false;
		boolean doEstimateWidth = false;
		boolean doExtendLine = true;
		double lowerThresh = lowerThreshDefault;
		double upperThresh = upperThreshDefault;
		double sigma = 3.39;
		result = new ArrayList<Lines>();
		resultJunction = new ArrayList<Junctions>();
		
		Opener opener = new Opener();  
		String imageFilePath = "./images/image.jpg";
		ImagePlus imp = opener.openImage(imageFilePath);
		ImageProcessor ip = imp.getProcessor();
		
		LineDetector detect = new LineDetector();
		result.add(detect.detectLines(ip, sigma, upperThresh, lowerThresh, isDarkLine, doCorrectPosition, doEstimateWidth, doExtendLine));
		//usedOptions = detect.getUsedParamters();
		resultJunction.add(detect.getJunctions());
		System.out.print("helo");

	}

}
