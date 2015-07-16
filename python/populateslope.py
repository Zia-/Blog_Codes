import psycopg2
import osgeo.ogr
import math
from math import asin
connection = psycopg2.connect("host='localhost' dbname='osm_dem' user='postgres' password='zia123'")
cursor1 = connection.cursor()
cursor2 = connection.cursor()
cursor1.execute('select height_st_, height_end, length_dem, gid from kn_ways_new_split_saveas')
for i in cursor1:
if i[2]==0:
cursor2.execute('update srtm90_saveas set slope = %s where gid = %s', [0, i[3]])
else:
if i[0]>=i[1]:''' This if there are some closed geometries (which are errors) at the vertices which are useless, then just assign 0 slope to them, coz they are not gonna contribute to any route calculations.'''
slope = asin((i[0]-i[1])/i[2])
else:
slope = asin((i[1]-i[0])/i[2])
cursor2.execute('update kn_ways_new_split_saveas set slope = %s where gid = %s', [slope, i[3]])
print 'executed %s' % i[3]
connection.commit()