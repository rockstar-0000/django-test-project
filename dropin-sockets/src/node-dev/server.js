// Node.js WebSocket server script
const http = require('http');
const WebSocketServer = require('websocket').server;
const server = http.createServer();
server.listen(8000);
const wsServer = new WebSocketServer({
    httpServer: server
});
wsServer.on('request', function(request) {
    const connection = request.accept(null, request.origin);
    connection.on('message', function(message) {
        console.log('Received Message:', message.utf8Data);
        connection.sendUTF(JSON.stringify( {
            'l': 'test',
            'e': '',
            'v': JSON.parse(message.utf8Data).v

        }));
    });
    connection.on('close', function(reasonCode, description) {
        console.log('Client has disconnected.');
    });

});