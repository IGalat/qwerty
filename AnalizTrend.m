% створюємо структуру для семантичноїмережі
SN=SNnew;
% додаємовузли типу "АБО" - значенняатрибутів
SN=SNaddORnode(SN,'>0.05','<-0.05','<0.05&>-0.05');
% додаємовузли типу "ТА" - об’єкти і назвиатрибутів
SN=SNaddANDnode(SN,'trends','buying','trend','trend dollar-euro','trend dollar-yen','trend dollar-grivna','trend dollar-rubl','trend dollar-rubl','dollar','euro','yen','grivna','rubl');
% додаємовідносиниміжвузлами
SN=SNaddrelation(SN,'trends','has','buying');
SN=SNaddrelation(SN,'trends','has','trend');
SN=SNaddrelation(SN,'buying','type','dollar');
SN=SNaddrelation(SN,'buying','type','euro');
SN=SNaddrelation(SN,'buying','type','yen');
SN=SNaddrelation(SN,'buying','type','grivna');
SN=SNaddrelation(SN,'buying','type','rubl');

SN=SNaddrelation(SN,'trend','type','trend dollar-euro');
SN=SNaddrelation(SN,'trend','type','trend dollar-yen');
SN=SNaddrelation(SN,'trend','type','trend dollar-grivna');
SN=SNaddrelation(SN,'trend','type','trend dollar-rubl');

SN=SNaddrelation(SN,'trend dollar-euro','type','>0.05');
SN=SNaddrelation(SN,'trend dollar-euro','type','<-0.05');
SN=SNaddrelation(SN,'trend dollar-euro','type','<0.05&>-0.05');

SN=SNaddrelation(SN,'trend dollar-yen','type','>0.05');
SN=SNaddrelation(SN,'trend dollar-yen','type','<-0.05');
SN=SNaddrelation(SN,'trend dollar-yen','type','<0.05&>-0.05');

SN=SNaddrelation(SN,'trend dollar-grivna','type','>0.05');
SN=SNaddrelation(SN,'trend dollar-grivna','type','<-0.05');
SN=SNaddrelation(SN,'trend dollar-grivna','type','<0.05&>-0.05');

SN=SNaddrelation(SN,'trend dollar-rubl','type','>0.05');
SN=SNaddrelation(SN,'trend dollar-rubl','type','<-0.05');
SN=SNaddrelation(SN,'trend dollar-rubl','type','<0.05&>-0.05');


SN=SNaddrelation(SN,'>0.05','include','euro');
SN=SNaddrelation(SN,'>0.05','include','yen');
SN=SNaddrelation(SN,'>0.05','include','grivna');
SN=SNaddrelation(SN,'>0.05','include','rubl');

SN=SNaddrelation(SN,'<-0.05','include','euro');
SN=SNaddrelation(SN,'<-0.05','include','yen');
SN=SNaddrelation(SN,'<-0.05','include','grivna');
SN=SNaddrelation(SN,'<-0.05','include','rubl');

SN=SNaddrelation(SN,'<0.05&>-0.05','include','euro');
SN=SNaddrelation(SN,'<0.05&>-0.05','include','yen');
SN=SNaddrelation(SN,'<0.05&>-0.05','include','grivna');
SN=SNaddrelation(SN,'<0.05&>-0.05','include','rubl');

% будуємографічнізображеннясхемисемантичноїмережі
SNplot(SN, 'hierarchy'); % ієрархічнерозташуваннявузлів
figure; % створюємоновевікно для іншоїсхеми
SNplot(SN, 'circle'); %  круговерозташуваннявузлів
SN1=SN;
% додаємо до мережі-запитуцільовийвузол
SN1=SNaddANDnode(SN1, '?');
% додаємо до мережі-запитувідношення для цільовоговузла
SN1=SNaddrelation(SN1,'trend','type','?');
figure; % створюємоновевікно для схеми
% будуємографічнезображеннясхемимережі-запиту
SNplot(SN1, 'random'); % випадковерозташуваннявузлів
% результатиякоговидаємо на екран
Res=SNfind(SN, SN1);
