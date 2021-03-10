### 214A_Project_W2021

This ReadMe file contains the primary info needed to run and understand the
contents of the classifier. 

Project By:
Sunay Bhat - sunaybhat1@ucla.edu
Pong Chan - pongchan222@gmail.com

### Running Code

# Testing Code
In order to run the code, simply pass in a text file path/name with the pair of 
audio files to classify. 

testList = 'testCleanList.txt';
prediction = speakerVerifyClassifier(testList);

Files should be off the same structure as provided
in training for the project:

WavData\Clean\063A_0_HS05_06.wav WavData\Clean\063B_0_HS05_05.wav 1
WavData\Clean\063A_0_HS05_06.wav WavData\Clean\063B_0_HS05_08.wav 1
WavData\Clean\063A_0_HS05_06.wav WavData\Clean\063C_0_HS05_03.wav 1
WavData\Clean\063A_0_HS05_06.wav WavData\Clean\063C_0_HS05_08.wav 1
WavData\Clean\063A_0_HS05_06.wav WavData\Clean\069A_0_HS05_03.wav 0
.
.
.

Note labels are not needed or used for testing purposes.The function will
output a prediction vector which contains the binary classification of the
pairs with a 1 corresponding to a match. 

# Training
Optionally, a second input will be accepted for addiotnla training. This was
included primarily to allow grading of our training code and to test final
code architecture. Note the function switches between loading the previosuly
trained parameters or training again if file is provided. Default parameters
are trained on the 'multi' dataset provided in the project files with no 
augmentation.

### File Info

# Top Directory
There are 4 functions in the top directory that contain the final package:
    speakerVerifyClassifier - Function that determines if training is to be 
        done (and class trainclassifier is so), loads in model parameters 
        otherwise and calls testClassifier
    trainClassifier - Function to train classifier from provided train list
        in textfile. Calls extractFeatures on a per file basis. Outputs 
        threshold variable for testing.  
    testClassifier - Runs classifier on new test data from text file and outputs
        predictions in a binary vector. Calls extractFeatures on a per file basis.
    extractFeatures - Extract a matrix of 14 MFCC's along with an F0 vector.
        Calls isVoicedSpeech.
    isVoicedSpeech - Function to determine voiced section of speech, sourced
        from Matlab page linked in file.
    Example - Example script to show hoe to run code for testing. Files and
        data being pointed too not in zip (was provided for project)

# Folders
    Archive Code - Archive of uncommented and unsed code. much of it is
        uninformative, but the 'QuickCheck" files and "details" files contain
        failed or unused methods and scripts for genertaing analysis and
        presentation data/plots.

#### Additonal Info

# ToolBoxes Used:
audio_system_toolbox
matlab
signal_blocks
signal_toolbox
statistics_toolbox

