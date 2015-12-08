//Create an arrayLisst for the class Dog
ArrayList<Dog> d = new ArrayList<Dog>();
// Initialisation of a string array and a float array as well as a boolean and float vaiable
float border;
String[] lines;
float[] angles;
boolean menu = true;
PImage bg;


void setup()
{
  size(700,700);
  //calling the function loadDog
  loadDog();
  //loads the background image into the variable 
  bg = loadImage("background.jpg");
  //initialises the float array do be as long as the lines
  angles = new float[lines.length];
  //calls the function to set the angles
  setAngles();  
  border = width/10;
  
}

void loadDog()

{
  //loads the data from the .csv file
  lines = loadStrings("Dogs1.csv");
    
  for (int i = 0 ; i < lines.length-1 ; i++)
  {
    //creates the memory for a new Dog object
    Dog dog = new Dog();
    d.add(dog);
    
    
    String[] buffer = split(lines[i],',');
    
    //getting the data fromcsv and putting it into the string array buffer
    dog.ID = parseInt(buffer[0]);
    dog.name = buffer[1];
    dog.age = parseInt(buffer[2]);
    dog.gender = buffer[3];
    dog.motherID = parseInt(buffer[4]);
    dog.fatherID = parseInt(buffer[5]);
    dog.breed = buffer[6];
    dog.weight = parseInt(buffer[7]);
    dog.d_height = parseInt(buffer[8]);
    
    
  }
}
void draw()
{
 
  //menu shows if boolean is true
  if(menu == true)
  {
    bg.resize(width,height);
    background(bg);
    String s = "Welcome to my OOP Project";
    String b = "Press b for the Bar Chart";
    String p = "Press p for the Pie Chart"; 
    textSize(32);
    fill((255));
    text(s, 20, 30);
    text(b, 40, 60);
    text(p, 60, 90);
    
  }
  
}

void barChart()
{
    bg.resize(width,height);
    //resets the background so the menu isn't displayed with th graph
    background(bg);
    fill(random(100, 255), 255, random(100, 255));
    //this creates the x and y axis
    line(border,height-border,width/2-border,height-border);
    line(border,height-border,border,border);
    
    
    float gap = (width-border*2)/lines.length;
    //sets the size of the barchart 
    float scale = 35;
    float offset=0;
    
     
    for(Dog dg: d)
    {
       // x starting position, y starting position, width of each bar, height of each bar
       rect(offset+border,height-(border+dg.age*scale),gap,dg.age*scale);
       //makes the x starting point move to the next point
       offset+=gap;
    }
    
    textSize(26);
    fill(0, 255, 255, 204);
    text("x-axis is the breed", 12, height-border/1.5);
    text("y-axis is the age", 12,height-border/4);
    
  fill(255);
  String r = "Press r to return to the menu";
  text(r, 25,25);
}
  
void pieChart(float rad)
{
  bg.resize(width,height);
  background(bg);
  float lastAngle = 0;
  for (int i = 0; i < lines.length; i++) 
  {
    fill(i%255,(543*i)%255,(64*i)%255);
    //creates the pie chart, 1,2 put in center, 3,4 are the radius, and the last two make the angles of each weight
    arc(width/2, height/2, rad, rad, lastAngle, lastAngle+angles[i]);
    //this makes the last angle equal the first angle
    lastAngle += angles[i];
  }
  
  fill(148, 202, 0);
  textSize(28);
  String p = "This pie chart shows the weight for all the dogs";
  text(p, 40, 550);
  
  fill(255);
  String r = "Press r to return to the menu";
  text(r, 25,25);
  
}

void keyPressed()
{ 
  
  if (keyPressed) 
      { 
        //if one visualisation is pressed then the other can't be
        if(menu == true)
        {
          
          if (key == 'b') 
          { 
            //sets menu to false when not needed
            menu = false;
            //calls the bar chart
            barChart(); 
            
          } 
          if (key == 'p') 
          { 
            //sets menu to false when not needed
            menu = false;
            pieChart(300);
             
          }
        }
        if (key == 'r')
        {
          //returns to menu
          menu = true;
        } 
      }
}

void setAngles()
{
  float total = 0;
  int i=0;
  
  //calculating the total weight of the dogs
  for(Dog dg: d)
  {
    total+=dg.weight;
  }
  
  //uses the total to determine how many angles are needed and what they are
  for(Dog dg: d)
  {
    angles[i] = (TWO_PI/total)*dg.weight;
    println((TWO_PI/total)*dg.weight);
    i++;
  }
  
}
