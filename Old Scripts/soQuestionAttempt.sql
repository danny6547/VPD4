SELECT id, Date,
	CASE
		WHEN Date < (SELECT EndDate FROM TimeIntervals WHERE A = 9280603 ORDER BY StartDate LIMIT 1 OFFSET 0) THEN 1
		WHEN Date > (SELECT StartDate FROM TimeIntervals WHERE A = 9280603 ORDER BY StartDate LIMIT 1 OFFSET 0) AND Date < (SELECT EndDate FROM TimeIntervals WHERE A = 9280603 ORDER BY EndDate LIMIT 1 OFFSET 1) THEN 2
        WHEN Date > (SELECT StartDate FROM TimeIntervals WHERE A = 9280603 ORDER BY StartDate LIMIT 1 OFFSET 1) THEN 3
	END as 'Interval_Index'
FROM TimeData
WHERE A = 9280603