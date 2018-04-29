DROP TABLE IF EXISTS bat;
CREATE TEMPORARY TABLE bat AS
select b.playerID, nameFirst, nameLast, b.pos, bat
from 
	(select a.playerID, POS, (1B*.88 + 2B*1.2 + 3B*1.55 + HR*1.98 + BB*0.69 + RBI*.75 + a.SB*0.2 + K*-0.2 + HBP*0.72 + SAC*0.1 + a.CS*-0.42) as bat
	from
		(select playerID, yearID, (H - (2B + 3B + HR)) as 1B, 2B, 3B, HR, BB, RBI, SB, SO as K, HBP, (SF + SH) as SAC, CS
		from batting 
		where yearID = '2017') a
	left join fielding f 
	on a.playerID = f.playerID and f.yearID = '2016') b
left join 
master m
on b.playerID = m.playerID
order by bat desc;



DROP TABLE IF EXISTS pitch;
CREATE TEMPORARY TABLE pitch AS
select b.playerID, nameFirst, nameLast, pitch
from 
	(select playerID, (IP*1.2 + ER*-2 + W*4 + L*-4 + SV*3 + SO*1 + G*0.5 + BK*-1 + CG*0.75) as pitch
	from
		(select playerID, IP, ER, W, L, SV, SO, G, BK, CG
		from pitching 
		where yearID = '2017') a) b
left join 
master m
on b.playerID = m.playerID
order by pitch desc;