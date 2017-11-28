void rollBall(){  
  int idx=-1;
  float D=0;
  for(int i=0; i<outEdgeList.size(); i++){
    pt p=outEdgeList.get(i)[0];
    pt q=outEdgeList.get(i)[1];
    if(d(p,q)>D){
      D=d(p,q);
      idx=i;
    }
  }
  
  pt A=outEdgeList.get(idx)[0];
  pt B=outEdgeList.get(idx)[1];
  travEdge.clear();
  show(A,B,0);  
}

void show(pt A, pt B, int counter){
  counter++;
  int idx=-1;
  pt P=A;
  pt Q=B;
  for(int i=0; i<outEdgeList.size(); i++){
    pt p=outEdgeList.get(i)[0];
    pt q=outEdgeList.get(i)[1];
    if(d(A,p)<0.1 && d(B,q)>0.1){
      idx=i;
      P=q;
      Q=p;
      break;
    }else if(d(A,q)<0.1 && d(B,p)>0.1){
      idx=i;
      P=p;
      Q=q;
      break;
    }
  }
  float ang=angle(V(A,P));
  stroke(255,0,0);
  strokeWeight(10);
  line(A.x,A.y,P.x,P.y);
  strokeWeight(1);
  noFill();
  stroke(0,255,0);
  strokeWeight(10);
  line(A.x,A.y,B.x,B.y);
  strokeWeight(1);
  noFill();
  drawAnimation(A,B,P,Q);
  if(counter<outEdgeList.size()-1){
    show(P,Q, counter);
  }
}

void drawAnimation(pt A, pt B, pt P, pt Q){
  fill(0);
  text("A",A.x+30,A.y+20);
  text("B",B.x-30,B.y+20);
  noFill();
  pt p=P((A.x+B.x)/2,(A.y+B.y)/2);
  stroke(0);
  noFill();
  strokeWeight(1);
  ellipse(p.x,p.y,d(A,B), d(A,B));
  float a=angle(V(A,B));
  float b=angle(V(P,Q));
  float c=angle(V(A,P));
  float an=angle(V(A,B),V(A,p));
  float r=d(A,B)/2;
  
  float t0=((5)*PI/180);
  float t1=-((5)*PI/180);
  vec u=V(A,p);  
  pt c0=new pt(A.x,A.y).add(R(S(r,U(V(A,p))),t0));
  pt c1=new pt(A.x,A.y).add(R(S(r,U(V(A,p))),t1));
  ellipse(c0.x,c0.y,5,5);
  ellipse(c1.x,c1.y,5,5);
  line(A.x,A.y,c0.x,c0.y);    
  line(A.x,A.y,c1.x,c1.y);
      
  boolean ch0=checkPtinTriList(c0);
  boolean ch1=checkPtinTriList(c1);
  
  if(ch1==true){
    //pivotC(A,B,a*180/PI,an*180/PI);
    fill(0);
    //text("clockwise ",A.x,A.y);
    noFill();
  }else{
    //pivotAC(A,B,b*180/PI,a*180/PI);
    fill(0);
    //text("anti clockwise ",A.x,A.y);
    noFill();    
  } 
}

void pivotC(pt A, pt B, float a, float b){
 
}
void pivotAC(pt A, pt B, float a, float b){
  
}

boolean checkPtinTriList(pt c){
  boolean ch1=false;
  for(int i=0; i<triList.size(); i++){
    pt p0=triList.get(i)[0];
    pt q0=triList.get(i)[1];
    pt r0=triList.get(i)[2];
    boolean t9=ptInPoly(p0,q0,r0,c);
    if(t9==true){
      ch1=true;
    }
  }
  return ch1;
}