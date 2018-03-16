/*
 * Macro służące do sporządzania wykresów na podstawie pliku wsadowego
 * zawierającego dane z oscyloskopu programu Multisim
 * Autor: Mateusz Wasiluk
 * Edit: Bartłomiej Kliś
 */
#include <TGraphErrors.h>
#include <TCanvas.h>
#include <TGraph.h>
#include <TAxis.h>

int GrafOsc(char* filename){
	char nazwa[30], tytul[150],osX[20],osY[20],tmp[3];
	
	auto c = new TCanvas();
	c->Divide(1,2);
	c->GetPad(1)->SetGrid();
	c->GetPad(2)->SetGrid();
	
	/*
	 * Drugi argument poniższego konstruktora reguluje wczytywanie poszczególnych kolumn.
	 * Gwiazdki po znaku % oznaczają ignorowanie
	 */
	TGraphErrors *g1 = new TGraphErrors(filename,"%lg %lg %*lg %*lg");
	TGraphErrors *g2 = new TGraphErrors(filename,"%lg %*lg %lg %*lg");
	
	
	c->cd(1);
	g1->Draw("APL");
	g1->SetTitle("Sygnal wejsciowy");
	
	//g1->GetXaxis()->SetRangeUser(0.0007,0.001);//ta linijka ustawia minimalną i maksymalną wartość wyświetlaną na osi OX (czasem trzeba kliknąć na wykres, żeby program sobie o niej przypomniał), przydatne przy dużych częstotliwościach
	g1->GetXaxis()->SetTitle("t(s)");
	g1->GetYaxis()->SetTitle("U(V)");
	c->cd(2);
	g2->Draw("APL");
	g2->SetTitle("Sygnal wyjsciowy");
	//g2->GetXaxis()->SetRangeUser(0.0007,0.001);
	g2->GetXaxis()->SetTitle("t(s)");
	g2->GetYaxis()->SetTitle("U(V)");

	return 0;
}
