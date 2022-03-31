# safe-sql-transactions
Here is a SQL template I use when committing to a database. 

The expected rows ensure that if any unexpected rows have been edited, the transaction will not be committed.
