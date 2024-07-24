module chamaeleon_token_experiment::chamaeleon {
  use std::string::{String};
  use sui::coin::{Self, TreasuryCap};

  public struct CHAMAELEON has drop {}

  #[allow(lint(share_owned))]
  fun init(witness: CHAMAELEON, ctx: &mut TxContext) {
    let (treasury, metadata) = coin::create_currency(witness, 6, b"CHAMAELEON", b"", b"", option::none(), ctx);
    transfer::public_transfer(treasury, ctx.sender());
    transfer::public_share_object(metadata);
  }

  public fun mint(
    treasury_cap: &mut TreasuryCap<CHAMAELEON>, 
    amount: u64, 
    recipient: address, 
    ctx: &mut TxContext,
  ) {
    let coin = coin::mint(treasury_cap, amount, ctx);
    transfer::public_transfer(coin, recipient);
  }

  public entry fun update_name<CHAMAELEON>(
    _treasury: &coin::TreasuryCap<CHAMAELEON>,
    metadata: &mut coin::CoinMetadata<CHAMAELEON>,
    name: String,
  ) {
    coin::update_name<CHAMAELEON>(_treasury, metadata, name);
  }
}
