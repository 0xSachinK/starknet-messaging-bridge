%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1

@external
func create_l1_nft_message{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(l1_user: felt):
    let (message_payload: felt*) = alloc()
    assert message_payload[0] = 776049830375714724853729712240729278903704230495        # l1 user
    let l1_contract_address = 627085109749780191835743010815342206504473004878
    send_message_to_l1(
        to_address=l1_contract_address,
        payload_size=1,
        payload=message_payload
    )
    return ()
end