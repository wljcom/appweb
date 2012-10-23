/*
    send - WebSocket send tests
 */

function wait(ws: WebSocket, state: Number, timeout: Number = Number.MaxInt32): Boolean {
    for (let mark = new Date; ws.readyState != state && mark.elapsed < timeout; )
        App.run(timeout - mark.elapsed, true)
    return ws.readyState == state
}

const PORT = App.config.test.http_port || "4100"
const WS = "ws://127.0.0.1:" + PORT + "/websockets/basic/send"

assert(WebSocket)
let ws = new WebSocket(WS)
assert(ws)
assert(ws.readyState == WebSocket.CONNECTING)

let opened
ws.onopen = function (event) {
    opened = true
    ws.send("Dear Server: Thanks for listening")
}

wait(ws, WebSocket.OPEN)
assert(opened)

ws.close()
assert(ws.readyState == WebSocket.CLOSING)
wait(ws, WebSocket.CLOSED)
assert(ws.readyState == WebSocket.CLOSED)

