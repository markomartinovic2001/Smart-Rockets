//kreiramo klasu populacija koja sadrzi ukupan broj jedinki, njihovu evaluaciju, ukrstanje

class Populacija {
  Raketa[] Rakete;
  int velicinaPopulacije;
  List<Raketa> umnozavanje;

//metoda populacija sadrzi velicinu populacije koji je ustvari dinamicki niz
  Populacija() {
    velicinaPopulacije = 50;
    Rakete = new Raketa[velicinaPopulacije];
    umnozavanje = new ArrayList<Raketa>();

    for (int i = 0; i < velicinaPopulacije; i++) {
      Rakete[i]  = new Raketa();//dodavanje novih raketa u niz
    }
  }

//ova funkcija za evaluaciju koristi fitnes da bi se utvrdilo koliko su dobre jedinke
  float evaluacija() {
    float avgfit = 0;//postavljanje prosecnog fitnesa na 0
    float maxfit = 0;//postavljanje maksimalnog fitnesa na 0
    for (Raketa Raketa : Rakete) {
      Raketa.racunajFitness();
      if (Raketa.fitness > maxfit) {
        maxfit = Raketa.fitness;
      }
      avgfit += Raketa.fitness;
    }
    avgfit /= Rakete.length;

    for (Raketa Raketa : Rakete) {
      Raketa.fitness /= maxfit;
    }

    umnozavanje = new ArrayList<Raketa>();

    for (Raketa Raketa : Rakete) {
      float n = Raketa.fitness * 100;
      for (int j = 0; j < n; j++) {
        umnozavanje.add(Raketa);
      }
    }

    return avgfit;
  }

  Raketa random(List<Raketa> list) {
    int r = (int)(Math.random() * (list.size()));
    return list.get(r);
  }

//ovom funkcijom vrsi se selekcija "roditelja", biraju se dva roditelja i od njih nastaje potomak
  void selekcija() {
    Raketa[] newRakete = new Raketa[velicinaPopulacije];
    for (int i = 0; i < Rakete.length; i++) {
      DNA parentA = random(umnozavanje).dna;
      DNA parentB = random(umnozavanje).dna;
      DNA child = parentA.crossover(parentB);
      child.mutacija();
      newRakete[i] = new Raketa(child);
    }

    Rakete = newRakete;
  }

  void pokreni() {
    for (Raketa Raketa : Rakete) {
      Raketa.update();
      Raketa.show();
    }
  }
}
