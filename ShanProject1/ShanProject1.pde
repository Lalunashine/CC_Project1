// The adjective I selected for this project is COLORFUL.

int num = 0;                          // for time counter
int whiteBg = 255;                    // for white background each loop
float theta1 = 0.0;                   // for rubik's cube

float r = 0.0;  float theta2 = 0.0;   // for lollipop
float g = 100;  float gChange = 0.5;
float b = 255;  float bChange = -1;

float y1 = 0;  float y2 = 0;          // for falling leaf
float redleaf = 0; 

float x = 550;  float y = 350;        // for flying balloon
color red = color(235,65,99);

int anglef = 0;  float green = 0;     // for flower making
 
int i = 0;  boolean mouse;            // for circle at bottom right
int j = 0;  float anglec = 0;
int[] diameter = {170, 140, 110, 80, 50, 20, 5}; 

void setup() {
  size(600, 600, P3D);      // set 3D mode for renderer
  background(255);
}

void draw() {
  secCount();               // print time elapsed
  flower();                 // draw a flower when mouse is pressed  
  balloon(red);             // draw a flying balloon
  fallingLeaf(70);          // draw a falling leaf at x = 70
  lollipop(130, 250, 150);  // draw 3 lollipos
  lollipop(300, 80, 200);
  lollipop(450, 200, 255);  

  rollover(mouseX, mouseY); // judge whether mouse is on the circle area
  circle();                 // draw a series of circles 
  whtBg();                  // draw a white backgound for the rubik's cube
  rotateCube();             // draw a roatating rubik's cube
}  

/************* function collection ****************/

// 1. time counter
void secCount() {
  if (frameCount % 60 == 0) {  // same frequency as a clock's second
    num++;
    println("Elapsed time: " + num + " sec");
  }
}  

// 2. create five different sizes of flowers
void flower() {
  noStroke();
  if (mousePressed == true) {  // draw only when mosue is pressed
    anglef += 5;
    float size = cos(radians(anglef)) * 12.0;    // change size of flower periodically
    float alpha = random(30,90);
    green = map(mouseY, 0, height, 100, 255); // change green value with mouse location
       
    for (int a = 0; a < 360; a += 72) {    // 5 petals
      float xoff = cos(radians(a)) * size; // x coordinate offset for petals 
      float yoff = sin(radians(a)) * size; // y coordiante offset for petals
      fill(255, green, 150, alpha);        // change color of petals with mouse location
      ellipse(mouseX + xoff, mouseY + yoff, size, size);  // draw petals around mouse 
    }
    fill(235, 82, 9, 80);  // orange
    ellipse(mouseX, mouseY, 3, 3);  // draw the flower heart
  } 
}  

// 3. draw a green leaf falling with color turning yellow
void fallingLeaf (float tx) { // custom leaf's x location
  noStroke();
  pushMatrix();
    translate(tx,200);       // translate the origin to (tx, 200);
    fill(whiteBg);           // draw a white rect background for leaf
    rectMode(CENTER);
    rect(tx-85, y1, 60, 60);
   
    fill(redleaf, 180, 0);   
    arc(0, y1, 60, 60,HALF_PI, PI + 0.5 * QUARTER_PI);  // draw one half of leaf
    rotateZ(PI);        // rotate Z axis with 180 degree                            
    translate(25,-19);  // adjust origin location
    arc(0, y2, 60, 60,HALF_PI, PI + 0.5 * QUARTER_PI);  // draw another half of leaf
    redleaf += 0.3;     // color gradually turing yellow
    
    y1 += 0.4;  // leaf slowly falling down
    y2 -= 0.4; 
    y1 = constrain(y1, 0, height/2+70);  // finally leaf stays at bottom 
    y2 = constrain(y2, -height/2-70, 0);
  popMatrix();
}  

// 4. draw a red balloon flying up to sky
void balloon(color c) { // custom balloon's color
  noStroke();
  fill(whiteBg);        // draw a white background for balloon
  rectMode(CENTER);
  rect(x, y, 45, 81);
  
  fill(c,90);  
  ellipse(x, y, 38, 50);                   // draw main ellipse of balloon  
  fill(150);
  triangle(x-5, y+25, x, y+30, x+5, y+25); // draw knotted base of balloon
  stroke(150);
  line(x, y+30, x, y+40);                  // draw rope for holding
  
  y -= 0.2;      // keeping flying up
  if (y < 25) {  // until to the edge of window
    y = 25;      // stay at the edge of window
  }  
  if (frameCount%10 == 0) { // adjust the frequency of flying up
    if (random(1) < 0.5) {  // balloon's x location is randomly changing to left/right 
      x -= 1.5;             // with equal possibility
    } else {
      x += 1.5;
    }
  }  
}

// 5. draw a spiral lollipop
void lollipop(float xpos, float ypos, int red) {  // custom location and red value
  float dx = r * cos(theta2); // difference of x direction changes periodically
  float dy = r * sin(theta2); // difference of y direction changes periodically
  noStroke();
  fill(red, g, b);
  
  if ((r > -1) && (r < 26)){  // draw the candy part with fixed size
    ellipse(xpos + dx , ypos + dy, 3, 3); 
    theta2 += 0.02;           // indicate spiral shape
    r += 0.02; 
  } else if (r > 26){         // draw the small "handle" part
    stroke(0);
    strokeWeight(2);
    line(xpos + dx , ypos + dy, xpos + dx + 10, ypos + dy + 15); 
  }

  g = g + gChange;            // green value and blue value of color
  b = b + bChange;            // uniformly changing
  if (g < 0 || g > 255){
    gChange *= -1;
  }  
  if (b < 0 || b > 255){
    bChange *= -1;
  } 
}  

// 6. judge whether mouse is on the circle area or not
void rollover(int mx, int my) { 
    if (mx > 410 && mx < width && my > 410 && my < height) { // mouse is on circle area
      mouse = true;
    } else {
      mouse = false;
    }
}

// 7. draw a series of circles
void circle() {
  strokeWeight(0.8);
  float bright = map(sin(anglec), -1, 1, 255, 100);     
  if (mouse) { // mouse on circles                                  
    if (frameCount%10 == 0){ // adjust frequency of value changing
       stroke(255);
       fill(200, 230, bright, 80); 
       ellipse(500, 500, diameter[i], diameter[i]); // draw circles like "target" 
       
       anglec += 0.2;  // indicate color of circle changing gradually
       i++;
       if (i == diameter.length) { // keep drawing circles for each loop of draw()
         i = 0;
       }
    }   
  } else { // mouse not on circles
    if(j < diameter.length) {  // only draw (diameter.length) circles
      noStroke();
      fill(diameter[j], 230, 180, 80);  // different color with little variations
      ellipse(500, 500, diameter[j], diameter[j]);
      j++;
    }  
  } 
} 

// 8. refresh background for rubik's cube
void whtBg() {    
  noStroke();
  fill(whiteBg);  
  beginShape(QUADS);     // draw a 3D background for cube
  vertex(0, 0, -45);     // t = -45, enough space for cube rotating
  vertex(150, 0, -45);  
  vertex(150, 150, -45);    
  vertex(0, 150, -45);  
  endShape(); 
}  

// 9. rotate a rubik's cube
void rotateCube() {
  theta1 += 0.01;  // keep rotating
  pushMatrix();
    translate(width/6, height/6);  // translate the origin to (width/6, height/6)
    rotateX(theta1);   // rotate along x axis
    rotateY(theta1);   // y axis
    //rotateZ(theta1); // z axis
    drawCube(30); 
  popMatrix();
}  

// 10. draw a rubik's cube
void drawCube(int t) {
  beginShape(QUADS);
  fill(255, 138, 0);   // orange back
  vertex(-t, -t, -t);  // top left
  vertex(t, -t, -t);   // top right
  vertex(t, t, -t);    // bottom right
  vertex(-t, t, -t);   // bottom left
  
  fill(255, 0, 0);     // red front: back(z=-t -> z=t)
  vertex(-t, -t, t);   // top left
  vertex(t, -t, t);    // top right
  vertex(t, t, t);     // bottom right
  vertex(-t, t, t);    // bottom left
  
  fill(252, 252, 100); // yellow left
  vertex(-t, -t, t);   // top left
  vertex(-t, -t, -t);  // top right
  vertex(-t, t, -t);   // bottom right
  vertex(-t, t, t);    // bottom left
  
  fill(200);           // grey right: left(x=-t -> x=t)
  vertex(t, -t, t);    // top left
  vertex(t, -t, -t);   // top right
  vertex(t, t, -t);    // bottom right
  vertex(t, t, t);     // bottom left
  
  fill(13, 132, 255);  // blue up
  vertex(-t, -t, -t);  // top left
  vertex(t, -t, -t);   // top right
  vertex(t, -t, t);    // bottom right
  vertex(-t, -t, t);   // bottom left

  fill(13, 255, 113);  // green down: up(y=-t -> y=t)
  vertex(-t, t, -t);   // top left
  vertex(t, t, -t);    // top right
  vertex(t, t, t);     // bottom right
  vertex(-t, t, t);    // bottom left  
  endShape();

  int a = t * 1/3; 
  stroke(0);
  strokeWeight(1);
  noFill();            
  beginShape();        // bound 1
  vertex(-t, -a, -t);
  vertex(t, -a, -t);
  vertex(t, -a, t);
  vertex(-t, -a, t);
  endShape(CLOSE);
  
  beginShape();        // bound 2 : bound 1(y=-a -> y=a)
  vertex(-t, a, -t);
  vertex(t, a, -t);
  vertex(t, a, t);
  vertex(-t, a, t);
  endShape(CLOSE);
  
  beginShape();        // bound 3 : bound 1(x,y -> y,x)
  vertex(-a, -t, -t);
  vertex(-a, t, -t);
  vertex(-a, t, t);
  vertex(-a, -t, t);
  endShape(CLOSE);
  
  beginShape();        // bound 4 : bound 3(x=-a -> x=a)
  vertex(a, -t, -t);
  vertex(a, t, -t);
  vertex(a, t, t);
  vertex(a, -t, t);
  endShape(CLOSE);
  
  beginShape();        // bound 5 : back(z=-t -> z=-a)
  vertex(-t, -t, -a);  
  vertex(t, -t, -a);   
  vertex(t, t, -a);    
  vertex(-t, t, -a);   
  endShape(CLOSE);
  
  beginShape();        // bound 6 : back(z=-a -> z=a)
  vertex(-t, -t, a);  
  vertex(t, -t, a);   
  vertex(t, t, a);    
  vertex(-t, t, a);   
  endShape(CLOSE);
}  