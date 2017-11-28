void runCode(){
  outEdgeList.clear();
  edgeList.clear();
  triList.clear();
  background(255); noFill();
  for(int i=0; i<ptList.size(); i++){
    pt p=ptList.get(i); 
    fill(255,0,0);
    ellipse(p.x,p.y,15,15);
    noFill();
  }
  ArrayList<pt[]>nPtList=new ArrayList<pt[]>();
  nPtList.clear();
  for(int i=0; i<ptList.size(); i++){
    pt p=ptList.get(i);
    for(int j=0; j<ptList.size(); j++){
      pt q=ptList.get(j);
      if(d(p,q)>0){
        for(int k=0; k<ptList.size(); k++){
          pt r=ptList.get(k); float d0=d(p,r); float d1=d(q,r);
          if(d0>0 && d1>0){
            pt[] ptArr=new pt[3]; ptArr[0]=p; ptArr[1]=q; ptArr[2]=r; nPtList.add(ptArr);
          }
        }
      }
    }
  }
  ArrayList<pt[]>fPtList=new ArrayList<pt[]>();
  fPtList.clear();
  for(int i=0; i<nPtList.size(); i++){
    pt p=nPtList.get(i)[0];pt q=nPtList.get(i)[1];pt r=nPtList.get(i)[2];
    pt o=CircumCenter(p,q,r); float di=d(o,p)*2;
    boolean g=false;int sum=0;
    for(int j=0; j<ptList.size(); j++){
      pt t=ptList.get(j);   
      float d0=d(p,t); float d1=d(q,t); float d2=d(r,t); float dr=d(o,t)*2;
      if(dr<di && d0>0.1 && d1>0.1 && d2>0.1){
        g=true; sum++;
      }
    }
    if(g==false && sum<1){
      pt[] tPtArr=new pt[3]; tPtArr[0]=p; tPtArr[1]=q; tPtArr[2]=r;      
      fPtList.add(tPtArr);
    }    
  }  
  for(int i=0; i<fPtList.size(); i++){
    pt p=fPtList.get(i)[0]; 
    pt q=fPtList.get(i)[1]; 
    pt r=fPtList.get(i)[2]; 
    pt o=CircumCenter(p,q,r);
    float di=d(p,o)*2;
    noFill();
    stroke(0);
    int re=int(random(255));
    int gr=int(random(255));
    int bl=int(random(255));
    fill(re,gr,bl,25);
    //ellipse(o.x,o.y,di,di);
    PShape s=createShape();
    s.beginShape();
    s.vertex(p.x,p.y);
    s.vertex(q.x,q.y);
    s.vertex(r.x,r.y);
    s.endShape();
    shape(s);
    conEdges(p,q,r);
    conTri(p,q,r);    
  }   
  plotOuterEdges();
}

void conTri(pt a, pt b, pt c){
  boolean t=false;
  if(triList.size()>0){
    for(int i=0; i<triList.size(); i++){
      pt p=triList.get(i)[0];
      pt q=triList.get(i)[1];
      pt r=triList.get(i)[2];      
      if( (d(a,p)<0.1) || (d(a,q)<0.1) || (d(a,r)<0.1) ){
        if( (d(b,p)<0.1) || (d(b,q)<0.1) || (d(b,r)<0.1) ){
          if( (d(c,p)<0.1) || (d(c,q)<0.1) || (d(c,r)<0.1) ){
            t=true; // already exists
          }
        }
      }
    }    
  }
  if(t==false){
    pt[] tri=new pt[3];
    tri[0]=a;
    tri[1]=b;
    tri[2]=c;
    triList.add(tri);
  }
}

void plotOuterEdges(){
  for (int i=0; i<edgeList.size(); i++){
    boolean t=false;
    int sum=0;
    pt a=edgeList.get(i)[0];
    pt b=edgeList.get(i)[1];
    for(int j=0 ; j<triList.size(); j++){
      pt p=triList.get(j)[0];
      pt q=triList.get(j)[1];
      pt r=triList.get(j)[2];
      if( (d(a,p)<0.1) || (d(a,q)<0.1) || (d(a,r)<0.1) ){
        if( (d(b,p)<0.1) || (d(b,q)<0.1) || (d(b,r)<0.1) ){          
            t=true; // already exists
            sum++;
        }
      }
    }
    if(sum<2){
      outEdgeList.add(edgeList.get(i));
    }
  }
}

boolean checkEdge(pt p, pt q, pt r, pt o){
  pt pq=new pt((p.x+q.x)/2, (p.y+q.y)/2);
  pt pr=new pt((p.x+r.x)/2, (p.y+r.y)/2);
  pt qr=new pt((q.x+r.x)/2, (q.y+r.y)/2);
  pt pqo=new pt(o.x,o.y).add(S(d(o,pq)*1.5,U(V(o,pq))));
  pt pro=new pt(o.x,o.y).add(S(d(o,pr)*1.5,U(V(o,pr))));
  pt qro=new pt(o.x,o.y).add(S(d(o,qr)*1.5,U(V(o,qr))));
  boolean t=true;
  int sum=0;
  if(triList.size()>0){
    for (int i=0; i<triList.size(); i++){
      pt a=triList.get(i)[0];
      pt b=triList.get(i)[1];
      pt c=triList.get(i)[2];
      boolean t0=ptInPoly(a,b,c,pqo);
      boolean t1=ptInPoly(a,b,c,pro);
      boolean t2=ptInPoly(a,b,c,qro);
      if( t0==true || t1==true || t2==true){
        sum++;
      }
    }
  }
  if(sum<3){
    return true;//outside
  }else{
    return false;//inside
  }
}

void conEdges(pt p, pt q, pt r){   
    boolean pq=true;
    boolean pr=true;
    boolean qr=true;    
    if(edgeList.size()>0){
      for (int i=0; i<edgeList.size(); i++){
        pt a=edgeList.get(i)[0];
        pt b=edgeList.get(i)[1];
        if(d(p,a)<0.1 || d(p,b)<0.1){
          if(d(q,a)<0.1 || d(q,b)<0.1){
            pq=false;
          }  
        }
        if(d(p,a)<0.1 || d(p,b)<0.1){
          if(d(r,a)<0.1 || d(r,b)<0.1){
            pr=false;
          }  
        }
        if(d(r,a)<0.1 || d(r,b)<0.1){
          if(d(r,a)<0.1 || d(r,b)<0.1){
            qr=false;
          }  
        }
      }
    }
    if(pq==true){
      pt[] epq=new pt[2];
      epq[0]=p;
      epq[1]=q;
      edgeList.add(epq);
    }
    if(pr==true){
      pt[] epr=new pt[2];
      epr[0]=p;
      epr[1]=r;
      edgeList.add(epr);
    }
    if(qr==true){
      pt[] eqr=new pt[2];
      eqr[0]=q;
      eqr[1]=r;
      edgeList.add(eqr);
    }
}

void genPts(){
  ptList.clear();
  for(int i=0; i<15; i++){
    float x=random(500)+300;
    float y=random(500)+300;
    pt p=new pt(x,y);
    ptList.add(p);
  }
}


pt CircumCenter(pt A, pt B, pt C){
  pt H=new pt((A.x+C.x)/2,(A.y+C.y)/2);
  pt M=new pt((A.x+B.x)/2,(A.y+B.y)/2);
  vec AH=V(A,H);
  vec AM=V(A,M);
  vec V=U(R(V(A,B)));
  float s=(dot(AH,AH)-dot(AM,AH))/(dot(V,AH));
  pt P=new pt(M.x,M.y).add(S(s,V));
  return P;
}



pt Centroid(pt A, pt B, pt C){
  pt H=new pt((A.x+B.x+C.x)/3,(A.y+B.y+C.y)/3);
  return H;
}


boolean ptInPoly(pt p ,pt q, pt r, pt o){
  float AR=heron(p,q,r);  
  float sum=0;
  sum+=heron(o,p,q);
  sum+=heron(o,p,r);
  sum+=heron(o,r,q);
  //sum=AR;
  boolean t=false;
  if(abs(sum-AR)<0.1){
    t=true; //in poly
  }else{
    t=false; //not in poly
  }
  fill(0);
  noFill();
  return t;
}

float heron(pt a, pt b, pt c){
  float l=d(a,b);
  float m=d(a,c);
  float n=d(c,b);
  float s=(l+m+n)/2;
  float ar=sqrt(s*(s-l)*(s-m)*(s-n));
  //println(l+","+m+","+n+","+s+","+ar);
  return ar;
}