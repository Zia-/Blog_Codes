with x as
(
SELECT seq, id1 AS node, id2 AS edge, cost, b.the_geom, b.source, b.target, b.slope_st_pt, b.slope_end_pt FROM pgr_dijkstra('
SELECT gid AS id,
source::integer,
target::integer,
length_dem::double precision AS cost
FROM kn_ways_new_split_saveas',
292, 349, false, false) a LEFT JOIN kn_ways_new_split_saveas b ON (a.id2 = b.gid)
)
select seq, node, edge, cost, the_geom, case
when node=source then slope_st_pt
else slope_end_pt
end as slope
from x