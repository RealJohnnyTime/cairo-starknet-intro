// TODO: Add the necessary imports
use starknet::ContractAddress;
use snforge_std::{declare, ContractClassTrait, start_prank, stop_prank, CheatTarget, start_warp};
use cairo_starknet_intro::IMyFirstCairoContractDispatcher;
use cairo_starknet_intro::IMyFirstCairoContractDispatcherTrait;

#[test]
fn first_cairo_contract_tests() {
    // TODO: Deploy the contract
    let contract_class = declare("MyFirstCairoContract").unwrap();

    // TODO: Prepare the constuctor calldata
    let initial_value: u256 = 120;
    let mut constructor_calldata = Default::default();
    Serde::serialize(@initial_value, ref constructor_calldata);

    // TODO: Deploy the contract, and get the address
    let (address, _) = contract_class.deploy(@constructor_calldata).unwrap();
    let first_contract_dispatcher = IMyFirstCairoContractDispatcher { contract_address: address };

    // TODO: Check initial state
    assert(initial_value == first_contract_dispatcher.get_number(), 'Wrong number in storage!');

    // TODO: Use set number to update the number
    let new_number: u256 = 1337;
    first_contract_dispatcher.set_number(new_number);
    // Check that the number was changed
    assert(new_number == first_contract_dispatcher.get_number(), 'Wrong number in storage!');
}
