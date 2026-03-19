/**
 * US Flight Map
 * Loads a US map and plots airport locations on top
 */

PImage usMap;

void setup() {
  size(1100, 750);
  usMap = loadImage("map5.jpg");  // load the map image
   color(255,0,0);
}

void draw() {
  background(255);
  // stretch the map to fill the whole window
  image(usMap, 0, 0, width, height);
  fill(255,0,0);
  text("Most Popular Destinations This Week", 320, 50);
  textSize(30);
  ellipse(320,620,20,20); //honolulu
  ellipse(200,440,20,20);  // LA
  ellipse(190,90,20,20);  //seattle
  ellipse(995,210,20,20);  // nyc
  ellipse(550,500,20,20);  //dallas
  ellipse(300,450,20,20);  //las vegas
  text("Las Vegas",260,480);  
  ellipse(905,650,20,20);   //FL
  ellipse(880,600,20,20);  // orlando
  ellipse(720,280,20,20);
  text("10",720,280);

}
