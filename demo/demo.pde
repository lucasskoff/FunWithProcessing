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
  
  textX = 150;
  textY = 100;
  
  PFont font;
  font = createFont("HACKED.ttf", 100);
  textAlign(CENTER);
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
  
  makeText(textX, textY);
  makeCloud(baseX, baseY, rmsScaled);  
  makeCloud(baseX + 50, baseY - 100, rmsScaled);
  
  baseX = baseX - 1;
  textY = textY + 1;
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
