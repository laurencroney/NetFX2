//G4P Components for toolbox window


GButton btnOpen; //open a video file

public void createToolboxUI() {
  btnOpen = new GButton(this,10,10,100,40,"Open File");
}

public void handleButtonEvents(GButton button, GEvent event) {
  if(button == btnOpen && event == GEvent.CLICKED) {
      selectInput("Select a video:","fileSelected");
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    m = new Movie(this,selection.getAbsolutePath());
    m.loop();
    m.read(); //read a frame so videoExport knows the dimensions of the video
    m.volume(0);
    
    //Initialize library objects that need info about the video size
    videoExport = new VideoExport(this, outfile);
    videoExport.startMovie();
    bd = new BlobDetection(m.width,m.height);
    bd.setPosDiscrimination(true);
    bd.setThreshold(0.70f);
    bd.computeBlobs(m.pixels);
    loaded = true;
    
  }
}


public void toolboxDraw(PApplet app, GWinData data){
    app.background(255);
    app.strokeWeight(2);
    // draw black line to current mouse position
    app.stroke(0);
    app.line(app.width / 2, app.height/2, app.mouseX, app.mouseY);
  }

public void windowMouse(PApplet app, GWinData data, MouseEvent event) {

}

public void windowKey(PApplet app, GWinData data, KeyEvent event) {

}

public class MyData extends GWinData {
    // The variables can be anything you like.
    public int lastClickX,lastClickY;
}

//Key handlers
void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}