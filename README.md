# POSSM
Pressure-film Open Source Scanning and Mapping

POSSM is an image processing software and Graphic User Interface (GUI) written for GNU Octave. POSSM processes images of pressure sensitive films, such as fujifilm prescale, and outputs at-a-glance graphics like pressuremaps, histograms, and 3D surface maps. POSSM also outputs histogram pressure data as a .csv for further data analysis.

POSSM also has batch processing capabilities. If the "process batch" option is checked, POSSM will check what operations you have currently applied to your pressure-film image (PfI), and then apply them to every image file inside a target directory, outputting results to another target directory.



PREPARING PRESSURE-FILM IMAGES FOR USE WITH POSSM
--------------------------------------------------
Note: Preparing PfIs for POSSM is easiest to do if your PfIs have some sort of registration mark on them, a spot where the film has experienced maximum pressure for maximum color saturation. 

PROCESSING GRAYSCALE PFIS
POSSM works best with black and white images. You can prepare your PfI for POSSM by editing it in a photo-editing software, such as krita or GIMP (both free and open source). POSSM works under the assumption that when it sees a black and white image, white value 255 is a zero pressure location and black value 0 is a maximum pressure location. 

1) Desaturate your PfI using your photo-editing software.
2) Adjust the levels of the image so that a maximum pressure location appears as black value 0 (easiest done with a registration mark), and a zero pressure location appears as white value 255.
3) Crop your PfI so that your registration mark and the edges of the film will not appear in your dataset and save your new PfI under a reconizable filename.
4) After loading your image into POSSM, be sure to click "grayscale" so that POSSM can flatten your image from RGB colorspace into grayscale. this may not always be necescary, but is a good precaution to take.


DECOLORIZING COLOR PFIS
POSSM can process color images without them being edited, but it is less precise than editing them yourself. POSSM will assume that, after taking a histogram of your PfI, that the color value with the most counts should be interpreted as 255 white, and the color value with the most intense saturation should be interpreted as 0 black. This means that color PfIs you would like POSSM to process must fit some specific criteria:

1) PfI must be cropped such that the edges of the pressure-film are not visible
2) A registration mark must be visible, or some part of the film must be fully saturated.
3) A significant (greater than any other single value) area of blank film must be visible. This can be achieved by leaving a portion of the pressure-film unused when you apply your load.
