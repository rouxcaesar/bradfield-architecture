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

func virtualMachine(memory, registers *[]int) {
	var (
		op                 int
		register_address   int
		word_address       int
		register_address_a int
		register_address_b int
	)
	// Have to dereference the slice before we can access the element.
	for (*memory)[(*registers)[PC]] != HALT {
		op = (*memory)[(*registers)[PC]]
		(*registers)[PC] += 1
		switch op {
		case LOAD:
			register_address = (*memory)[(*registers)[PC]]
			(*registers)[PC] += 1
			word_address = (*memory)[(*registers)[PC]]
			(*registers)[PC] += 1
			(*registers)[register_address] = (*memory)[word_address] + (256 * (*memory)[word_address+1])
		case STORE:
			register_address = (*memory)[(*registers)[PC]]
			(*registers)[PC] += 1
			word_address = (*memory)[(*registers)[PC]]
			(*registers)[PC] += 1
			(*memory)[word_address] = (*registers)[register_address] % 256
			(*memory)[word_address+1] = (*registers)[register_address] / 256
		case ADD:
			register_address_a = (*memory)[(*registers)[PC]]
			(*registers)[PC] += 1
			register_address_b = (*memory)[(*registers)[PC]]
			(*registers)[PC] += 1
			(*registers)[register_address_a] = (*registers)[register_address_a] + (*registers)[register_address_b]
		}
	}
}

func main() {

	// 1, 1, 0x10 - 0x00: load A 0x10
	// 1, 2, 0x12 - 0x03: load B 0x12
	// 3, 1, 2    - 0x06: add A B
	// 2, 1, 0x0E - 0x09: store A 0x0E
	// 0xFF       - 0x0C: halt
	// 0          - 0x0D: <<unused>>
	// 0, 0       - 0x0E: output
	// 2, 0       - 0x10: input X = 2
	// 3, 0       - 0x12: input Y = 3
	memory := []int{1, 1, 0x10, 1, 2, 0x12, 3, 1, 2, 2, 1, 0x0E, 0xFF, 0, 0, 0, 2, 0, 3, 0}

	// 2 bytes wide
	// PC, A, B
	registers := []int{0x0000, 0x0000, 0x0000}

	virtualMachine(&memory, &registers)
	fmt.Printf("memory[0x0E]: %v\n", memory[0x0E]) // should equal 5
	fmt.Printf("memory: %v\n", memory)             // checkout out new memory state
}
