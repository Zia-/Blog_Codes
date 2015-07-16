alter table kn_dem_clip_finer add column the_geom_st_envelope geometry;
update kn_dem_clip_finer set the_geom_st_envelope = st_envelope(rast);
create index the_geom_st_envelope_idx on kn_dem_clip_finer using gist(the_geom_st_envelope);
*** After every index creation run the VACCUM and ANALYZE for that table (maintenance) from pgAdmin3***