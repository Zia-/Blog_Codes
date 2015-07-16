alter table kn_dem_clip_finer add column the_geom_st_centroid geometry;
update kn_dem_clip_finer set the_geom_st_centroid = st_centroid(the_geom_st_envelope);
create index the_geom_st_centroid_idx on kn_dem_clip_finer using gist(the_geom_st_centroid);
*** After every index creation run the VACCUM and ANALYZE for that table (maintenance) from pgAdmin3***