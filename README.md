Metastatic Prostate Cancer Subtype Prognosis with Deep Learning 
===================================================

## 1. Metastatic Prostate Cancer

- The second leading cause of cancer deaths among US men
- About 50% of men diagnosed with local prostate cancer will get metastatic cancer during their lifetime 
- Finding cancer early and treating it can lower that rate

![image](https://github.com/sunsetyerin/ANN_metastatic_prostate_cancer/assets/59498491/9244ec4d-c0cd-4bf4-999f-17904bf00cd9)

## 2. Data Source

- Genomic correlates of clinical outcome in advanced prostate cancer
- Abida, W. et al. (2019). Genomic correlates of clinical outcome in advanced prostate cancer. 
Proceedings of the national academy of sciences, 116 (23), s. 11428–11436. doi:10.1073/pnas.1902651116
[paper link](https://pubmed.ncbi.nlm.nih.gov/31061129/)

## 3. Data Description

- Androgen receptor signaling inhibitor (ARSI; abiraterone or enzalutamide)
- RB1 alteration was with poor survival
- RB1, AR, and TP53 alterations were associated with a shorter time on treatment with an ARSI
- RB1, AR, and TP53

<img width="388" alt="image" src="https://github.com/sunsetyerin/ANN_metastatic_prostate_cancer/assets/59498491/7a896d68-35a5-4093-9eb6-377ad0428bf2">

## 4. Gleason Score

Prostate Cancer is classified by the Gleason Score.\
A Prostate Cancer Gleason Score or Grade helps to determine how aggressively the prostate cancer is likely to behave.\
The score will help classify the cancer by grading how quickly it it is likely to grow.\
The score also is a an indicator in how likely it is to spread outside of the prostate gland.

<img width="1167" alt="image" src="https://github.com/sunsetyerin/ANN_metastatic_prostate_cancer/assets/59498491/05d94535-b4a6-49c1-865f-b8ee5344610b">

## 5. Data Structure

<img width="881" alt="image" src="https://github.com/sunsetyerin/ANN_metastatic_prostate_cancer/assets/59498491/56ba98f3-1460-404a-9316-5682021ce9fb">

## 6. Hypothesis

**Prediction of Gleason score by gene RB1, AR, and TP53  alteration information**

<img width="732" alt="image" src="https://github.com/sunsetyerin/ANN_metastatic_prostate_cancer/assets/59498491/b455b04b-6230-4705-aa5a-80e831ed9728">

## 7. Deep Learning Model Structure

- \# Input node = 3 ;\
   Alteration information of each gene, RB1, AR, and TP53  
- \# Output node = 5;\
   Gleason score 5,6,7,8,9 (Multiple Classification)\
   One-hot encoding\
   Output layer activation function = Softmax\

- \# Hidden layer = 10
- \# Hidden layer nodes = 50 
- Hidden layer activation function = Leaky ReLU

## 8. Result

- Result of 10000 iteration 
- Poor prognosis
- Error doesn’t converge to 0 most of the time 

![image](https://github.com/sunsetyerin/ANN_metastatic_prostate_cancer/assets/59498491/5313b4fe-d5f2-4f41-aa75-9c69ff31109b)

## 9. Trouble Shooting 

Potential causes of poor prognosis
1. More training data set
2. Biological phenomenon is complicated
3. Other factors affecting Gleason score
4. Gleason score could be subjective
