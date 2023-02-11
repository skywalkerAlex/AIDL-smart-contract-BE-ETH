const main=async () => {
    const [deployer]=await hre.ethers.getSigners();
    const accountBalance=await deployer.getBalance();

    console.log("Deploying contracts with account: ", deployer.address);
    console.log("Account balance: ", accountBalance.toString());

    const datasetContractFactory=await hre.ethers.getContractFactory("DataSetPortal");
    const datasetContract=await datasetContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.001"),
    });
    await datasetContract.deployed();

    console.log("DataSetPortal address: ", datasetContract.address);
};

const runMain=async () => {
    try {
        await main();
        process.exit(0);
    } catch(error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();