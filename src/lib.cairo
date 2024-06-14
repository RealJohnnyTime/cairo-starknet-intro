// TODO: Create the `IMyFirstCairoContract` interface with `set_number` and `get_number` functions
#[starknet::interface]
pub trait IMyFirstCairoContract<TContractState> {
    fn set_number(ref self: TContractState, number: u256);
    fn get_number(self: @TContractState) -> u256;
}

// TODO: Create a `MyFirstCairoContract` contract
// 1. Define the contract
// 2. Define the contract's storage
// 3. Define the `NumberChanged` event
// 4. Write the constructor function that receives `initial_value` and sets the number, emit the `NumberChanged` event
// 5. Create the `IMyFirstCairoContractImpl`
// 6. Implement the `set_number` and `get_number` functions, emit an event of `NumberChanged` in `set_number`

#[starknet::contract]
mod MyFirstCairoContract {
    #[storage]
    struct Storage {
        number: u256
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        NumberChanged: NumberChanged
    }

    #[derive(Drop, starknet::Event)]
    struct NumberChanged {
        old_number: u256,
        new_number: u256
    }

    #[constructor]
    fn constructor(ref self: ContractState, initial_value: u256) {
        self.number.write(initial_value);
        self.emit(NumberChanged { old_number: 0, new_number: initial_value });
    }

    #[abi(embed_v0)]
    impl IMyFirstCairoContractImpl of super::IMyFirstCairoContract<ContractState> {
        fn set_number(ref self: ContractState, number: u256) {
            self.emit(NumberChanged { old_number: self.number.read(), new_number: number });
            self.number.write(number);
        }

        fn get_number(self: @ContractState) -> u256 {
            self.number.read()
        }
    }
}
