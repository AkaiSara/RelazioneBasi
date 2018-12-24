# Repository del progetto di Basi di Dati

## Per compilare

Necessario aver preinstallato TexLive, pdflatex e macchina Linux.
Eseguire lo script `compila.sh`

## Organizzazione 

I file `.tex` sono contenuti nella cartella _doc_ e sono divisi in **config** contenente la configurazione e i pacchetti usati, **relazione** che è il main file al quale al suo interno richiama **progCon** contenente la progettazione concettuale, **progLog** contenente la progettazione logica e **impl** contenente la parte di implementazione(query, funzioni e trigger).
Il file `.sql` si trova nella cartella _src_.
