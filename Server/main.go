package main

import (
	"log"
	"net"
	"time"
)

var clients[] net.Conn

func handleConnection(con net.Conn) {
	defer func() {
		log.Println(con.RemoteAddr(), "disconnected.")
		con.Close()
	}()
	log.Println(con.RemoteAddr(), "connected.")

	buf := make([]byte, 64)

	for {
		n, err := con.Read(buf)
		if err != nil {
			log.Println(err)
			return
		}
		con.SetReadDeadline(time.Now().Add(time.Second * 5))

		for l := 0; l < len(clients); l++ {
			if _, err := clients[l].Write(buf[:n]); err != nil {
				log.Println(err)
			}
		}
	}
}

//TODO finish this
func main() {
	log.Println("Server started.")

	l, err := net.Listen("tcp", ":8888")
	if err != nil {
		log.Fatal(err)
	}
	defer func() {
		log.Println("Server stopped.")
		err = l.Close()
		if err != nil {
			log.Fatal(err)
		}
	}()

	for {
		con, err := l.Accept()
		if err != nil {
			log.Fatal(err)
		}
		clients = append(clients, con)

		go handleConnection(con)
	}
}