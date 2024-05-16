## test case

```MyDex.t.sol
 [2346092] MyDexTest::test_execute()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e]
    ├─ [0] VM::label(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], "bob")
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF])
    │   └─ ← [Return] 
    ├─ [29988] RntERC20::transfer(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 10000 [1e4])
    │   ├─ emit Transfer(from: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], to: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], value: 10000 [1e4])
    │   └─ ← [Return] true
    ├─ [0] VM::startPrank(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e])
    │   └─ ← [Return] 
    ├─ [0] VM::deal(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 10000000000000000000 [1e19])
    │   └─ ← [Return] 
    ├─ [1989874] UniswapV2Factory::createPair(RntERC20: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], WETHCoin: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4])
    │   ├─ [1816707] → new UniswapV2Pair@0x50854d49cDEbC876d0c6c47441425c7661b9b0cF
    │   │   └─ ← [Return] 8741 bytes of code
    │   ├─ [44900] UniswapV2Pair::initialize(RntERC20: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], WETHCoin: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4])
    │   │   └─ ← [Stop] 
    │   ├─ emit PairCreated(token0: RntERC20: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], token1: WETHCoin: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4], pair: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], : 1)
    │   └─ ← [Return] UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]
    ├─ [24739] RntERC20::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 10000 [1e4])
    │   ├─ emit Approval(owner: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 10000 [1e4])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [24523] WETHCoin::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 1000000000000000000 [1e18])
    │   ├─ emit Approval(owner: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [229289] MyDex::addLiquidityETH{value: 10000000000000000000}(RntERC20: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], 10000 [1e4], 8000, 10000000000000000000 [1e19], bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 3601)
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [2526] UniswapV2Pair::getReserves() [staticcall]
    │   │   └─ ← [Return] 0, 0, 0
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [26062] RntERC20::transferFrom(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 10000 [1e4])
    │   │   ├─ emit Transfer(from: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 10000 [1e4])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ [23914] WETHCoin::deposit{value: 10000000000000000000}()
    │   │   ├─ emit Deposit(user: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount: 10000000000000000000 [1e19])
    │   │   └─ ← [Stop] 
    │   ├─ [25338] WETHCoin::transfer(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 10000000000000000000 [1e19])
    │   │   ├─ emit Transfer(from: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 10000000000000000000 [1e19])
    │   │   └─ ← [Return] true
    │   ├─ [135158] UniswapV2Pair::mint(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e])
    │   │   ├─ [562] RntERC20::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 10000 [1e4]
    │   │   ├─ [541] WETHCoin::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 10000000000000000000 [1e19]
    │   │   ├─ [2327] UniswapV2Factory::feeTo() [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000
    │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: 0x0000000000000000000000000000000000000000, value: 1000)
    │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], value: 316227765016 [3.162e11])
    │   │   ├─ emit Sync(reserve0: 10000 [1e4], reserve1: 10000000000000000000 [1e19])
    │   │   ├─ emit Mint(sender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount0: 10000 [1e4], amount1: 10000000000000000000 [1e19])
    │   │   └─ ← [Return] 316227765016 [3.162e11]
    │   └─ ← [Return] 10000 [1e4], 10000000000000000000 [1e19], 316227765016 [3.162e11]
    ├─ [0] console::log("==========") [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log(10000 [1e4]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log(10000000000000000000 [1e19]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log(316227765016 [3.162e11]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [24612] UniswapV2Pair::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 316227765016 [3.162e11])
    │   ├─ emit Approval(owner: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 316227765016 [3.162e11])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [181866] MyDex::removeLiquidityETH(RntERC20: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], 316227765016 [3.162e11], 8000, 1000000000000000000 [1e18], bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 3601)
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [581] UniswapV2Pair::balanceOf(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e]) [staticcall]
    │   │   └─ ← [Return] 316227765016 [3.162e11]
    │   ├─ [0] console::log(316227765016 [3.162e11]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [26325] UniswapV2Pair::transferFrom(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 316227765016 [3.162e11])
    │   │   ├─ emit Transfer(from: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 316227765016 [3.162e11])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ [84844] UniswapV2Pair::burn(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832])
    │   │   ├─ [562] RntERC20::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 10000 [1e4]
    │   │   ├─ [541] WETHCoin::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 10000000000000000000 [1e19]
    │   │   ├─ [327] UniswapV2Factory::feeTo() [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000
    │   │   ├─ emit Transfer(from: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], to: 0x0000000000000000000000000000000000000000, value: 316227765016 [3.162e11])
    │   │   ├─ [25188] RntERC20::transfer(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 9999)
    │   │   │   ├─ emit Transfer(from: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], to: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 9999)
    │   │   │   └─ ← [Return] true
    │   │   ├─ [23338] WETHCoin::transfer(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 9999999968377223398 [9.999e18])
    │   │   │   ├─ emit Transfer(from: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], to: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 9999999968377223398 [9.999e18])
    │   │   │   └─ ← [Return] true
    │   │   ├─ [562] RntERC20::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 1
    │   │   ├─ [541] WETHCoin::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 31622776602 [3.162e10]
    │   │   ├─ emit Sync(reserve0: 1, reserve1: 31622776602 [3.162e10])
    │   │   ├─ emit Burn(sender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount0: 9999, amount1: 9999999968377223398 [9.999e18], to: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832])
    │   │   └─ ← [Return] 9999, 9999999968377223398 [9.999e18]
    │   ├─ [23188] RntERC20::transfer(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 9999)
    │   │   ├─ emit Transfer(from: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], to: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], value: 9999)
    │   │   └─ ← [Return] true
    │   ├─ [9592] WETHCoin::withdraw(9999999968377223398 [9.999e18])
    │   │   ├─ [95] MyDex::receive{value: 9999999968377223398}()
    │   │   │   └─ ← [Stop] 
    │   │   ├─ emit Withdrawal(src: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], wad: 9999999968377223398 [9.999e18], flag: true)
    │   │   └─ ← [Stop] 
    │   ├─ [0] bob::fallback{value: 9999999968377223398}()
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] 9999, 9999999968377223398 [9.999e18]
    ├─ [0] console::log(9999) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] console::log(9999999968377223398 [9.999e18]) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    └─ ← [Stop] 


[2446153] MyDexTest::test_trade()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e]
    ├─ [0] VM::label(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], "bob")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6]
    ├─ [0] VM::label(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], "alice")
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF])
    │   └─ ← [Return] 
    ├─ [29988] RntERC20::transfer(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 10000 [1e4])
    │   ├─ emit Transfer(from: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], to: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], value: 10000 [1e4])
    │   └─ ← [Return] true
    ├─ [25188] RntERC20::transfer(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], 10000 [1e4])
    │   ├─ emit Transfer(from: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], to: alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], value: 10000 [1e4])
    │   └─ ← [Return] true
    ├─ [0] VM::startPrank(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e])
    │   └─ ← [Return] 
    ├─ [0] VM::deal(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 10000000000000000000 [1e19])
    │   └─ ← [Return] 
    ├─ [1989874] UniswapV2Factory::createPair(RntERC20: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], WETHCoin: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4])
    │   ├─ [1816707] → new UniswapV2Pair@0x50854d49cDEbC876d0c6c47441425c7661b9b0cF
    │   │   └─ ← [Return] 8741 bytes of code
    │   ├─ [44900] UniswapV2Pair::initialize(RntERC20: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], WETHCoin: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4])
    │   │   └─ ← [Stop] 
    │   ├─ emit PairCreated(token0: RntERC20: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], token1: WETHCoin: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4], pair: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], : 1)
    │   └─ ← [Return] UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]
    ├─ [24739] RntERC20::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 10000 [1e4])
    │   ├─ emit Approval(owner: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 10000 [1e4])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [24523] WETHCoin::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 10000000000000000000 [1e19])
    │   ├─ emit Approval(owner: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 10000000000000000000 [1e19])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [229289] MyDex::addLiquidityETH{value: 10000000000000000000}(RntERC20: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], 10000 [1e4], 8000, 10000000000000000000 [1e19], bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 3601)
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [2526] UniswapV2Pair::getReserves() [staticcall]
    │   │   └─ ← [Return] 0, 0, 0
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [26062] RntERC20::transferFrom(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 10000 [1e4])
    │   │   ├─ emit Transfer(from: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 10000 [1e4])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ [23914] WETHCoin::deposit{value: 10000000000000000000}()
    │   │   ├─ emit Deposit(user: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount: 10000000000000000000 [1e19])
    │   │   └─ ← [Stop] 
    │   ├─ [25338] WETHCoin::transfer(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 10000000000000000000 [1e19])
    │   │   ├─ emit Transfer(from: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 10000000000000000000 [1e19])
    │   │   └─ ← [Return] true
    │   ├─ [135158] UniswapV2Pair::mint(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e])
    │   │   ├─ [562] RntERC20::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 10000 [1e4]
    │   │   ├─ [541] WETHCoin::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 10000000000000000000 [1e19]
    │   │   ├─ [2327] UniswapV2Factory::feeTo() [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000
    │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: 0x0000000000000000000000000000000000000000, value: 1000)
    │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], value: 316227765016 [3.162e11])
    │   │   ├─ emit Sync(reserve0: 10000 [1e4], reserve1: 10000000000000000000 [1e19])
    │   │   ├─ emit Mint(sender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount0: 10000 [1e4], amount1: 10000000000000000000 [1e19])
    │   │   └─ ← [Return] 316227765016 [3.162e11]
    │   └─ ← [Return] 10000 [1e4], 10000000000000000000 [1e19], 316227765016 [3.162e11]
    ├─ [0] console::log("boobbb") [staticcall]
    │   └─ ← [Stop] 
    ├─ [562] RntERC20::balanceOf(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] console::log(0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6])
    │   └─ ← [Return] 
    ├─ [24739] RntERC20::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 1000)
    │   ├─ emit Approval(owner: alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 1000)
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [74105] MyDex::swapExactTokensForTokens(1000, 906610893880149131 [9.066e17], [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395, 0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4], alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], 3601)
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [526] UniswapV2Pair::getReserves() [staticcall]
    │   │   └─ ← [Return] 10000 [1e4], 10000000000000000000 [1e19], 1
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [4162] RntERC20::transferFrom(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 1000)
    │   │   ├─ emit Transfer(from: alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 1000)
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [57355] UniswapV2Pair::swap(0, 906610893880149131 [9.066e17], alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], 0x)
    │   │   ├─ [25338] WETHCoin::transfer(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], 906610893880149131 [9.066e17])
    │   │   │   ├─ emit Transfer(from: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], to: alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], value: 906610893880149131 [9.066e17])
    │   │   │   └─ ← [Return] true
    │   │   ├─ [562] RntERC20::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 11000 [1.1e4]
    │   │   ├─ [541] WETHCoin::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 9093389106119850869 [9.093e18]
    │   │   ├─ emit Sync(reserve0: 11000 [1.1e4], reserve1: 9093389106119850869 [9.093e18])
    │   │   ├─ emit Swap(sender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount0In: 1000, amount1In: 0, amount0Out: 0, amount1Out: 906610893880149131 [9.066e17], to: alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6])
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] [1000, 906610893880149131 [9.066e17]]
    ├─ [0] console::log(2) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1]
    ├─ [0] VM::label(lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], "lucy")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], 1000000000000000000 [1e18])
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1])
    │   └─ ← [Return] 
    ├─ [24523] WETHCoin::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 1000000000000000000 [1e18])
    │   ├─ emit Approval(owner: lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [101472] MyDex::swapExactETHForTokens{value: 1000000000000000000}(906, [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4, 0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], 3601)
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [526] UniswapV2Pair::getReserves() [staticcall]
    │   │   └─ ← [Return] 11000 [1.1e4], 9093389106119850869 [9.093e18], 1
    │   ├─ [0] console::log(1086) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [21914] WETHCoin::deposit{value: 1000000000000000000}()
    │   │   ├─ emit Deposit(user: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount: 1000000000000000000 [1e18])
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [3438] WETHCoin::transfer(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 1000000000000000000 [1e18])
    │   │   ├─ emit Transfer(from: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Return] true
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [57205] UniswapV2Pair::swap(1086, 0, lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], 0x)
    │   │   ├─ [25188] RntERC20::transfer(lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], 1086)
    │   │   │   ├─ emit Transfer(from: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], to: lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], value: 1086)
    │   │   │   └─ ← [Return] true
    │   │   ├─ [562] RntERC20::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 9914
    │   │   ├─ [541] WETHCoin::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 10093389106119850869 [1.009e19]
    │   │   ├─ emit Sync(reserve0: 9914, reserve1: 10093389106119850869 [1.009e19])
    │   │   ├─ emit Swap(sender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount0In: 0, amount1In: 1000000000000000000 [1e18], amount0Out: 1086, amount1Out: 0, to: lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1])
    │   │   └─ ← [Stop] 
    │   └─ ← [Return] [1000000000000000000 [1e18], 1086]
    ├─ [0] console::log(2) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 2 passed; 0 failed; 0 skipped; finished in 3.03ms (2.27ms CPU time)
```

```MyDex2.t.sol
[2480970] MyDex2Test::test_trade_usdt()
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e]
    ├─ [0] VM::label(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], "bob")
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6]
    ├─ [0] VM::label(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], "alice")
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF])
    │   └─ ← [Return] 
    ├─ [29988] TetherERC20::transfer(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 30000 [3e4])
    │   ├─ emit Transfer(from: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], to: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], value: 30000 [3e4])
    │   └─ ← [Return] true
    ├─ [25188] TetherERC20::transfer(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], 30000 [3e4])
    │   ├─ emit Transfer(from: admin: [0xaA10a84CE7d9AE517a52c6d5cA153b369Af99ecF], to: alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], value: 30000 [3e4])
    │   └─ ← [Return] true
    ├─ [0] VM::startPrank(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e])
    │   └─ ← [Return] 
    ├─ [0] VM::deal(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 10000000000000000000 [1e19])
    │   └─ ← [Return] 
    ├─ [1989884] UniswapV2Factory::createPair(TetherERC20: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4], WETHCoin: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395])
    │   ├─ [1816707] → new UniswapV2Pair@0x50854d49cDEbC876d0c6c47441425c7661b9b0cF
    │   │   └─ ← [Return] 8741 bytes of code
    │   ├─ [44900] UniswapV2Pair::initialize(WETHCoin: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], TetherERC20: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4])
    │   │   └─ ← [Stop] 
    │   ├─ emit PairCreated(token0: WETHCoin: [0x3Ede3eCa2a72B3aeCC820E955B36f38437D01395], token1: TetherERC20: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4], pair: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], : 1)
    │   └─ ← [Return] UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]
    ├─ [24739] TetherERC20::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 30000 [3e4])
    │   ├─ emit Approval(owner: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 30000 [3e4])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [24523] WETHCoin::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 10000000000000000000 [1e19])
    │   ├─ emit Approval(owner: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 10000000000000000000 [1e19])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [229329] MyDex::addLiquidityETH{value: 10000000000000000000}(TetherERC20: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4], 30000 [3e4], 25000 [2.5e4], 10000000000000000000 [1e19], bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], 3601)
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [2526] UniswapV2Pair::getReserves() [staticcall]
    │   │   └─ ← [Return] 0, 0, 0
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [26062] TetherERC20::transferFrom(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 30000 [3e4])
    │   │   ├─ emit Transfer(from: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 30000 [3e4])
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ [23914] WETHCoin::deposit{value: 10000000000000000000}()
    │   │   ├─ emit Deposit(user: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount: 10000000000000000000 [1e19])
    │   │   └─ ← [Stop] 
    │   ├─ [25338] WETHCoin::transfer(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 10000000000000000000 [1e19])
    │   │   ├─ emit Transfer(from: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 10000000000000000000 [1e19])
    │   │   └─ ← [Return] true
    │   ├─ [135158] UniswapV2Pair::mint(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e])
    │   │   ├─ [541] WETHCoin::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 10000000000000000000 [1e19]
    │   │   ├─ [562] TetherERC20::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 30000 [3e4]
    │   │   ├─ [2327] UniswapV2Factory::feeTo() [staticcall]
    │   │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000
    │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: 0x0000000000000000000000000000000000000000, value: 1000)
    │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e], value: 547722556505 [5.477e11])
    │   │   ├─ emit Sync(reserve0: 10000000000000000000 [1e19], reserve1: 30000 [3e4])
    │   │   ├─ emit Mint(sender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount0: 10000000000000000000 [1e19], amount1: 30000 [3e4])
    │   │   └─ ← [Return] 547722556505 [5.477e11]
    │   └─ ← [Return] 30000 [3e4], 10000000000000000000 [1e19], 547722556505 [5.477e11]
    ├─ [0] console::log("boobbb") [staticcall]
    │   └─ ← [Stop] 
    ├─ [562] TetherERC20::balanceOf(bob: [0x1D96F2f6BeF1202E4Ce1Ff6Dad0c2CB002861d3e]) [staticcall]
    │   └─ ← [Return] 0
    ├─ [0] console::log(0) [staticcall]
    │   └─ ← [Stop] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6])
    │   └─ ← [Return] 
    ├─ [24739] TetherERC20::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 4000)
    │   ├─ emit Approval(owner: alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 4000)
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [114346] MyDex::buyETH(TetherERC20: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4], 4000, 1000000000000000000 [1e18])
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [526] UniswapV2Pair::getReserves() [staticcall]
    │   │   └─ ← [Return] 10000000000000000000 [1e19], 30000 [3e4], 1
    │   ├─ [0] console::log(3344) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(1000000000000000000 [1e18]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [4162] TetherERC20::transferFrom(alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 3344)
    │   │   ├─ emit Transfer(from: alice: [0x328809Bc894f92807417D2dAD6b7C998c1aFdac6], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 3344)
    │   │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [55355] UniswapV2Pair::swap(1000000000000000000 [1e18], 0, MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 0x)
    │   │   ├─ [23338] WETHCoin::transfer(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 1000000000000000000 [1e18])
    │   │   │   ├─ emit Transfer(from: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], to: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 1000000000000000000 [1e18])
    │   │   │   └─ ← [Return] true
    │   │   ├─ [541] WETHCoin::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 9000000000000000000 [9e18]
    │   │   ├─ [562] TetherERC20::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 33344 [3.334e4]
    │   │   ├─ emit Sync(reserve0: 9000000000000000000 [9e18], reserve1: 33344 [3.334e4])
    │   │   ├─ emit Swap(sender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount0In: 0, amount1In: 3344, amount0Out: 1000000000000000000 [1e18], amount1Out: 0, to: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832])
    │   │   └─ ← [Stop] 
    │   ├─ [9592] WETHCoin::withdraw(1000000000000000000 [1e18])
    │   │   ├─ [95] MyDex::receive{value: 1000000000000000000}()
    │   │   │   └─ ← [Stop] 
    │   │   ├─ emit Withdrawal(src: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], wad: 1000000000000000000 [1e18], flag: true)
    │   │   └─ ← [Stop] 
    │   ├─ [0] alice::fallback{value: 1000000000000000000}()
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    ├─ [0] VM::addr(<pk>) [staticcall]
    │   └─ ← [Return] lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1]
    ├─ [0] VM::label(lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], "lucy")
    │   └─ ← [Return] 
    ├─ [0] VM::deal(lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], 1000000000000000000 [1e18])
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1])
    │   └─ ← [Return] 
    ├─ [24523] WETHCoin::approve(MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], 1000000000000000000 [1e18])
    │   ├─ emit Approval(owner: lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], spender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], value: 1000000000000000000 [1e18])
    │   └─ ← [Return] 0x0000000000000000000000000000000000000000000000000000000000000001
    ├─ [100141] MyDex::sellETH{value: 1000000000000000000}(TetherERC20: [0x6D9da78B6A5BEdcA287AA5d49613bA36b90c15C4], 1000)
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [526] UniswapV2Pair::getReserves() [staticcall]
    │   │   └─ ← [Return] 9000000000000000000 [9e18], 33344 [3.334e4], 1
    │   ├─ [0] console::log(3325) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [21914] WETHCoin::deposit{value: 1000000000000000000}()
    │   │   ├─ emit Deposit(user: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount: 1000000000000000000 [1e18])
    │   │   └─ ← [Stop] 
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [3438] WETHCoin::transfer(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], 1000000000000000000 [1e18])
    │   │   ├─ emit Transfer(from: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], to: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], value: 1000000000000000000 [1e18])
    │   │   └─ ← [Return] true
    │   ├─ [0] console::log(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   └─ ← [Stop] 
    │   ├─ [57205] UniswapV2Pair::swap(0, 3325, lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], 0x)
    │   │   ├─ [25188] TetherERC20::transfer(lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], 3325)
    │   │   │   ├─ emit Transfer(from: UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF], to: lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1], value: 3325)
    │   │   │   └─ ← [Return] true
    │   │   ├─ [541] WETHCoin::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 10000000000000000000 [1e19]
    │   │   ├─ [562] TetherERC20::balanceOf(UniswapV2Pair: [0x50854d49cDEbC876d0c6c47441425c7661b9b0cF]) [staticcall]
    │   │   │   └─ ← [Return] 30019 [3.001e4]
    │   │   ├─ emit Sync(reserve0: 10000000000000000000 [1e19], reserve1: 30019 [3.001e4])
    │   │   ├─ emit Swap(sender: MyDex: [0x32850cAd1e9170614704fF8BA37a25e498e1B832], amount0In: 1000000000000000000 [1e18], amount1In: 0, amount0Out: 0, amount1Out: 3325, to: lucy: [0x7290f6cfDFD03d6aD66Dd0eb2d38303714635aD1])
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 2.82ms (1.50ms CPU time)
```
