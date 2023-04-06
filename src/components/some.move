// Move bytecode v6module 35c624a66115bf3b52a4b92a59344b9b53b5019a3ddd2f083d7265e6d6f0a568.devnet_nft {use 0000000000000000000000000000000000000000000000000000000000000001::string;use 0000000000000000000000000000000000000000000000000000000000000002::event;use 0000000000000000000000000000000000000000000000000000000000000002::object;use 0000000000000000000000000000000000000000000000000000000000000002::transfer;use 0000000000000000000000000000000000000000000000000000000000000002::tx_context;use 0000000000000000000000000000000000000000000000000000000000000002::url;


struct DevNetNFT has store, key {

id: UID,

name: String,

description: String,

url: Url
}
struct MintNFTEvent has copy, drop {

object_id: ID,

creator: address,

name: String
}

entry public mint(Arg0: vector<u8>, Arg1: vector<u8>, Arg2: vector<u8>, Arg3: &mut TxContext) {
B0:

0: CopyLoc[3](Arg3: &mut TxContext)

1: Call object::new(&mut TxContext): UID

2: MoveLoc[0](Arg0: vector<u8>)

3: Call string::utf8(vector<u8>): String

4: MoveLoc[1](Arg1: vector<u8>)

5: Call string::utf8(vector<u8>): String

6: MoveLoc[2](Arg2: vector<u8>)

7: Call url::new_unsafe_from_bytes(vector<u8>): Url

8: Pack[0](DevNetNFT)

9: StLoc[4](loc0: DevNetNFT)

10: MoveLoc[3](Arg3: &mut TxContext)

11: FreezeRef

12: Call tx_context::sender(&TxContext): address

13: StLoc[5](loc1: address)

14: ImmBorrowLoc[4](loc0: DevNetNFT)

15: ImmBorrowField[0](DevNetNFT.id: UID)

16: Call object::uid_to_inner(&UID): ID

17: CopyLoc[5](loc1: address)

18: ImmBorrowLoc[4](loc0: DevNetNFT)

19: ImmBorrowField[1](DevNetNFT.name: String)

20: ReadRef

21: Pack[1](MintNFTEvent)

22: Call event::emit<MintNFTEvent>(MintNFTEvent)

23: MoveLoc[4](loc0: DevNetNFT)

24: MoveLoc[5](loc1: address)

25: Call transfer::public_transfer<DevNetNFT>(DevNetNFT, address)

26: Ret
}
entry public update_description(Arg0: &mut DevNetNFT, Arg1: vector<u8>) {
B0:

0: MoveLoc[1](Arg1: vector<u8>)

1: Call string::utf8(vector<u8>): String

2: MoveLoc[0](Arg0: &mut DevNetNFT)

3: MutBorrowField[2](DevNetNFT.description: String)

4: WriteRef

5: Ret
}
entry public burn(Arg0: DevNetNFT) {
B0:

0: MoveLoc[0](Arg0: DevNetNFT)

1: Unpack[0](DevNetNFT)

2: Pop

3: Pop

4: Pop

5: Call object::delete(UID)

6: Ret
}
public name(Arg0: &DevNetNFT): &String {
B0:

0: MoveLoc[0](Arg0: &DevNetNFT)

1: ImmBorrowField[1](DevNetNFT.name: String)

2: Ret
}
public description(Arg0: &DevNetNFT): &String {
B0:

0: MoveLoc[0](Arg0: &DevNetNFT)

1: ImmBorrowField[2](DevNetNFT.description: String)

2: Ret
}
public url(Arg0: &DevNetNFT): &Url {
B0:

0: MoveLoc[0](Arg0: &DevNetNFT)

1: ImmBorrowField[3](DevNetNFT.url: Url)

2: Ret
}
}
