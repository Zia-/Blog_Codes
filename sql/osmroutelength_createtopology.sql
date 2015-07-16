alter table kn_ways_new_split_saveas add column "source" integer;
alter table kn_ways_new_split_saveas add column "target" integer;
select pgr_createTopology('kn_ways_new_split_saveas', 0.00001, 'the_geom', 'gid');
alter table kn_ways_new_split_saveas add column reverse_cost double precision;
create table buffer as select st_buffer(the_geom, 0.00001) as the_geom, reverse_cost from kn_ways;
*** After every index creation run the VACCUM and ANALYZE for that table (maintenance) from pgAdmin3***
update kn_ways_new_split_saveas set (reverse_cost) = (buffer.reverse_cost) from buffer
where ST_Covers(buffer.the_geom, kn_ways_new_split_saveas.geom);