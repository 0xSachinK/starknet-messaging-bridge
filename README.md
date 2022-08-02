# StarkNet messaging bridge

Solutions to [Starknet messaging bridge](https://github.com/0xSachinK/starknet-messaging-bridge) exercises.

### Exercises & Contract addresses

| Contract code                                                                                                                    | Contract on voyager                                                                                                                                                           |
| -------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [L2 Evaluator](contracts/Evaluator.cairo)                                                                                        | [0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99](https://goerli.voyager.online/contract/0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99) |
| [Points counter ERC20](contracts/token/ERC20/TDERC20.cairo)                                                                      | [0x38ec18163a6923a96870f3d2b948a140df89d30120afdf90270b02c609f8a88](https://goerli.voyager.online/contract/0x38ec18163a6923a96870f3d2b948a140df89d30120afdf90270b02c609f8a88) |
| [L2 Dummy NFT](contracts/l2nft.cairo)                                                                                            | [0x6cc3df14b8b3e8c05ad19c74f373e110bba0380b2799bcd9f717d31d2757625](https://goerli.voyager.online/contract/0x6cc3df14b8b3e8c05ad19c74f373e110bba0380b2799bcd9f717d31d2757625) |
| [L1 Evaluator](contracts/L1/Evaluator.sol)                                                                                       | [0x8055d587A447AE186d1589F7AAaF90CaCCc30179](https://goerli.etherscan.io/address/0x8055d587A447AE186d1589F7AAaF90CaCCc30179)                                                  |
| [L1 Dummy token](contracts/L1/DummyToken.sol)                                                                                    | [0x0232CB90523F181Ab4990Eb078Cf890F065eC395](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395)                                                  |
| [L1 Messaging NFT](contracts/L1/MessagingNft.sol)                                                                                | [0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E](https://goerli.etherscan.io/address/0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E)                                                  |
| [StarkNet Core Contract Proxy](https://goerli.etherscan.io/address/0xde29d060d45901fb19ed6c6e959eb22d8626708e#readContract)      | [0xde29d060D45901Fb19ED6C6e959EB22d8626708e](https://goerli.etherscan.io/address/0xde29d060d45901fb19ed6c6e959eb22d8626708e)                                                  |
| [Goerli Faucet (0.1 ETH / 2 hours)](https://goerli.etherscan.io/address/0x25864095d3eB9F7194C1ccbb01871c9b1bd5787a#readContract) | [0x25864095d3eB9F7194C1ccbb01871c9b1bd5787a](https://goerli.etherscan.io/address/0x25864095d3eB9F7194C1ccbb01871c9b1bd5787a#writeContract)                                    |

## Tasks list

### Exercise 0 - Send an L2→L1→L2 message with existing contracts (2 pts)

Use a predeployed contract to mint ERC20 tokens on L1 from L2. A secret message is passed with the messages; be sure to find it in order to collect your points.

- Call function [`ex_0_a`](contracts/Evaluator.cairo#L121) of [*L2 Evaluator*](https://goerli.voyager.online/contract/0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99)
  - You need to specify an L1 address, and an amount of ERC20 to mint
  - The secret message is sent from L2 to L1 at this stage.
- Call [`mint`](contracts/L1/DummyToken.sol#L37) of [*L1 DummyToken*](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395)
  - You need to show that you know the secret value at this step
- Call [`i_have_tokens`](contracts/L1/DummyToken.sol#L48) of [*L1 DummyToken*](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395)
  - This function checks that you have indeed been able to mint ERC20 tokens, and will then send a message back to L2 to credit your points
  - This is done using [`ex_0_b`](contracts/Evaluator.cairo#L143) of the L2 evaluator

### Exercise 1 - Send an L2→L1 message with your contract (2 pts)

Write and deploy a contract on L2 that *sends* messages to L1.

- Write a contract on L2 that will send a message to [L1 MessagingNft](https://goerli.etherscan.io/address/0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E) and trigger [`createNftFromL2`](contracts/L1/MessagingNft.sol#L35)
  - Your function should be called [`create_l1_nft_message`](contracts/Evaluator.cairo#L198)
- Deploy your contract
- Submit the contract address to L2 Evaluator by calling its [`submit_exercise`](contracts/Evaluator.cairo#L166)
- Call [`ex1a`](contracts/Evaluator.cairo#L188) of L2 Evaluator to trigger the message sending to L2
- Call [`createNftFromL2`](contracts/L1/MessagingNft.sol#L35) of L1 MessagingNft to trigger the message consumption on L1
  - L1 MessagingNft [sends back](contracts/L1/MessagingNft.sol#L47) a message to L2 to [credit your points](contracts/Evaluator.cairo#L205) on L2

### Exercise 2 - Send an L1→L2 message with your contract (2 pts)

Write and deploy a contract on L1 that *sends* messages to L2.

- Write a contract on L1 that will send a message to L2 Evaluator and trigger [`ex2`](contracts/Evaluator.cairo#L221)
  - You can check how L1 MessagingNft [sends](contracts/L1/MessagingNft.sol#L47) a message to L2 to get some ideas
  - You can get latest address of the StarkNet Core Contract Proxy on Goerli by running `starknet get_contract_addresses --network alpha-goerli` in your CLI
  - Learn how to get the [selector](https://starknet.io/docs/hello_starknet/l1l2.html#receiving-a-message-from-l1) of a StarkNet contract function
- Deploy your contract
- Trigger the message sending on L1. Your  points are automatically attributed on L2.

### Exercise 3 - Receive an L2→L1 message with your contract (2 pts)

- Write a contract on L1 that will receive a message from  from function [`ex3_a`](contracts/Evaluator.cairo#L231).
  - Make sure your contract is able to handle the message.
  - Your message consumption function should be called [`consumeMessage`](contracts/L1/Evaluator.sol#L51)
- Deploy your L1 contract
- Register your exercise on [*L1 Evaluator*](https://goerli.etherscan.io/address/0x8055d587A447AE186d1589F7AAaF90CaCCc30179)
- Call [`ex3_a`](contracts/Evaluator.cairo#L231) of [*L2 Evaluator*](https://goerli.voyager.online/contract/0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99) to send an L2→L1 message
- Call [`ex3`](contracts/L1/Evaluator.sol#L32)of *L1 Evaluator*, which triggers message consumption from your L1 contract
  - L1 evaluator will also [send back](contracts/L1/Evaluator.sol#L57) a message to L2 to distribute your points

### Exercise 4 - Receive an L1→L2 message with your contract (2 pts)

- Write a L2 contract that is able to receive a message from [`ex4`](contracts/L1/Evaluator.sol#L60) of [*L1 Evaluator*](https://goerli.etherscan.io/address/0x8055d587A447AE186d1589F7AAaF90CaCCc30179)
  - You can name your function however you like, since you provide the function selector as a parameter on L1
- Deploy your contract on L2
- Call [`ex4`](contracts/L1/Evaluator.sol#L60) of *L1 Evaluator* to send the random value out to your L2 contract
- Call [`ex4_b`](contracts/Evaluator.cairo#L266) of *L2 Evaluator* that will check you completed your work correctly and distribute your points

## Solutions

### Solutions & Contract addresses


| Contract code                                                                                                                    | Contract on voyager                                                                                                                                                           |
| -------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [L2 Evaluator](contracts/Evaluator.cairo)                                                                                        | [0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99](https://goerli.voyager.online/contract/0x595bfeb84a5f95de3471fc66929710e92c12cce2b652cd91a6fef4c5c09cd99) |
| [Points counter ERC20](contracts/token/ERC20/TDERC20.cairo)                                                                      | [0x38ec18163a6923a96870f3d2b948a140df89d30120afdf90270b02c609f8a88](https://goerli.voyager.online/contract/0x38ec18163a6923a96870f3d2b948a140df89d30120afdf90270b02c609f8a88) |
| [L2 Dummy NFT](contracts/l2nft.cairo)                                                                                            | [0x6cc3df14b8b3e8c05ad19c74f373e110bba0380b2799bcd9f717d31d2757625](https://goerli.voyager.online/contract/0x6cc3df14b8b3e8c05ad19c74f373e110bba0380b2799bcd9f717d31d2757625) |
| [L1 Evaluator](contracts/L1/Evaluator.sol)                                                                                       | [0x8055d587A447AE186d1589F7AAaF90CaCCc30179](https://goerli.etherscan.io/address/0x8055d587A447AE186d1589F7AAaF90CaCCc30179)                                                  |
| [L1 Dummy token](contracts/L1/DummyToken.sol)                                                                                    | [0x0232CB90523F181Ab4990Eb078Cf890F065eC395](https://goerli.etherscan.io/address/0x0232CB90523F181Ab4990Eb078Cf890F065eC395)                                                  |
| [L1 Messaging NFT](contracts/L1/MessagingNft.sol)                                                                                | [0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E](https://goerli.etherscan.io/address/0x6DD77805FD35c91EF6b2624Ba538Ed920b8d0b4E)                                                  |
| [StarkNet Core Contract Proxy](https://goerli.etherscan.io/address/0xde29d060d45901fb19ed6c6e959eb22d8626708e#readContract)      | [0xde29d060D45901Fb19ED6C6e959EB22d8626708e](https://goerli.etherscan.io/address/0xde29d060d45901fb19ed6c6e959eb22d8626708e)                                                  |
| [Goerli Faucet (0.1 ETH / 2 hours)](https://goerli.etherscan.io/address/0x25864095d3eB9F7194C1ccbb01871c9b1bd5787a#readContract) | [0x25864095d3eB9F7194C1ccbb01871c9b1bd5787a](https://goerli.etherscan.io/address/0x25864095d3eB9F7194C1ccbb01871c9b1bd5787a#writeContract)                                    |
