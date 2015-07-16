alter table kn_ways_new_split add column long_st_pt double precision;
alter table kn_ways_new_split add column lat_st_pt double precision;
alter table kn_ways_new_split add column long_end_pt double precision;
alter table kn_ways_new_split add column lat_end_pt double precision;
update kn_ways_new_split set long_st_pt = (select st_x(the_geom_st_pt));
update kn_ways_new_split set lat_st_pt = (select st_y(the_geom_st_pt));
update kn_ways_new_split set long_end_pt = (select st_x(the_geom_end_pt));
update kn_ways_new_split set lat_end_pt = (select st_y(the_geom_end_pt));