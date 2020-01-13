# Initializing the 5 instructions and 3 registers with address values.
LOAD  = 0x01
STORE = 0x02
ADD   = 0x03
HALT  = 0xFF
PC    = 0x00
A     = 0x01
B     = 0x02

# Method which takes our main memory array and registers as arguments.
# The method will end up mutating the main memory array.
def virtual_computer(memory, registers)
 # Loop will continue until we reach the point in our memory array that
 # contains the halt instruction.
 while memory[registers[PC]] != HALT do
   puts "============================", "No HALT yet", "============================"
   puts "PC: ", PC
   puts "registers[PC]: ", registers[PC]
   puts "memory[registers[PC]]: ", memory[registers[PC]]
   puts
   op = memory[registers[PC]]
   registers[PC] += 1
   case op
   when LOAD
     puts "============================", "IN LOAD", "============================"
     puts "PC: ", PC
     puts "registers[PC]: ", registers[PC]
     puts "memory[registers[PC]]: ", memory[registers[PC]]
     register_address = memory[registers[PC]]
     puts "register_address: ", register_address
     puts
     registers[PC] += 1
     word_address = memory[registers[PC]]
     puts "word_address: ", word_address
     puts
     registers[PC] += 1
     # load both bytes in word
     # Have to add the 2 bytes together to get the "full value" if the value is greater than 1 byte.
     # Ex: 3 can be represeted in one byte, so we have 3 + 0 = 3
     # Ex: 5281 is too big for one byte, so we have 161 + (256 * 20) = 161 + 5120 = 5281
     # memory[word_address] is the least significant byte
     # memory[word_address + 1] is the most significant byte
     registers[register_address] = memory[word_address] + (256 * memory[word_address + 1])
     puts "memory[word_address]: ", memory[word_address]
     puts "(256 * memory[word_address + 1]) : ", (256 * memory[word_address + 1])
     puts "registers[register_address]: ", registers[register_address]
     puts
   when STORE
     puts "============================", "IN STORE", "============================"
     puts "PC: ", PC
     puts "registers[PC]: ", registers[PC]
     puts "memory[registers[PC]]: ", memory[registers[PC]]
     register_address = memory[registers[PC]]
     puts "register_address: ", register_address
     puts
     registers[PC] += 1
     word_address = memory[registers[PC]]
     puts "word_address: ", word_address
     puts
     registers[PC] += 1
     # We have to split our value so that it's represented by two bytes
     # write first (low order) byte
     # This will be the least significant byte so we find the value modulo 256
     memory[word_address] = registers[register_address] % 256
     puts "memory[word_address]: ", memory[word_address]
     puts
     # write second (high order) byte
     # This will be the most significant byte so we find the value divided by 256,
     # which is the reverse of when we multiplied by 256
     memory[word_address + 1] = registers[register_address] / 256
     puts "memory[word_address + 1]: ", memory[word_address + 1]
     puts
   when ADD
     puts "============================", "IN ADD", "============================"
     puts "PC: ", PC
     puts "registers[PC]: ", registers[PC]
     puts "memory[registers[PC]]: ", memory[registers[PC]]
     register_address_a = memory[registers[PC]]
     puts "register_address_a: ", register_address_a
     puts
     registers[PC] += 1
     register_address_b = memory[registers[PC]]
     puts "register_address_b: ", register_address_b
     puts
     registers[PC] += 1
     # peform computation on values in registers
     registers[register_address_a] = registers[register_address_a] + registers[register_address_b]
     puts "registers[register_address_a]: ", registers[register_address_a]
     puts
   end
 end
end

memory = [
 1,1,0x10, # 0x00: load A 0x10
 1,2,0x12, # 0x03: load B 0x12
 3,1,2,    # 0x06: add A B
 2,1,0x0E, # 0x09: store A 0x0E
 0xFF,     # 0x0C: halt
 0,        # 0x0D: <<unused>>
 0,0,      # 0x0E: output
 2,0,      # 0x10: input X = 2
 3,0       # 0x12: input Y = 3
]

registers = [ # 2 bytes wide
 0x0000, # PC
 0x0000, # A
 0x0000  # B
]

virtual_computer(memory, registers)
p memory[0x0E] == 5 # test the program worked
p memory # check out the new memory state
