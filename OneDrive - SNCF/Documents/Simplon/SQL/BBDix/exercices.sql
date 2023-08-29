--1. Liste des potions : Numéro, libellé, formule et constituant principal. (5 lignes)

select *
from potion p ;

num_potion|lib_potion         |formule|constituant_principal|
----------+-------------------+-------+---------------------+
         1|Potion magique n°1 |       |Gui                  |
         2|Potion magique n°2 |4V3C2VA|Vin                  |
         3|Potion magique n°3 |2C1B   |Calva                |
         4|Potion Zen         |       |Jus de Betterave     |
         5|Potion Anti Douleur|5C3J1T |Calva                |


--2. Liste des noms des trophées rapportant 3 points. (2 lignes)

select nom_categ 
from categorie c 
where nb_points = 3;

nom_categ              |
-----------------------+
Bouclier de Légionnaire|
Casque de Centurion    |


--3. Liste des villages (noms) contenant plus de 35 huttes. (4 lignes)

select nom_village
from village v 
where nb_huttes >35;

nom_village   |
--------------+
Aquilona      |
Calendes Aquae|
Condate       |
Gergovie      |



--4. Liste des trophées (numéros) pris en mai / juin 52. (4 lignes)

select num_trophee
from trophee t 
where date_prise >= '2052-05-01' and  date_prise < '2052-07-01';

num_trophee|
-----------+
          3|
          4|
          5|
          6|



--5. Noms des habitants commençant par 'a' et contenant la lettre 'r'. (3 lignes)

select nom
from habitant h 
where lower(nom) like 'a%' and nom like '%r%';

nom            |
---------------+
Abraracourcix  |
Assurancetourix|
Astérix        |


--6. Numéros des habitants ayant bu les potions numéros 1, 3 ou 4. (8 lignes)

select distinct  num_hab
from absorber a 
where num_potion in (1,3,4);

num_hab|
-------+
     13|
     10|
      7|
      1|
      2|
     16|
     15|
      8|



--7. Liste des trophées : numéro, date de prise, nom de la catégorie et nom du preneur. (10lignes)

select num_trophee, date_prise , code_cat, nom as nom_du_preneur
from trophee t 
join categorie on t.code_cat = categorie.code_cat
join habitant h on num_hab = num_preneur ;

--8. Nom des habitants qui habitent à Aquilona. (7 lignes)

select nom
from habitant h 
join village v on h.num_village  = v.num_village 
where v.num_village = 1;

nom            |
---------------+
Abraracourcix  |
Panoramix      |
Assurancetourix|
Astérix        |
Obélix         |
Pneumatix      |
Falbala        |

--9. Nom des habitants ayant pris des trophées de catégorie Bouclier de Légat. (2 lignes)
select nom
from habitant h
join trophee t on num_hab = num_preneur
join categorie c on t.code_cat = c.code_cat 
where nom_categ = 'Bouclier de Légat';

nom       |
----------+
Bellodalix|
Obélix    |



--10. Liste des potions (libellés) fabriquées par Panoramix : libellé, formule et constituantprincipal. (3 lignes)

select lib_potion as libellé, formule , constituant_principal 
from potion p
join fabriquer f on p.num_potion = f.num_potion
join habitant h on h.num_hab = f.num_hab
where nom = 'Panoramix';

libellé            |formule|constituant_principal|
-------------------+-------+---------------------+
Potion magique n°1 |       |Gui                  |
Potion Zen         |       |Jus de Betterave     |
Potion Anti Douleur|5C3J1T |Calva                |


--11. Liste des potions (libellés) absorbées par Homéopatix. (2 lignes)

select distinct  lib_potion as libellés
from potion p
join absorber a on p.num_potion = a.num_potion 
join habitant h on a.num_hab = h.num_hab  
where nom = 'Homéopatix';

libellés          |
------------------+
Potion magique n°1|
Potion magique n°3|



--12. Liste des habitants (noms) ayant absorbé une potion fabriquée par l'habitant numéro 3. (4 lignes)

select distinct  nom
from habitant h 
join absorber a on h.num_hab = a.num_hab 
join fabriquer f on a.num_potion = f.num_potion 
where f.num_hab = 3;

nom         |
------------+
Homéopatix  |
Bellodalix  |
Moralélastix|
Astérix     |

--13. Liste des habitants (noms) ayant absorbé une potion fabriquée par Amnésix. (7 lignes)

select distinct h.nom
from habitant h 
join absorber a on h.num_hab = a.num_hab 
join fabriquer f on a.num_potion = f.num_potion
join habitant h2  on h2.num_hab = f.num_hab 
where h2.nom = 'Amnésix';

nom          |
-------------+
Abraracourcix|
Bellodalix   |
Amnésix      |
Moralélastix |
Astérix      |
Goudurix     |
Plantaquatix |

--14. Nom des habitants dont la qualité n'est pas renseignée. (2 lignes)

select nom 
from habitant h 
where num_qualite is null;

nom     |
--------+
Gélatine|
Fanzine |


--15. Nom des habitants ayant consommé la Potion magique n°1 (c'est le libellé de lapotion) en février 52. (3 lignes)

select h.nom 
from habitant h 
join absorber a on h.num_hab = a.num_hab
join potion p on a.num_potion = p.num_potion 
and p.lib_potion = 'Potion magique n°1' and a.date_a between '2052-02-01' and '2052-02-28';

nom       |
----------+
Astérix   |
Amnésix   |
Bellodalix|

--16. Nom et âge des habitants par ordre alphabétique. (22 lignes)

select h.nom, h.age 
from habitant h 
order by nom asc;

nom            |age|
---------------+---+
Abraracourcix  | 65|
Amnésix        | 56|
Asdepix        | 53|
Assurancetourix| 53|
Astérix        | 35|
Barometrix     | 68|
Bellodalix     | 32|
Cétyounix      | 32|
Eponine        | 48|
Falbala        | 26|
Fanzine        | 21|
Gélatine       | 65|
Goudurix       | 38|
Homéopatix     | 48|
Moralélastix   | 67|
Obélix         | 38|
Océanix        | 40|
Panoramix      | 79|
Plantaquatix   | 30|
Pneumatix      | 26|
Pronostix      | 35|
Zérozérosix    | 75|

--17. Liste des resserres classées de la plus grande à la plus petite : nom de resserre et nom du village. (3 lignes)
select nom_resserre, r.num_village as nom_village
from resserre r
join village v on v.num_village = r.num_village 
order by superficie;

--***

--18. Nombre d'habitants du village numéro 5. (4)

select count(*)
from habitant h
where h.num_village  = 5;

count|
-----+
    4|

--19. Nombre de points gagnés par Goudurix. (5)

select sum(nb_points)
from categorie c 
join trophee t on t.code_cat = c.code_cat 
join habitant h on h.num_hab = t.num_preneur
where h.nom = 'Goudurix';

sum|
---+
  5|

--20. Date de première prise de trophée. (03/04/52)

select min(date_prise) 
from trophee t; 

min       |
----------+
2052-04-03|


--21. Nombre de louches de Potion magique n°2 (c'est le libellé de la potion) absorbées. (19)

select sum(quantite) 
from absorber a 
join potion p on p.num_potion = a.num_potion 
where p.lib_potion = 'Potion magique n°2';

sum|
---+
 19|

--22. Superficie la plus grande. (895)

select max(superficie)
from resserre r ;

max|
---+
895|

--***

--23. Nombre d'habitants par village (nom du village, nombre). (7 lignes)

select v.nom_village as nom_du_village, count(h.num_village) as nombre
from village v 
join habitant h on h.num_village = v.num_village 
Group by nom_village ;

nom_du_village|nombre|
--------------+------+
Gergovie      |     2|
Aginum        |     2|
Aquae Calidae |     2|
Lutèce        |     3|
Aquilona      |     7|
Condate       |     4|
Calendes Aquae|     2|

--24. Nombre de trophées par habitant (6 lignes)

select distinct h.nom, count(t.num_preneur) as nombre_de_trophée
from habitant h 
join trophee t on t.num_preneur = h.num_hab
Group by h.nom;

nom          |nombre_de_trophée|
-------------+-----------------+
Bellodalix   |                2|
Astérix      |                2|
Goudurix     |                3|
Obélix       |                1|
Abraracourcix|                1|
Pronostix    |                1|

--25. Moyenne d'âge des habitants par province (nom de province, calcul). (3 lignes)

select nom_province, round(avg(h.age),2) as moyenne_d_age
from province p 
join village v on v.num_province = p.num_province 
join habitant h on h.num_village = v.num_village 
group by nom_province ;

nom_province|moyenne_d_age|
------------+-------------+
Averne      |        49.71|
Armorique   |        43.64|
Aquitaine   |        50.50|

--26. Nombre de potions différentes absorbées par chaque habitant (nom et nombre). (9lignes)

select distinct nom, count(distinct a.num_potion)
from habitant h
join absorber a on a.num_hab = h.num_hab 
join potion p on p.num_potion = a.num_potion 
group by nom;

nom          |count|
-------------+-----+
Plantaquatix |    1|
Goudurix     |    2|
Homéopatix   |    2|
Amnésix      |    2|
Astérix      |    5|
Pronostix    |    2|
Moralélastix |    5|
Abraracourcix|    2|
Bellodalix   |    3|

--27. Nom des habitants ayant bu plus de 2 louches de potion zen. (1 ligne)

select distinct nom, sum(a.quantite) as louches_bues
from habitant h 
join absorber a on h.num_hab = a.num_hab
join potion p on p.num_potion = a.num_potion 
where p.lib_potion = 'Potion Zen' group by nom having sum(a.quantite) >2 ;

nom         |louches_bues|
------------+------------+
Moralélastix|           3|

--***
--28. Noms des villages dans lesquels on trouve une resserre (3 lignes)

select v.nom_village as village_avec_resserre
from village v 
join resserre r on r.num_village = v.num_village ;

village_avec_resserre|
---------------------+
Calendes Aquae       |
Gergovie             |
Aquilona             |

--29. Nom du village contenant le plus grand nombre de huttes. (Gergovie)

select v.nom_village
from village v 
where nb_huttes = (select max(nb_huttes) from village);

nom_village|
-----------+
Gergovie   |

--30. Noms des habitants ayant pris plus de trophées qu'Obélix (3 lignes).

select distinct  nom 
from habitant h 
join trophee t on t.num_preneur = h.num_hab group by nom having count(t.num_preneur) >  (
    SELECT COUNT(NUM_PRENEUR)
    FROM TROPHEE
    JOIN HABITANT ON TROPHEE.NUM_PRENEUR = HABITANT.NUM_HAB
    WHERE HABITANT.NOM = 'Obélix');

nom       |
----------+
Bellodalix|
Astérix   |
Goudurix  |
