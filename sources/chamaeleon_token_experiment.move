module chamaeleon_token_experiment::chamaeleon {
    use sui::coin::{Self, TreasuryCap};

    public struct CHAMAELEON has drop {}

    fun init(witness: CHAMAELEON, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"CHAMAELEON", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, ctx.sender())
    }

    public fun mint(
        treasury_cap: &mut TreasuryCap<CHAMAELEON>, 
        amount: u64, 
        recipient: address, 
        ctx: &mut TxContext,
    ) {
        let coin = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(coin, recipient)
    }
}
