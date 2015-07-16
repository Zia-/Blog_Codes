create table kn_dem_clip_finer_pixelascentroid as
select val, geom as the_geom from (select (ST_PixelAsCentroids(rast)).* from kn_dem_clip_finer) foo;
create index the_geom_idx on kn_dem_clip_finer_pixelascentroid using gist(the_geom);
*** After every index creation run the VACCUM and ANALYZE for that table (maintenance) from pgAdmin3***