# aidl-smart-contract-rust
Thesis for Master in Artificial Intelligence and Deep Learning - Design and Implementation of a smart contract in a Blockchain Network to evaluate the characteristics of datasets.

## Basic Installation
- WSL: wsl --install
- Curl: sudo apt-get install curl
- NVM: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
- Restart
- NVM: nvm install --lts
- Rust: curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
    - rustup --version
    - rustc --version
    - cargo --version
    - Run Validator: solana-test-validator
- Mocka: npm install -g mocha
- Yarn: npm install -g yarn

# Sample Hardhat Project
This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```

## Solana Installation (To be update)
- Solana latest: sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
    - solana --version
    - solana config set --url localhost
    - solana config get

## Project Initialization
- anchor init aidl-smart-contract-rust --javascript
    - Navigate to project: cd aidl-smart-contract-rust
    - Open your Favourite editor (VSCode): code .
- Generate Local Keypair: solana-keygen new
    - solana address
- Compile, Deploy and Run Tests: anchor test

You are free to uild your amazing Web3 App!!
