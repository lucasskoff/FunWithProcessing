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

float currentX;
float currentY;

void setup() {
  size(640, 360);

  //Load and play a soundfile and loop it
  sample = new SoundFile(this, "intro.mp3");
  sample.loop();

  // Create and patch the rms tracker
  rms = new Amplitude(this);
  rms.input(sample);
  
  currentX = width;
  currentY = height / 2;
}      

void draw() {
  // Set background color, noStroke and fill color
  background(0, 140, 167);
  noStroke();
  fill(255, 255, 255);

  // Smooth the rms data by smoothing factor
  sum += (rms.analyze() - sum) * smoothFactor;  

  // rms.analyze() return a value between 0 and 1. It's
  // scaled to height/2 and then multiplied by a scale factor
  float rmsScaled = (sum * (height/2) * scale) / 12;

  // Draw an ellipse at a size based on the audio analysis
  ellipse(currentX, currentY, rmsScaled, rmsScaled);
  
  currentX = currentX - 1;
}
