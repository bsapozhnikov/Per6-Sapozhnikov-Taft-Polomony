import java.io.*;
import java.util.*;

class Square {

  private String name;
  private int cost;
  private int x, y, w, h;
  private color c;
  private int numHouses;
  private boolean hasHotel;
  private Person owner;
  private PImage img;

  Square() {
  }

  Square(int x, int y, int w, int h, color c, String name, int cost) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.c=c;
    this.name=name;
    this.cost=cost;
    numHouses=0;
    hasHotel=false;
    owner=null;
    img=null;
  }

  Square(int x, int y, int w, int h, PImage img, String name, int cost) {
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.c=color(#ffffff);
    this.name=name;
    this.cost=cost;
    numHouses=0;
    hasHotel=false;
    owner=null;
    this.img = img;
  }

  boolean isRR() {
    return name.contains("Railroad");
  }
  boolean isUtil() {
    return name.equals("Electric Company") || name.equals("Water Works");
  }

  //not finished
  int rent() {
    if (hasHotel) {
      return rent(5);
    }
    else{
      return rent(numHouses);
    }
  }
  int rent(int n){
    int ans=0;
    if(isRR()){
      ans = 25*(int)Math.pow(2,owner.getNumRR()-1);
    } else if(isUtil()){
      //rent is 6 times a random dice roll
      ans = (int)(Math.random()*60)+12;
    } else{
      switch(n){
        case 0:
          ans = (cost-60)/10+2;
        case 1:
          ans = (cost-60)*5+10;
        case 2:
          ans = (cost-10)*3+30;
        case 3:
          ans = (cost-30)*3+90;
        default:
          ans = cost+rent(1)+rent(n-1);
      }
    }
    println("The rent is "+ans);
    return ans;
  }

  void build(){
    if(hasHotel)
      println("you already have a hotel here");
    numHouses++;
    if(numHouses==5){
      hasHotel=true;
      
    }
  }

  void setOwner(Person p) {
    owner=p;
  }

  void draw() {
    if (img==null) {
      fill(c);
      rect(x, y, w, h);
    } else {
      image(img, x, y);
    }
    if(hasHotel){
      fill(#cc0033);
      rect(x+w/4,y,w/2,h/4);
    } else{
      for(int i=0; i<numHouses; i++){
        fill(#006633);
        rect(x+w*i/4,y,w/4,h/4);
      }
    }
    
  }

  color getColor() {
    return c;
  }
  int getCost() {
    return cost;
  }
  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
  int getNumHouses() {
    return numHouses;
  }
  boolean hasHotel() {
    return hasHotel;
  }
  String getName() {
    return name;
  }
  Person getOwner() {
    return owner;
  }
  boolean hasOwner() {
    return owner!=null;
  }
  boolean onSquare(int a, int b){
    return a>=x&&a<=x+w&&b>=y&&b<=y+h;
  }

  void mouseClicked(){
    println(name+" is owned by "+owner+" and has "+numHouses+" houses");
    if(canRoll){
      if(players.getCurrent()==owner && c!=#000000 & c!=#FFFFFF && players.getCurrent().hasAll(this)){
        cp5.addBang("build")
        .setPosition(350, 400) //lazy way to handle the button covering Squares
          .setSize(80, 40)
              .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
                ;
      }
    }
  }

  String toString() {
    return getName();
  }
}

