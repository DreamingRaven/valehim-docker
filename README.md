# Valheim docker / compose server

You will need to modify the password in the dockerfile to whatever you like.
You will need to create the directory where the saves will be placed otherwise if docker creates it itself, it will create it with the wrong permissions.

Then you can run the container with:

```
sudo docker-compose up -d
```

When you are done you can stop the container with:

```
sudo docker-compose down
```

To connect to the container while it is running you will need to use steam servers manually as the in game browser is terrible atm being early access. In the steam application you go to View > Servers > FAVORITES > ADD A SERVER (bottom right) > put in the server IP:PORT+1 so by default that is 127.0.0.1:2457 its normally the second port that listens for new connections unfortunateley, but the game uses 3 ports by default 2456, 2457, and 2458 > FIND GAMES AT THIS ADDRESS > CONNECT / JOIN GAME


