
------------------------------------------------------------------------------
-- Clear and load SymmetricDS Configuration
------------------------------------------------------------------------------

/*
delete from sym_trigger_router;
delete from sym_trigger;
delete from sym_router;
delete from sym_channel where channel_id in ('sale_transaction', 'item');
delete from sym_node_group_link;
delete from sym_node_group;
delete from sym_node_host;
delete from sym_node_identity;
delete from sym_node_security;
delete from sym_node;
*/
/*
select * from sym_trigger_router;
select * from sym_trigger;
select * from sym_router;
select * from sym_node_group_link;
select * from sym_node_group;
select * from sym_node_host;
select * from sym_node_identity;
select * from sym_node_security;
select * from sym_node;
*/

------------------------------------------------------------------------------
-- Channels
------------------------------------------------------------------------------
INSERT INTO sym_channel (channel_id, processing_order, max_batch_size) VALUES ('data', 1, 100000);


------------------------------------------------------------------------------
-- Node Groups
------------------------------------------------------------------------------
delete from sym_node_group;
insert into sym_node_group (node_group_id) values ('main-group'); -- created by bin/sys
insert into sym_node_group (node_group_id) values ('region2-group');


------------------------------------------------------------------------------
-- Node Group Links
------------------------------------------------------------------------------
insert into sym_node_group_link (source_node_group_id, target_node_group_id, data_event_action) values ('main-group', 'region2-group', 'P');
insert into sym_node_group_link (source_node_group_id, target_node_group_id, data_event_action) values ('region2-group', 'main-group', 'P');


------------------------------------------------------------------------------
-- Routers
------------------------------------------------------------------------------
-- Default router sends all data from lim to hyo and vice versa
INSERT INTO sym_router (router_id, source_node_group_id, target_node_group_id, router_type, create_time, last_update_time) VALUES
                       ('main_to_region2', 'main-group', 'region2-group', 'default', current_timestamp, current_timestamp),
                       ('region2_to_main', 'region2-group', 'main-group', 'default', current_timestamp, current_timestamp);          


------------------------------------------------------------------------------
-- Triggers
------------------------------------------------------------------------------
-- Triggers for tables on "data" channel
INSERT INTO sym_trigger (trigger_id, source_table_name, channel_id, sync_on_insert, sync_on_update, sync_on_delete, create_time, last_update_time)
                 VALUES ('clients_trigger', 'clients', 'data', 1, 1, 1, current_timestamp, current_timestamp);

------------------------------------------------------------------------------
-- Trigger Routers
------------------------------------------------------------------------------
-- Send all clients to all routers
INSERT INTO sym_trigger_router (trigger_id, router_id, create_time, last_update_time) VALUES
    ('clients_trigger', 'main_to_region2', current_timestamp, current_timestamp),
    ('clients_trigger', 'region2_to_main', current_timestamp, current_timestamp);

