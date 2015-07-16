import psycopg2
import osgeo.ogr
import math
connection = psycopg2.connect("host='localhost' dbname='osm_dem' user='postgres' password='zia123'")
cursor1 = connection.cursor()
cursor2 = connection.cursor()
cursor1.execute("SELECT seq, id1 AS node, id2 AS edge, cost, b.the_geom, b.source, b.target, b.slope_st_pt, b.slope_end_pt as the_geom FROM pgr_dijkstra('SELECT gid AS id, source::integer, target::integer, length_dem::double precision AS cost FROM kn_ways_new_split_saveas', 350, 329, false, false) a LEFT JOIN kn_ways_new_split_saveas b ON (a.id2 = b.gid)")
for i in cursor1:
if i[1]==i[5]:
print i[0], i[1], i[2], i[3], i[4], i[7]
elif i[1]==i[6]:
print i[0], i[1], i[2], i[3], i[4], i[8]
connection.commit()