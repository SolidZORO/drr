Q: ERROR: for prod_nginx Cannot start service nginx: driver failed programming external connectivity on endpoint
A: sudo lsof -i :80, find and kill the app.

