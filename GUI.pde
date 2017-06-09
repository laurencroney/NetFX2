//G4P Components for toolbox window


GButton btnOpen; //open a video file
GButton btnQuit; //save + quit app
GButton btnRestart; //restart video
GImageToggleButton tglRender; //toggle rendering
GImageToggleButton tglFx; //toggle fx

public void createToolboxUI() {
  toolboxWindow =  GWindow.getWindow(this, "Toolbox", 100, 50, 680, 120, JAVA2D);
  toolboxWindow.addDrawHandler(this, "toolboxDraw");
  toolboxWindow.addMouseHandler(this, "windowMouse");
  toolboxWindow.addKeyHandler(this, "windowKey");
  toolboxWindow.addData(new MyData());
  PApplet app = toolboxWindow;
  btnOpen = new GButton(app,10,10,100,40,"Open File");
  btnRestart = new GButton(app,110,10,100,40,"Restart Video");
  tglRender = new GImageToggleButton(app,210,10);
  tglRender.tag = "Render";
  tglFx = new GImageToggleButton(app,310,10);
  tglFx.tag = "FX On";
  btnQuit = new GButton(app,510,10,100,40,"Save+Quit");
}

public void handleButtonEvents(GButton button, GEvent event) {
  if(button == btnOpen && event == GEvent.CLICKED) {
      selectInput("Select a video:","fileSelected");
  }
  else if(button == btnQuit && event == GEvent.CLICKED) {
      videoExport.endMovie();
      exit();
  }
  else if(button == btnRestart && event == GEvent.CLICKED) {
      m.jump(0);
  }
  
}

// Event handler for image toggle buttons
public void handleToggleButtonEvents(GImageToggleButton button, GEvent event) { 
  println(button + "   State: " + button.getState());
  if(button == tglRender && event == GEvent.CLICKED) {
    render = !render;
  }
  else if(button == tglFx && event == GEvent.CLICKED) {
    fx_on = !fx_on;
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
    bd.setThreshold(0.35f);
    bd.computeBlobs(m.pixels);
    loaded = true;
    
  }
}


public void toolboxDraw(PApplet app, GWinData data){
    app.background(0);
    
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