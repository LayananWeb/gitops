# Odoo RDS Alert Template (Grafana)

Use these alerts in Grafana Alerting with your PostgreSQL datasource.

## Datasource
- Type: PostgreSQL
- Target DB: Odoo RDS database

## Rule 1: Idle In Transaction Sessions
- Query:
```sql
select count(*)::int as value
from pg_stat_activity
where datname = 'odoo'
  and state = 'idle in transaction'
  and xact_start is not null
  and now() - xact_start > interval '5 minutes';
```
- Condition: `value > 0` for `5m`
- Severity: warning

## Rule 2: Long Running Active Queries
- Query:
```sql
select count(*)::int as value
from pg_stat_activity
where datname = 'odoo'
  and state = 'active'
  and query_start is not null
  and now() - query_start > interval '2 minutes';
```
- Condition: `value > 3` for `5m`
- Severity: warning

## Rule 3: Blocked Sessions
- Query:
```sql
with blocked as (
  select distinct a.pid
  from pg_stat_activity a
  join pg_locks la on la.pid = a.pid and not la.granted
  join pg_locks lb on lb.locktype = la.locktype
     and lb.database is not distinct from la.database
     and lb.relation is not distinct from la.relation
     and lb.page is not distinct from la.page
     and lb.tuple is not distinct from la.tuple
     and lb.virtualxid is not distinct from la.virtualxid
     and lb.transactionid is not distinct from la.transactionid
     and lb.classid is not distinct from la.classid
     and lb.objid is not distinct from la.objid
     and lb.objsubid is not distinct from la.objsubid
     and lb.pid <> la.pid
  where lb.granted
)
select count(*)::int as value from blocked;
```
- Condition: `value > 0` for `2m`
- Severity: critical

## Rule 4: Connections Near Max
- Query:
```sql
with x as (
  select
    (select count(*) from pg_stat_activity where datname = 'odoo')::float as current_conn,
    (select setting::float from pg_settings where name = 'max_connections') as max_conn
)
select round((current_conn / nullif(max_conn,0)) * 100, 2) as value
from x;
```
- Condition: `value > 80` for `10m`
- Severity: warning

## Notes
- Replace `'odoo'` with your real DB name if different.
- Keep alert evaluation interval at `1m`.
- Recommended notifications: Slack + PagerDuty/Telegram.
