
//DNA fajl omogucava raketama nacin kretanja.
//Svaka raketa u sebi sadrzi neprebrojivo mnogo "receptora" i svaki taj receptor sadrzi neprebrojivi niz vektora pomocu kojih se raketa krece u prostoru. 

//ukljucivanje biblioteke java.util koja sadrzi modele dogadjaja, objekte za datum i vreme, klase prikupljanja...
import java.util.*;

int zivotniVek = 500; //duzina trajanja samog zivotnog veka raketa


//pravljenje klase DNA koja sadrzi sve te "receptore" od nebrojano mnogo nizova vektora koji omogucavaju nasumicno kretanje raketa u prostoru.
class DNA {
  PVector[] genes;


//svaki "receptor" je ustvari neki gen koji sadrzi nebrojano mnogo vektora, svaki taj vektor je niz brojeva odnosno razlicitih putanja kojima ce se raketa kretati.
//u ovom delu koda svakom tom genu dodeljujemo novi niz vektora gde ce ti geni postojati sve dokle traje zivotni vek rakete.
  DNA() {
    genes = new PVector[zivotniVek];

    for (int i = 0; i < zivotniVek; i++) {
      PVector gene = PVector.random2D();
      gene.setMag(maxsila);        
      genes[i] = gene;
    }
  }

  DNA(PVector[] genes_) {
    genes = Arrays.copyOf(genes_, genes_.length);
  }

//ukrstanje dve jedinke i formiranje nove jedinke
//da bismo dobili novu jedinku moramo uzeti neke nasumicne gene iz prethodne generacije, u ovom slucaju duzina gena nam je ustvari neki vektor(koji je niz nasumicnih brojeva koji odredjuju kretanje rakete) i kroz petlju mi prolazimo kroz te duzine, uzimajuci nove vrednosti za forimiranje gena za novu jedinku.
  DNA crossover(DNA partner) {
    PVector[] newgenes = new PVector[genes.length];
    int mid = (int) random(genes.length);
    for (int i = 0; i < genes.length; i++) {
      if (i > mid) {
        newgenes[i] = genes[i];
      } else {
        newgenes[i] = partner.genes[i];
      }
    }
    return new DNA(newgenes);
  }
//ovde imamo funkciju mutacije koja radi tako sto se jedan postojeci get promeni u maloj meri.
//isto nam je potrebna petlja da bismo prosli kroz duzinu gena i na kraju nasumicnom genu dodeljujemo neku novu vrednost
  void mutacija() {
    for (int i = 0; i < genes.length; i++) {
      if (random(i) < 0.01) {
        PVector gene = PVector.random2D();
        gene.setMag(maxsila);        
        genes[i] = gene;
      }
    }
  }
}
