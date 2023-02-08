const main=async () => {
    const [owner, randomPerson]=await hre.ethers.getSigners();
    const datasetContractFactory=await hre.ethers.getContractFactory("DataSetPortal");
    const datasetContract=await datasetContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    });
    await datasetContract.deployed();

    console.log("Contract deployed to:", datasetContract.address);
    console.log("Contract deployed by:", owner.address);

    /*
    * Get Contract balance
    */
    let contractBalance=await hre.ethers.provider.getBalance(
        datasetContract.address
    );
    console.log(
        "Contract balance:",
        hre.ethers.utils.formatEther(contractBalance)
    );

    let totals=await datasetContract.getTotalNumbers();
    console.log("Total Numbers of Dataset: "+totals.numberOfDataset);

    let inputValue1={
        name: "name1",
        size: 15,
        accuracy_score: "0.9",
        data_type: "dataType1",
        file_type: "fileType1",
        models_used: ['model1', 'model2', 'model3'],
        libraries_used: ["library1", "library2", "library3"],
    }

    console.log("inputValue1: "+inputValue1);
    const firstDataset=await datasetContract.upload_dataset_details(
        inputValue1.name,
        inputValue1.size,
        inputValue1.accuracy_score,
        inputValue1.data_type,
        inputValue1.file_type,
        inputValue1.models_used,
        inputValue1.libraries_used,
    );
    await firstDataset.wait(); // Wait for the transaction to be mined

    totals=await datasetContract.getTotalNumbers();
    console.log("Total Numbers of Dataset: "+totals.numberOfDataset);

    /*
    * Get Contract balance to see what happened!
    */
    contractBalance=await hre.ethers.provider.getBalance(datasetContract.address);
    console.log(
        "Contract balance:",
        hre.ethers.utils.formatEther(contractBalance)
    );

    let inputValue2={
        name: "name2",
        data_type: "dataType2",
        accuracy_score: "accuracyScore2",
        file_type: "fileType2",
        size: 32,
        models_used: ["model4", "model5", "model6"],
        libraries_used: ["library4", "library5", "library6"],
    }
    const secondDataset=await datasetContract.connect(randomPerson).upload_dataset_details(
        inputValue2.name,
        inputValue2.size,
        inputValue2.accuracy_score,
        inputValue2.data_type,
        inputValue2.file_type,
        inputValue2.models_used,
        inputValue2.libraries_used,
    );
    await secondDataset.wait();

    totals=await datasetContract.getTotalNumbers();
    console.log("Total Numbers of Dataset: "+totals.numberOfDataset);
    console.log("Total size of Dataset in MB: "+totals.size);

    /*
    * Get Contract balance to see what happened!
    */
    contractBalance=await hre.ethers.provider.getBalance(datasetContract.address);
    console.log(
        "Contract balance:",
        hre.ethers.utils.formatEther(contractBalance)
    );

    let allDatasets=await datasetContract.getAllDatasets();
    console.log("All Datasets: "+allDatasets);
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