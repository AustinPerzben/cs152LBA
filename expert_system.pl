% Tell prolog that known/3 will be added later by asserta
:- dynamic known/3.

banned(usa, india).
banned(uk, usa).
banned(india, uk).
banned(germany, usa).
requires_test(usa).

inrotation(true) :- (semester(1); semester(2)), city(san_francisco).
inrotation(false) :- (semester(1); semester(2)), not(city(san_francisco)).

inrotation(true) :- semester(3), city(seoul).
inrotation(false) :- semester(3), not(city(seoul)).

inrotation(true) :- semester(4), city(hyderabad).
inrotation(false) :- semester(4), not(city(hyderabad)).

inrotation(true) :- semester(5), city(berlin).
inrotation(false) :- semester(5), not(city(berlin)).

inrotation(true) :- semester(6), city(buenos_aires).
inrotation(false) :- semester(6), not(city(buenos_aires)).

inrotation(true) :- semester(7), city(london).
inrotation(false) :- semester(7), not(city(london)).

inrotation(true) :- semester(8), city(taipei).
inrotation(false) :- semester(8), not(city(taipei)).


visa(false) :- nationality(usa), planned_city(san_francisco).
visa(true) :- nationality(usa), planned_city(seoul).
visa(false) :- nationality(usa), planned_city(hyderabad).
visa(false) :- nationality(usa), planned_city(london).
visa(false) :- nationality(uk), planned_city(london).
visa(false) :- nationality(uk), planned_city(berlin).
visa(true) :- nationality(uk), planned_city(india).
visa(true) :- nationality(uk), planned_city(san_francisco).

travel(no) :- banned(usa, korea), city(seoul).
travel(no) :- banned(usa, india), city(hyderabad).
travel(no) :- banned(india, germany), city(berlin).
travel(yes) :- not(banned(usa, germany)), city(berlin).
travel(yes) :- not(banned(usa, uk)), city(london).

test(itaewon) :- requires_test(usa), planned_city(san_francisco), city(seoul).
test(moscone) :- requires_test(korea), planned_city(seoul), city(san_francisco).
test(berlin_testing) :- requires_test(india), planned_city(hyderabad), city(berlin).
test(hitech_hospital) :- requires_test(germany), planned_city(berlin), city(hyderabad).
test(hitec_hospi) :- requires_test(usa), planned_city(san_francisco), city(hyderabad).


contact(city_minerva_kgi_edu) :- inrotation(true), need_help(yes).
contact(visas_minerva_kgi_edu) :- inrotation(true), need_help(yes).

contact(embassy) :- inrotation(false), need_help(yes).
contact(friends) :- inrotation(false), need_help(yes).

contact(minerva_health) :- symptoms(true), inrotation(true).
contact(insurance_minerva) :- symptoms(true), inrotation(true).
contact(local_doctor) :- symptoms(true), inrotation(false).

contact(residence) :- covid_results(positive), inrotation(true).
contact(resident_assistant) :- covid_results(positive), inrotation(true).
contact(hospital) :- covid_results(positive), inrotation(false).
contact(friends) :- covid_results(positive), inrotation(false).


semester(X) :- ask(semester, X).
symptoms(X) :- ask(symptoms, X).
city(X) :- ask(city, X).
planned_city(X) :- ask(planned_city, X).
nationality(X) :- ask(nationality, X).
need_help(X) :- ask(need_help, X).
covid_results(X) :- ask(covid_results, X).

multivalued(none).

ask(A, V):-
known(yes, A, V),
!.

ask(A, V):-
known(_, A, V),
!, fail.

ask(A, V):-
\+multivalued(A),
known(yes, A, V2),
V \== V2,
!.

ask(A, V):-
read_py(A,V,Y),
asserta(known(Y, A, V)),
write_py(known(Y, A, V)),
Y == yes.