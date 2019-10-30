
dbConnector <- function(session, dbname) {
  require(RSQLite)
  ## setup connection to database
  conn <- dbConnect(drv = SQLite(), 
                    dbname = dbname)
  ## disconnect database when session ends
  session$onSessionEnded(function() {
    dbDisconnect(conn)
  })
  ## return connection
  conn
}

dbGetData <- function(conn, tblname, month, day) {
  query <- paste("SELECT * FROM",
                 tblname,
                 "WHERE month =",
                 as.character(month),
                 "AND day =",
                 as.character(day))
  as.data.table(dbGetQuery(conn = conn,
                           statement = query))
}

