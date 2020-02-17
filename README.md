### Repository for collecting Assignments for the Data Science Method course
- [Assignment 1](https://tilburguniversity.instructure.com/courses/1876/assignments/14065)

### Comments on the uploaded code

General comments
Ho fatto l'esercizio 1. Ho commentato tutto pesantemente in modo che tu possa scorrere il codice velocemente (comunque non c'è nulla di esoterico). 3 questioni:
-Ho fatto come dicevamo insieme, ovvero tutto in un grande loop. In realtà leggendo meglio forse la prof voleva che facessimo le cose staccate per ogni agente inquinante, o almeno, faresulphur da solo e poi un loop con gli altri. Quindi pensavo il seguente per il file Rmd: o scorporiamo sulphur dal loop e il resto lo teniamo nel loop, oppure facciamo girare tutto il codice e poi di volta in volta chiamiamo gli output che ci servono per commentarli(il loop dà come output tutto ciò che ci serve). 
*Io direi che si possono salvare i file invece che fare print alla fine del loop. Sto cambiando qualche cosina per fare in modo che i grafici siano leggibili.*
-l'unica cosa che non mi convince sono i risultati del BIC. Per i calcoli sono abbastanza sicuro, sono anche andato a ricevimento dalla prof perchè non capivo bene quel X=aF + e (quando spiega Bai&Ng), e mi ha rassicurato che quel 'a' è il trasposto della matrice dei loadings, come ho fatto io. Però il BIC(k) viene monotonico decrescente in k (prende sempre il modello con più k). Guardando i calcoli si vede che, aggiungendo principal components, il ln(SSR) cresce molto più della penalty: da qui il fatto che sceglie il modello con più k. Forse la questione è che il BIC funziona decentemente solo per n,p->infinity.
**Ha messo un commento su canvas, mi pare di aver capito che come li avevi fatti tu erano sbagliati **
-si può valutare di tagliare i grafici che plottano i primi due PC per renderli più leggibili.
**c'è un pacchetto per ggplot che fa in modo di mettere i labels che non si sovrappongano, sto cercando di cambiare autoplot--> ggplot in modo da poterlo usare. Ho anche aggiunto l'abbreviazione al posto del nome del paese e mi sono reso conto che sistemando i dataset nel loop non serve aggiungere *"_pollutantname"*
- Ho messo il codice in markdown e cominciato ad editarlo, tra oggi e domani conto di finire tutto per bene Ex. 1 
