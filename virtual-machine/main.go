package main

import (
	"fmt"
)

const (
	LOAD  = 0x01
	STORE = 0x02
	ADD   = 0x03
	HALT  = 0xFF
	PC    = 0x00
	A     = 0x01
	B     = 0x02
)

// var memory []int

// var registers []int

func virtualMachine(memory, registers) {
	for memory[registers[PC]] {
		switch op {
		}
	}
}

func main() {
	fmt.Println("Hello world!")
	fmt.Println(LOAD)
	fmt.Println(STORE)
	fmt.Println(ADD)
	fmt.Println(HALT)
	fmt.Println(PC)
	fmt.Println(A)
	fmt.Println(B)
}
