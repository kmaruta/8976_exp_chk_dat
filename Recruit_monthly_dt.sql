WITH
DT AS (
SELECT d.series_cd, d.dokuji_cd, d.torihiki_kbn, d.busu
  FROM seikyu.t_den_meisai AS d
 INNER JOIN seikyu.m_monthly_chk_master AS m
    ON d.series_cd = m.mk_syohin_cd
   AND d.dokuji_cd = m.go_cd
 WHERE d.jitu_nouhin_ymd >= '20170701'
   AND d.keijo_ymd < TO_CHAR(CURRENT_TIMESTAMP, 'yyyymmdd')
)
SELECT dt.series_cd, dt.dokuji_cd,
       SUM(CASE WHEN dt.torihiki_kbn = '1' THEN dt.busu ELSE 0 END) AS "1",
       SUM(CASE WHEN dt.torihiki_kbn = '2' THEN dt.busu ELSE 0 END) AS "2",
       SUM(CASE WHEN dt.torihiki_kbn = '3' THEN dt.busu ELSE 0 END) AS "3"
  FROM dt
 GROUP BY dt.series_cd, dt.dokuji_cd
 ORDER BY dt.series_cd, dt.dokuji_cd