/**
 * Processing Sound Library, Example 6
 * 
 * This sketch shows how to use the Amplitude class to analyze a
 * stream of sound. In this case a sample is analyzed. The smoothFactor
 * variable determines how much the signal will be smoothed on a scale
 * from 0 - 1.
 */

import processing.sound.*;

// Declare the processing sound variables 
SoundFile sample;
Amplitude rms;

// Declare a scaling factor
float scale = 5.0;

// Declare a smooth factor
float smoothFactor = 0.25;

// Used for smoothing
float sum;

float baseX;
float baseY;

float textX;
float textY;

float[] xArray = {-15, 185, 385, 585, 785, 985, 1185};

int frame = 0;

int increment = 0;

int skyFrame = 0;
 
void setup() {
  size(1000, 500);

  //Load and play a soundfile and loop it
  sample = new SoundFile(this, "intro.mp3");
  sample.loop();

  // Create and patch the rms tracker
  rms = new Amplitude(this);
  rms.input(sample);
  
  baseX = width;
  baseY = height / 2;
  
  textX = 200;
  textY = 100;
  
  PFont font;
  font = createFont("HACKED.ttf", 100);
  textFont(font);
}      

void draw() {
  // Set background color, noStroke and fill color
  background(0, 140, 167);
  noStroke();
  

  // Smooth the rms data by smoothing factor
  sum += (rms.analyze() - sum) * smoothFactor;  

  // rms.analyze() return a value between 0 and 1. It's
  // scaled to height/2 and then multiplied by a scale factor
  float rmsScaled = (sum * (height/2) * scale) / 12;
  
  for(int i = 0; i < 10; i++) {
    makeSky(i * 50, i * 25, skyFrame * 10);
  }
  
  
  makeCloudLine(xArray, baseY, rmsScaled, 100);
  makeText(textX, textY);
  makeCloudLine(xArray, baseY-200, rmsScaled, 0);
  
  for(int i = 1000; i > 0; i -= 15) {
    makeGrass(i, 0, frame);
  }
  
  for(int i = 0; i < xArray.length; i++) {
    xArray[i] = xArray[i] - 1;
    if(xArray[i] < -215) {
       xArray[i] = 1200;
    }
  }
  
  if(textY < height - 7) {
    textY = textY + 1;
  }
  
  increment++;
  if(increment > 60) {
    skyFrame++;
    frame = (frame + 1) % 4;
    increment = 0;
  }
}

void makeCloudLine(float[] x, float y, float rmsScaled, float x_modifier) {
  for(int i = 0; i < x.length; i++) {
    makeCloud(x[i] + x_modifier, y, rmsScaled);
  }
}
  

void makeCloud(float x, float y, float rmsScaled) {
  fill(255, 255, 255);
  ellipse(x, y, rmsScaled, rmsScaled);
  ellipse(x + 30, y, rmsScaled, rmsScaled);
  ellipse(x + 60, y, rmsScaled, rmsScaled);
  ellipse(x + 15, y - 15, rmsScaled, rmsScaled);
  ellipse(x + 45, y - 15, rmsScaled, rmsScaled);
}

void makeText(float x, float y) {
  fill(0, 0, 0);
  text("Tolusteve Def", x, y);
}

void makeGrass(float x, float y, int frame) {
  fill(10, 255, 10);
  switch(frame) {
    case 0:
    triangle(x - 15, 470, x - 15, 500, x, 500);
    break;
    case 2:
    triangle(x, 470, x - 15, 500, x, 500);
    break;
    default:
    triangle(x - 7, 470, x - 15, 500, x, 500);
    break;
  }
}

void makeSky(float y, int red, int modifier) {
  int currRed = red + modifier;
  int currBlue = 167 + modifier;
  int currGreen = 140 + modifier;
  if(currRed > 255) {
    currRed = 255;
  }
  if(currBlue > 255) {
    currBlue = 255;
  }
  if(currGreen > 255) {
    currGreen = 255;
  }
  fill(currRed, 140, 167);
  rect(0, y, 1000, y + 50);
}
