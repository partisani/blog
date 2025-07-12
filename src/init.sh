socat -v -d -d TCP-LISTEN:8080,crlf,reuseaddr,fork SYSTEM:"fennel server.fnl"
