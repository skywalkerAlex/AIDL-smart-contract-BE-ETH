// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract DataSetPortal {
    int256 totalDatasets;
    int256 totalSize;

    /*
     * It stores the arguments passed in transaction logs.
     * These logs are stored on blockchain and are accessible
     * using address of the contract till the contract is present on the blockchain.
     * An event generated is not accessible from within contracts,
     * not even the one which have created and emitted them.
     */
    event NewDataset(
        address indexed from,
        uint256 timestamp,
        DatasetObj dataset
    );

    /*
     * A custom datatype where we can customize what we want to hold inside it.
     */
    struct DatasetObj {
        address user_address; // The address of the user.
        string name; // The name the user.
        int256 size; // The size of the dataset in MB.
        string accuracy_score; // The accuracy score of the model.
        string data_type; // The type of the dataset.
        string file_type; // The type of the files on the dataset.
        string[] models_used; // Whitch models are used.
        string[] libraries_used; // Whitch libraries are used in the model.
        uint256 timestamp; // The timestamp when the user upload the dataset.
    }

    /*
     * A custom datatype where we can customize what we want to hold inside it.
     */
    struct Total {
        int256 numberOfDataset; // The number of DataSets.
        int256 size; // The size of the dataset in MB.
    }

    /*
     * I declare a variable datasets that lets me store an array of structs.
     * This is what lets me hold all the datasets anyone ever sends to me!
     */
    DatasetObj[] datasets;

    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user uploaded a dataset in our contract.
     */
    mapping(address => uint256) public lastUploadAt;

    constructor() payable {
        console.log("I AM SMART CONTRACT. POG. And payable.");
        console.log("Yo yo, I am a contract and I am smart\n");
    }

    function upload_dataset_details(
        string memory name,
        int256 size,
        string memory accuracy_score,
        string memory data_type,
        string memory file_type,
        string[] memory models_used,
        string[] memory libraries_used
    ) public {
        /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */
        console.log("upload_dataset_details");
        require(
            lastUploadAt[msg.sender] + 15 seconds < block.timestamp,
            "Must wait 30 seconds before uplaoding again."
        );

        /*
         * Update the current timestamp we have for the user
         */
        lastUploadAt[msg.sender] = block.timestamp;
        DatasetObj memory _datasetInput;
        _datasetInput.name = name;
        _datasetInput.size = size;
        _datasetInput.accuracy_score = accuracy_score;
        _datasetInput.data_type = data_type;
        _datasetInput.file_type = file_type;
        _datasetInput.models_used = models_used;
        _datasetInput.libraries_used = libraries_used;

        console.log("_datasetInput.name : %s", _datasetInput.name);
        console.log(
            "%s sender w/ accuracy score %s",
            msg.sender,
            _datasetInput.accuracy_score
        );

        console.log(
            "models_used.length : %s",
            _datasetInput.models_used.length
        );
        _datasetInput.user_address = msg.sender;
        _datasetInput.timestamp = block.timestamp;
        /*
         * This is where I actually store the dataset data in the array.
         */
        datasets.push(_datasetInput);

        totalDatasets += 1;
        totalSize += _datasetInput.size;
        /*
         * I added some fanciness here, Google it and try to figure out what it is!
         * Let me know what you learn in #general-chill-chat
         */
        emit NewDataset(msg.sender, block.timestamp, _datasetInput);
    }

    /*
     * I added a function getAllDatasets which will return the struct array, datasets, to us.
     * This will make it easy to retrieve the datasets from our website!
     */
    function getAllDatasets() public view returns (DatasetObj[] memory) {
        return datasets;
    }

    function getTotalNumbers() public view returns (Total memory) {
        return Total(totalDatasets, totalSize);
    }
}
