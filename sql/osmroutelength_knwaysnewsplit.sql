create index the_geom_idx2 on kn_ways_new_split using gist(the_geom);
*** After every index creation run the VACCUM and ANALYZE for that table (maintenance) from pgAdmin3***
alter table kn_ways_new_split add column the_geom_st_pt geometry;
alter table kn_ways_new_split add column the_geom_end_pt geometry;
alter table kn_ways_new_split add column height_st_pt double precision;
alter table kn_ways_new_split add column height_end_pt double precision;
update kn_ways_new_split set the_geom_st_pt = st_startpoint(the_geom);
update kn_ways_new_split set the_geom_end_pt = st_endpoint(the_geom);
create index the_geom_st_pt_idx on kn_ways_new_split using gist(the_geom_st_pt);
*** After every index creation run the VACCUM and ANALYZE for that table (maintenance) from pgAdmin3***
create index the_geom_end_pt_idx on kn_ways_new_split using gist(the_geom_end_pt);
*** After every index creation run the VACCUM and ANALYZE for that table (maintenance) from pgAdmin3***