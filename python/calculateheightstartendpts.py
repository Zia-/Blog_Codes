import psycopg2
import osgeo.ogr
connection = psycopg2.connect("host='localhost' dbname='osm_dem' user='postgres' password='zia123'")
cursor1 = connection.cursor()
cursor1.execute('select count(*) from kn_ways_new_split')
for i in cursor1:
count = i[0]
for x in range(count):
height=0
cursor1.execute('select avg_height from kn_dem_clip_finer r, kn_ways_new_split n where n_id=(%s+1)'+
'order by st_distance(n.the_geom_st_pt, r.the_geom_st_centroid) ASC limit 2', [x])
for s in cursor1:
height+=s[0]
height_avg = height/2
cursor1.execute('update kn_ways_new_split set height_st_pt = %s where n_id=(%s+1)', [height_avg, x])
height=0
cursor1.execute('select avg_height from kn_dem_clip_finer r, kn_ways_new_split n where n_id=(%s+1)'+
'order by st_distance(n.the_geom_end_pt, r.the_geom_st_centroid) ASC limit 2', [x])
for s in cursor1:
height+=s[0]
height_avg = height/2
cursor1.execute('update kn_ways_new_split set height_end_pt = %s where n_id=(%s+1)', [height_avg, x])
print x
connection.commit()