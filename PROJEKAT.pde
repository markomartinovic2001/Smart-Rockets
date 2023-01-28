//Marko Martinovic RT-72/20

Raketa Raketa;
Populacija Populacija;
PVector target;
float maxsila = 0.2;

int age;//vreme trajanja raketa
float stat;//neka statistika uspesnosti

int generation = 0;//pocetna generacija je 0

//pozicije prepreke po x i y osi, njena duzina i sirina
float barrierx;
float barriery;
float barrierw;
float barrierh;

void setup() {
  size(1024, 768);//"rezolucija prozora"
  Populacija = new Populacija();
  Raketa = new Raketa();
  target = new PVector(width / 2, 120);//pozicija meseca
  age = 0;

  stat = 0;

//pravljenje prepreke(sirina, duzina,pozicija po x i y osi)
  barrierw = width / 8;
  barrierh = 10;
  barrierx = (width - barrierw) / 2;
  barriery = (height - barrierh) / 2;
}

//funkcija za pozadinu(svemir) 
void draw() {
  background(0);

//crtanje mete(meseca)
  stroke(255);
  fill(128);
  ellipse(target.x, target.y, 200, 200);
  fill(100);
  noStroke();
  strokeWeight(2);
  ellipse(target.x+2, target.y-2, 10, 10);

  //crtanje prepreke
  fill(0, 255, 0);
  stroke(128);
  rectMode(CORNER);
  rect(barrierx, barriery, barrierw, barrierh);
  strokeWeight(1);
  stroke(55, 0, 0);
  fill(255);

//crtanje ostalih svemirskih tela(simuliranje zvezdi)
ellipse(random(1400),random(1400),random(10),random(10));
ellipse(random(1400),random(1400),random(10),random(10));
ellipse(random(1400),random(1400),random(10),random(10));
ellipse(random(1400),random(1400),random(10),random(10));
ellipse(random(1400),random(1400),random(10),random(10));
ellipse(random(1400),random(1400),random(10),random(10));
ellipse(random(1400),random(1400),random(10),random(10));
ellipse(random(1400),random(1400),random(10),random(10));
ellipse(random(1400),random(1400),random(10),random(10));
ellipse(random(1400),random(1400),random(10),random(10));
ellipse(random(1400),random(1400),random(10),random(10));
  
  Populacija.pokreni();

  age++;
  if (age >= zivotniVek) {
    stat = Populacija.evaluacija();
    Populacija.selekcija();
    age = 0;
    generation++;
  }

  textSize(18);
  noStroke();
  fill(0, 250, 250);
  text("Generacija: " + generation, 20, 20);
  text("Zivotni vek: " + age, 20, 40);
  if (stat != 0) {
    text("Statistika uspesnosti: " + stat, 20, 60);
  }
}
