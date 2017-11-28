
boolean disInfo=false;
int disCounter=0;


ArrayList<pt>ptList;
ArrayList<pt[]>edgeList;
ArrayList<pt[]>triList;
ArrayList<pt[]>outEdgeList;
ArrayList<pt[]> travEdge;
boolean lock=false;
int locked_index;
pt locked_pt;

void setup(){
  size(1200,900);
  background(255);
  ptList=new ArrayList<pt>();
  edgeList=new ArrayList<pt[]>();
  outEdgeList=new ArrayList<pt[]>();  
  triList=new ArrayList<pt[]>();
  travEdge=new ArrayList<pt[]>();
  for(int i=0; i<10; i++){
    float x=random(300)+100;
    float y=random(300)+100;
    pt p=new pt(x,y);
    ptList.add(p);    
  }
  
  
  init();
}

void init(){
    genPts();
    displayPts();
    runCode(); 
    if(outEdgeList.size()>0){
      rollBall();
    }
}


void draw(){
// GOING THROUGH KEYPRESSED AND MOUSEPRESSED
}

void keyPressed(){
  if(key=='g'){    
    genPts();
    displayPts();
    runCode();    
  }  
  if(key=='b'){    
    if(outEdgeList.size()>0){
      rollBall();
    }
  }  
  if(key=='i'){    
    disCounter++;
    if(disCounter%2==0 && disCounter>0){
      disInfo=true;
    }
  }
}
void displayPts(){
  stroke(0);
  for(int i=0;i<ptList.size(); i++){
    pt P=ptList.get(i);
    //text(""+P.x+","+P.y,P.x,P.y);
    noFill();
    stroke(100,100,100);
    ellipse(P.x,P.y,15,15);
    stroke(0,0,0);
    fill(0);
    ellipse(P.x,P.y,5,5);
  }  
  if(disInfo==true){
        if(edgeList.size()>0){
          stroke(0);
          fill(0);
          text("edgeList = "+edgeList.size(),10,10);    
          for(int i=0; i<edgeList.size(); i++){
            pt p=edgeList.get(i)[0];
            pt q=edgeList.get(i)[1];
            pt r=new pt((p.x+q.x)/2, (p.y+q.y)/2);
            noStroke();
            fill(255);
            ellipse(r.x,r.y,25,25);
            stroke(0);
            fill(0);
            text(""+i,r.x-5,r.y+5);
          }
        }
        if(triList.size()>0){
          for(int i=0; i<triList.size(); i++){
            pt p=triList.get(i)[0];
            pt q=triList.get(i)[1];
            pt r=triList.get(i)[2];
            pt o=Centroid(p,q,r);
            noStroke();
            fill(255);
            ellipse(o.x,o.y,25,25);
            stroke(0);
            fill(0);
            text(""+i,o.x-5,o.y+5);
          }
        }
        if(outEdgeList.size()>0){
          text("outer Edge List = "+outEdgeList.size(),10,30);
          for(int i=0; i<outEdgeList.size(); i++){
              stroke(0);
              fill(0);        
              pt p=outEdgeList.get(i)[0];
              pt q=outEdgeList.get(i)[1];
              strokeWeight(15);
              stroke(255,0,0,150);
              line(p.x,p.y,q.x,q.y);
              strokeWeight(1);     
          }
        }    
  }
  noFill();
}


void mousePressed(){
  float x=mouseX;
  float y=mouseY;
  float r=50;
  for(int i=0; i<ptList.size(); i++){
    pt p0=ptList.get(i);
    if(dis(x,y,p0.x,p0.y)<25){
      lock=true;
      locked_pt=p0;
      locked_index=i;  
      stroke(255,255,255);
      fill(255,0,0,50);
      ellipse(p0.x,p0.y,20,20); 
    }
  }
}

public void mouseDragged(){
  if(lock==true){
    pt P=ptList.get(locked_index);
    P.x=(mouseX);
    P.y=(mouseY);  
    stroke(255,255,255);
    fill(255,0,0,50);
    ellipse(P.x,P.y,20,20);   
  }
  runCode();
  displayPts();
}

public double dis(float x, float y, float a, float b){
  double d=sqrt(sq(x-a) + sq(y-b));
  return d;
}