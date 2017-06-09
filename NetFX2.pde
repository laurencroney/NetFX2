
//BlobFX 0.1 (Lauren Croney)
//Uses Julien 'v3ga' Gachadoat's blob detection algorithm 
//to apply effects to videos and render them to a file

import com.hamoid.*;
import processing.video.*;
import blobDetection.*;
import g4p_controls.*;

//global constant
static String outfile="out.mp4";

Movie m;
VideoExport videoExport;
GWindow toolboxWindow;
BlobDetection bd;

boolean loaded = false; //is a video loaded?
boolean render = false; //should we save frames?

void setup() {
  
  /*Set up the Toolbox UI*/
  toolboxWindow =  GWindow.getWindow(this, "Toolbox", 100, 50, 680, 120, JAVA2D);
  toolboxWindow.addDrawHandler(this, "toolboxDraw");
  toolboxWindow.addMouseHandler(this, "windowMouse");
  toolboxWindow.addKeyHandler(this, "windowKey");
  toolboxWindow.addData(new MyData());
  createToolboxUI();
  
  background(0);
  size(800,650);
  
}

void draw() {
  if(loaded) {
    m.read();
    //Effect(0,m);
    image(m,0,0,800,650);
    bd.computeBlobs(m.pixels);
    drawBlobsAndEdges(true,true,#F23134);
    
    if(render) {
      if(m.width > 0 && m.height > 0)
        videoExport.saveFrame();
    }
    
    
  }
}

// ==================================================
// drawBlobsAndEdges()
// ==================================================
void drawBlobsAndEdgesOriginal(boolean drawBlobs, boolean drawEdges)
{
  noFill();
  Blob b;
  EdgeVertex eA, eB;
  for (int n=0 ; n<bd.getBlobNb() ; n++)
  {
    b=bd.getBlob(n);
    if (b!=null)
    {
      // Edges
      if (drawEdges)
      {
        strokeWeight(2);
        stroke(0, 255, 0);
        for (int m=0;m<b.getEdgeNb();m++)
        {
          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);
          if (eA !=null && eB !=null)
            line(
            eA.x*width, eA.y*height, 
            eB.x*width, eB.y*height
              );
        }
      }

      // Blobs
      if (drawBlobs)
      {
        strokeWeight(1);
        stroke(255, 0, 0);
        rect(
        b.xMin*width, b.yMin*height, 
        b.w*width, b.h*height
          );
      }
    }
  }
}

// ==================================================
// drawBlobsAndEdges()
// ==================================================
void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges, int rgb)
{
  fill(rgb);
  Blob b;
  EdgeVertex eA, eB;
  for (int n=0 ; n<bd.getBlobNb() ; n++)
  {
    b=bd.getBlob(n);
    if (b!=null)
    {
      // Edges
      if (drawEdges)
      {
        strokeWeight(2);
        stroke(0, 255, 0);
        for (int m=0;m<b.getEdgeNb();m++)
        {
          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);
          if (eA !=null && eB !=null)
            line(
            eA.x*width, eA.y*height, 
            eB.x*width, eB.y*height
              );
        }
      }

      // Blobs
      if (drawBlobs)
      {
        strokeWeight(1);
        stroke(255, 0, 0);
        rect(
        b.xMin*width, b.yMin*height, 
        b.w*width, b.h*height
          );
      }
    }
  }
}