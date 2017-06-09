/*REPLACE THE EXAMPLE EFFECT BELOW WITH THE DESIRED EFFECT*/
  
  /*
void Effect(int mode, PImage frame) {
  
}
  
*/
void Effect(int mode, PImage cam) {
    //Threshold/posterize or whatever effects:
    //mode 1: standard posterize
    //mode 2: poserize with bars
    //mode 3: psychedeic feedback posterize
    //final color[] thresholds = {#000FFF,#500000,#900000,#B00000,#D00000,#F00000};
    //final color[] thresholds = {  #1B241B, #500000, #855166, #A1E899, #D6A913, #F01A00};
    final color[] thresholds = {  
      #0E172C, #45678A, #8FFFF6, #B00099, #DEADFF, #F1A800
    };
  
    cam.loadPixels();
    //FIXME: row and col are apparently swapped
    for (int row = 0; row < cam.width; row++)
      for (int col = 0; col < cam.height; col++)
      {
        color pix;

      switch(mode) {      
       case 1:
         pix = cam.get(row,col);
       break;
       case 2:
         if (millis() %2 == 0) { 
          pix = cam.get(row, col); //clean posterize
         }  
         else {
          pix = get(row, col); //introduce noise into the image by working from the current screen buffer instead of the clean webcam image
        // pix = pixels[row,col];
         }
         break;
       case 3:
         pix = get(row, col);
         
         break;
       default:
         pix = cam.get(row,col);
      }

        if (pix < thresholds[0])
          cam.set(row, col, thresholds[0]);
        else if (pix < thresholds[1])
          cam.set(row, col, thresholds[1]);
        else if (pix < thresholds[2])
          cam.set(row, col, thresholds[2]);

        else if (pix < thresholds[3])

          cam.set(row, col, thresholds[3]);

        else if (pix < thresholds[4])

          cam.set(row, col, thresholds[4]);

        else if (pix < thresholds[5])
          cam.set(row, col, thresholds[5]);
          
      }

    cam.updatePixels();
    
}