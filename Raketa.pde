
//fajl u kome struktuiramo raketu

final float maxBrzina = 4;

//pravimo klasu Raketa koja sadrzi svoju poziciju(koja je odredjena u koordinatnom prostoru), brzinu, ubrzanje, sadrzi klasu DNA jer se u njoj nalaze geni rakete, imamo fitnes funkciju odnosno funkciju dobrote koja na osnovu ulaza(jedinke) govori koliko je evaluirala.
class Raketa {
  PVector poz;
  PVector brz;
  PVector ubrz;
  DNA dna;
  float fitness = 0;
  
//boolean vrednosti koje nam sluze u slucaju da se rakete sudare sa zamisljenim zidom ili u slucaju ako dospeju do krajnjeg cilja.
  boolean hitTarget = false;
  boolean crashed = false;

//metoda Raketa koja ce sadrzati pokazivac na niz na metodu DNA koja sadrzi sve najbitnije informacije o kretanju rakete
  Raketa() {
    this(new DNA());
  }

//postavljamo pocetnu poziciju vektora po x i y osi, brzinu i ubrzanje, u slucaju udara u "zamisljeni zid" ili "sletanje" na mesec, rakete se zaustavljaju
  Raketa(DNA dna_) {
    poz = new PVector(width / 2, height - 20);
    brz = new PVector();
    ubrz = new PVector(0, -0.01);
    dna = dna_;
    fitness = 0;
    hitTarget = false;
    crashed = false;
  }

//funkcija koja prihvata silu, tacnije funkcija koja definise koliko brzo ce se kretati rakete
  void prihvatiSilu(PVector sila) {
    ubrz.add(sila);
  }

//funkcija koja racuna fitness(uspesnost raketa)
  void racunajFitness() {
    float d = distanceToTarget();
    fitness = map(d, 0, width, width, 0);
    if (hitTarget) {
      fitness *= 10;
    } else if (crashed) {
      fitness /= 10;
    }
  }

//udaljenost od cilja
  float distanceToTarget() {
    return dist(poz.x, poz.y, target.x, target.y);
  }

//ovde upotrebljavamo funkciju udaljenosti od cilja i proveravamo da li je raketa udarila u zid ili u metu(mesec)
  void update() {
    float d = distanceToTarget();
    if (d < 100) {
      hitTarget = true;
      
    }

    if (poz.x > barrierx && poz.x < (barrierx + barrierw) && poz.y > barriery && poz.y < (barriery + barrierh)) {
      crashed = true;
    }
    if (poz.x > width || poz.x < 0 || poz.y > height || poz.y < 0) {
      crashed = true;
    }

    prihvatiSilu(dna.genes[age]);

    if (!hitTarget && !crashed) {
      brz.add(ubrz);
      poz.add(brz);
      ubrz.mult(0);
      brz.limit(maxBrzina);
    }
  }
  
//prikazivanje raketa, u slucaju da pogode metu(mesec) rakete ce pozeleneti, u slucaju sudara u "zamisljeni zid" raketa ce pocrveneti
  void show() {
    pushMatrix();
    noStroke();
    if (hitTarget) {
      fill(50, 205, 50);
    } else if (this.crashed) {
      fill(250, 0, 0);
    } else {
      fill(255, 150);
    }
    
//translacija i rotacija raketa u prostoru
    translate(poz.x, poz.y);
    rotate(brz.heading());

//pravljenje "tela" rakete
    rectMode(CENTER);
    rect(0, 0, 25, 5);

//crtanje "nosa" rakete
    fill(165, 42, 42);
    ellipse(12, 0, 50, 5);

    if (!hitTarget && !crashed) {
//crtanje plamena koji izlazi iz rakete
      fill(255, 140 + random(0, 115), random(0, 128));
      beginShape();
      vertex(-14, -3);
      vertex(-55, 0);
      vertex(-14, 3);
      endShape();
    }

    popMatrix();
  }
}
