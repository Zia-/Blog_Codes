create table osm as
SELECT seq, id1 AS node, id2 AS edge, cost, b.the_geom as the_geom FROM pgr_dijkstra('
SELECT gid AS id,
source::integer,
target::integer,
length::double precision AS cost
FROM kn_ways',
56, 4, false, false) a LEFT JOIN kn_ways b ON (a.id2 = b.gid);
create table zia as
SELECT seq, id1 AS node, id2 AS edge, cost, b.the_geom as the_geom FROM pgr_dijkstra('
SELECT gid AS id,
source::integer,
target::integer,
length_dem::double precision AS cost
FROM kn_ways_new_split_saveas',
292, 245, false, false) a LEFT JOIN kn_ways_new_split_saveas b ON (a.id2 = b.gid);
-- This "long_end_p" column has missing "t" in the "kn_ways_new_split_saveas" table. During hte "shp2pgsql-gui" import. Dunny why this is happening?
create table zia_astar_reverse_cost as
SELECT seq, id1 AS node, id2 AS edge, cost, b.geom FROM pgr_astar('
SELECT gid AS id,
source::integer,
target::integer,
length_dem::double precision AS cost,
long_st_pt::double precision AS x1,
lat_st_pt::double precision AS y1,
long_end_p::double precision AS x2,
lat_end_pt::double precision AS y2,
reverse_cost::double precision
FROM kn_ways_new_split_saveas',
2554, 4811, true, true) a LEFT JOIN kn_ways_new_split_saveas b ON (a.id2 = b.gid);
select sum(cost) from osm; -- This length is in kilometers.
select sum(cost) from zia; -- This length is in meters.
select sum(cost) from zia_astar_reverse_cost; -- This length is in meters.