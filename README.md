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

### Solution 0

Call ex0a to send message to L1:
https://goerli.voyager.online/tx/0x5829a504dff489a1f7ad7cd7ae2bc1ef479bcb70c0312d64d353c11a42ebcb4

Consume message to mint dummy tokens on L1:
https://goerli.etherscan.io/tx/0x38982c605c8a8f89e72659cbaa0249c30f23129520fe2104effe8db2bc1de187

Prove I have dummy tokens and initiate message back to L2:
https://goerli.etherscan.io/tx/0xf21007ba46cab83b030e01c85dd62cf00aac8afcd0dce7def4e0d25a6b1d8e51

Consume message on L2 and receive point tokens:


### Solution 1

Deploy Exercise 1 solution contract:
🚀 Deploying Exercise1_solution
⏳ ️Deployment of Exercise1_solution successfully sent at 0x06d122a8c3192c87275e6faf7628313b1656fe6219267bb81f5cc633f24e67d0
🧾 Transaction hash: [0x421a372a21fb95ab8bb6a42c655c6e0cb63c21bc765ca980fc37f025a382e78](https://goerli.voyager.online/tx/0x421a372a21fb95ab8bb6a42c655c6e0cb63c21bc765ca980fc37f025a382e78)
📦 Registering [0x06d122a8c3192c87275e6faf7628313b1656fe6219267bb81f5cc633f24e67d0](https://goerli.voyager.online/contract/0x06d122a8c3192c87275e6faf7628313b1656fe6219267bb81f5cc633f24e67d0) in goerli.deployments.txt

Submit solution:
https://goerli.voyager.online/tx/0x58e36937ba59241d79ad875ba9a6d3678c7126bb93f1d1edaeb6310a54aa25b

Send message to L1:
https://goerli.voyager.online/tx/0x3e409c225b82257561dcd4a1347694a8a1d2e38fb975442abe6f2c3f08d6c90

Consume message on L1 to mint NFT and send a message to L2 to mint points:
https://goerli.etherscan.io/tx/0xdc5674f0414e3a7187c9715c867147c2e06bf4c4ded325216d01e918727281aa

Consume message on L2 and receive point tokens:
https://goerli.voyager.online/tx/0xccacffff36905d2904bacbb9473e8992147454587d95e531d8716e02471530#overview

### Solution 2

Write and deploy contract on L1:
https://goerli.etherscan.io/tx/0xab5b56436ba3c5db013f6df98c0e683f14aae67f027ca7bb6af9d2e923d0e7fa

Send message to L2:
https://goerli.etherscan.io/tx/0xd2030032642b99a692e67894407d3c85556403cae4e4bebaa60b403e83669fdc

Consume message on L2 and receive point tokens:
