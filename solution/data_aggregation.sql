USE mydb;

/*
Total expenses
*/

SELECT SUM(Timestamp_end - Timestamp_start)*0.04 FROM Call_logs
WHERE Call_dir = 'out' AND
(Call_logs.To IN (SELECT Call_forwarding.From FROM Call_forwarding 
WHERE NOT EXISTS(SELECT Phone_Number FROM Numbers WHERE Phone_Number = Call_forwarding.To)) OR 
NOT EXISTS(SELECT Phone_Number FROM Numbers WHERE Phone_Number = Call_logs.to));

/*
Top 10: Users with the highest charegs
*/

SELECT Call_logs.From, SUM((Timestamp_end - Timestamp_start)*0.04) as Charges FROM Call_logs 
WHERE Call_dir = 'out' AND
(Call_logs.To IN (SELECT Call_forwarding.From FROM Call_forwarding 
WHERE NOT EXISTS(SELECT Phone_Number FROM Numbers WHERE Phone_Number = Call_forwarding.To)) OR 
NOT EXISTS(SELECT Phone_Number FROM Numbers WHERE Phone_Number = Call_logs.to))
GROUP BY Call_logs.From
ORDER BY Charges DESC
LIMIT 10;
