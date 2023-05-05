# **Build a CI/CD Pipeline Azure DevOps and GitHub solution using DevOps methods**

### **Overview**

#### This project demonstrates using DevOps methods in action to build a Python Flask ML web application deployed using Git source control, GitHub Actions (build server) for CI (Continuous Integration), Azure Pipelines for CD (Continuous Delivery), pylint, and Locust for automated testing, in an Azure App Services serverless PaaS environment. #### 

### **Project Prerequisites**
- Excel spreadsheet
- Create Trello board free account: [LINK](https://trello.com/)
- Create Azure free account: [LINK](https://azure.microsoft.com/en-us/free/)
- Create GitHub Personal free account: [LINK](https://github.com/join?plan=free&ref_cta=Join%2520for%2520free&ref_loc=cards&ref_page=%2Fpricing&source=pricing-card-free)
- Flask starter code: [LINK](https://github.com/udacity/nd082-Azure-Cloud-DevOps-Starter-Code/tree/master/C2-AgileDevelopmentwithAzure/project/starter_files)
- Locust installation: [LINK](https://docs.locust.io/en/stable/installation.html) (***for this project, will be installed by the Makefile***)

#### Use this project to get an idea of how to build a GitHub repository with scaffolding to perform Continuous Integration and Continuous Delivery. The project uses GitHub Actions with Makefile, requirements.txt files, and application code to perform Continuous Integration and Azure Pipelines to enable Continuous Delivery to Azure App Service to deploy a Machine Learning Microservice API. ####

#### The project uses a pre-trained, sklearn model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, and teacher-to-pupil ratios. Information about the data, which was initially taken from Kaggle, is on [the data source site](https://www.kaggle.com/c/boston-housing). This project serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling. ####

### **Project Plan**

#### It is important to employ an effective project plan and task tracking for a successful deployment. This project uses a Trello board for task tracking and an Excel spreadsheet with an example estimated project plan. The example Excel spreadsheet found [HERE]() shows a quarterly and yearly plan, estimates of the week-by-week deliverables, and estimation of difficulty or time for each task. The Trello board found [HERE](https://trello.com/invite/b/PjJwa5mw/ATTIbcc9fac0f3e968f650ef8c2b5d8fe8efC315C800/udacity-training-ms-azure-devops-project-build-a-ci-cd-pipeline) used for tracking this demo project deployment uses a board-based flow with cards for key tasks, “To Do”, “In Progress”, and “Done” boards. ####

# **Continuous Integration**

### **Set Up Azure Cloud Shell**

#### This step uses the Azure Cloud Shell to set up a cloud-based development structure. A Makefile, tests, and application scaffolding are used for the project structure. The scaffolding code is in the root of the repo, and a copy is stored in the “CIScaffoldingCode” folder in this repo. Once this step is completed, you can test the code locally in the Azure Cloud Shell. This is a local continuous integration step that makes sure the code is in a testable and deployable state. The following diagram illustrates how the Azure Cloud Shell is used to create an empty scaffold of tests, source code, Makefile, and requirements. ####

#### Enter diagram here: ####

### **Create the Cloud-Based Development Environment**

#### To set up an initial project structure in the Azure Cloud Shell environment, first, create a GitHub repository. Next, launch an Azure Cloud Shell environment, create SSH keys, and integrate GitHub repository communication. ####
- If not already signed into your GitHub account, sign in: [GitHub](https://github.com/login)
- Setup an Azure Cloud Shell environment: [LINK](https://learn.microsoft.com/en-us/azure/cloud-shell/quickstart?tabs=azurecli)
    + Be sure to select Bash for your command-line shell environment.

- In the Azure bash shell CLI, create ssh-keys using the following command, copy the Public key to the clipboard, and [add the key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account?platform=windows&tool=webui#:~:text=with%20SSH/-,Adding%20a%20new%20SSH%20key%20to%20your%20GitHub%20account,-In%20this%20article):
   + ***`ssh-keygen -t rsa`***
        
        + #### Note: ***you can display your public key with the following cat command, replacing ~/.ssh/id_rsa.pub with the path and filename of your own public key file if needed:***
            + ***`cat ~/.ssh/id_rsa.pub`***

   ![image](https://user-images.githubusercontent.com/32679444/235663631-27a35e5f-2d12-404f-bf37-9ca90927b3b2.png)

- [Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository) the "***techchefmm-flask-ml-service***" GitHub repo (***For this demo, do not rename the forked repo***).

- In the Azure bash shell CLI, run the following command to clone the "***techchefmm-flask-ml-service***"
 GitHub repo:
    + ***`git clone git@github.com:<TypeYourGitHubUserNameHere>/techchefmm-flask-ml-service.git`***

        + ***`NOTE-1:`*** ***Be SURE to use your GitHub User Name in the repo URL above.***
        + ***`NOTE-2:`*** ***the scaffolding files are already in the repo root directory***

   ![image](https://user-images.githubusercontent.com/32679444/235736181-8234372b-ceac-4e2b-ba51-9842ce3a08cc.png)

### **Project Scaffolding**
- Run a Continuous Integration Local Test
    + In the Azure bash shell CLI, cd to the "***techchefmm-flask-ml-service***" directory.
    + Run the “***commands.sh***” bash script
        + ***`./commands.sh`***

            + ***`NOTE:`*** ***the bash script uses scaffolding files and automates running the following atifacts installation, and local test tasks:***
                + ***`python3 -m venv ~/.techchefmm-flask-ml-service`***
                + ***`source ~/.techchefmm-flask-ml-service/bin/activate`***
                + ***`make install`***
                + ***`az webapp up -n techchefmm-flask-ml-service`***
                + ***`locust -f locustfile.py --headless -t 2s`***
                + ***`./make_predict_azure_app.sh`***
                + ***`deactivate`***
    + Done.
    + The following screenshot shows a successful Continuous Integration local test run.

![image](https://user-images.githubusercontent.com/32679444/235820340-bfc952dd-00e6-4cf0-a086-5e8848dc9625.png)

### **Configure remote CI using GitHub Actions**

#### This step configures GitHub Actions to test the project’s change events in GitHub and uses DevOps best practices to perform Continuous Integration remotely. When code is checked in and committed to the git-based repository, it will to be automatically tested, using configuration files and the GitHub Actions SaaS build service. Pushed changes to GitHub triggers the GitHub Actions container, which in turn runs a series of commands.  This diagram shows how code can be tested automatically by enabling GitHub Actions. ####

Enter diagram here:

- Enable GitHub Actions
    + In your GitHub account, on the "***Repositories***" page, select the "***techchefmm-flask-ml-service***" repo.

    ![image](https://user-images.githubusercontent.com/32679444/236315548-071fe2e6-a0dc-45d5-8c38-55998a7d761e.png)

    + On the "***techchefmm-flask-ml-service***" repo ***Code*** page Click ***Actions***.

    ![image](https://user-images.githubusercontent.com/32679444/236317459-654b52fa-f029-449d-935f-0c2a6d120dbe.png)

    + On the ***Actions*** page, click ***New Workflow***.

    ![image](https://user-images.githubusercontent.com/32679444/236318293-5ecd8abc-d0aa-4096-8bda-12ec42c1791d.png)

    + On the ***Choose a workflow*** page, click the "***set up a workflow yourself***" link.

    ![image](https://user-images.githubusercontent.com/32679444/236321722-7e44125e-d03d-44cf-980d-cf2fbf4fcd70.png)

- On the ***Code*** page, copy/paste the following YAML scaffolding code into the "***Edit new file***" file space to compose the main.yml file, and click the "***Start commit***" button on the upper right-hand side of the page.

name: Python application test with Github Actions

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Set up Python 3.9
      uses: actions/setup-python@v1
      with:
        python-version: 3.9
    - name: Install dependencies
      run: |
        make install
    - name: Lint with pylint
      run: |
        make lint
    - name: Test with pytest
      run: |
        make test

![image](https://user-images.githubusercontent.com/32679444/236326590-cf7a44b3-1d63-4d41-bd5f-a3f3ffa9b588.png)

+ In the ***Commit new file*** dialog box, enter a commit message and click the "***Commit new file***" button.

![image](https://user-images.githubusercontent.com/32679444/236327723-95274d44-2517-4bc3-896e-c2991ef1c303.png)

- Verify Continuous Integration remote tests pass.
    + In the Azure Bash shell CLI, commit a change and push the change to GitHub then verify that both the lint and test steps in the project pass by checking "***Actions***" on GitHub.

- Done

    + The following screenshot shows a successful Continuous Integration local test run.

![image](https://user-images.githubusercontent.com/32679444/236355707-65f32848-2407-4bb3-9fa9-b0236a82cf5f.png)

![image](https://user-images.githubusercontent.com/32679444/236355851-29baa37b-e9cd-43bc-bf50-49e7b93c1815.png)


# **Continuous Delivery on Azure**

#### For the final step, a Azure DevOps and GitHub integration is used to set up Continuous Delivery. This involves setting up an Azure DevOps project, and Azure Pipelines to deploy the [Flask starter code](https://github.com/udacity/nd082-Azure-Cloud-DevOps-Starter-Code/tree/master/C2-AgileDevelopmentwithAzure/project/starter_files) to Azure App Services. ####

#### The following generic MS diagram, illustrates how continuous delivery can deploy a flask application through the use of Azure Pipelines and Azure App service. ####

![image](https://user-images.githubusercontent.com/32679444/236104749-c893a042-525e-4933-b047-9723a67a44c4.png)

- Create an Azure DevOps project and connect to Azure
    + Go to [dev.azure.com](https://dev.azure.com/)
    + Create a New Project with visibity set to "Private"

    ![image](https://user-images.githubusercontent.com/32679444/235901255-90ef93a8-6f35-4921-a6f0-5a8a5c049691.png)
    
    + On the ***New project*** page, select ***`Project settings`*** from the lower left blade.

    ![image](https://user-images.githubusercontent.com/32679444/236162168-ff36aa27-84fa-44fc-88f6-1d9efd337f44.png)

    + On the ***Project Settings*** blade under the Pipelines menu, select ***`Service connections`***.

    ![image](https://user-images.githubusercontent.com/32679444/236163628-5cc0c605-f863-4414-9057-4dfac63100e4.png)

    + On the ***Create your first service connection*** page, click the ***`Create service connection`*** button.

    ![image](https://user-images.githubusercontent.com/32679444/236165238-13ea1f1c-ca73-490c-b82f-ee8c1ecc6d49.png)

    + On the ***New service connection*** dialog box, select ***`Azure Resource Manager`*** and click the ***`Next`*** button.

    ![image](https://user-images.githubusercontent.com/32679444/236167152-0cb993b7-f46a-4887-bd35-2468a10bb039.png)

    + On the ***New Azure service connection*** dialog box, select ***`Service principal (automatic)`***, and click the ***`Next`*** button.
    
    ![image](https://user-images.githubusercontent.com/32679444/236169001-454322ef-8684-46e4-aaf2-60567694e413.png)

    + On the next ***New Azure service connection*** dialog box, under Scope level, select ***`Subscription`***, select the ***`Subcription`*** and ***`Resource Group`*** where the Project's Azure App Service is located, enter a unique ***`Service connection name`***, click the ***`Grant access permissions to all pipelines`*** check box, finally click the ***`Save`*** button.

     ![image](https://user-images.githubusercontent.com/32679444/236172903-98fcc3bd-a1a8-437f-bff4-3a351086b56e.png)

    + On the resulting ***`Service connections`*** page at the top projects path, select the newly create project to return to the ***Welcome to the project!*** page.

    ![image](https://user-images.githubusercontent.com/32679444/236176246-f87df059-c373-4e19-8b4b-bb55c54feff1.png)

    ![image](https://user-images.githubusercontent.com/32679444/236176629-a12cd631-6a03-4cf7-8930-8968df215e5d.png)

- Create a Python-specific pipeline to deploy the Azure App Service using GitHub.

    + On the project's ***Welcome to the project!*** page, select ***`Pipelines`***.

    ![image](https://user-images.githubusercontent.com/32679444/236180795-5015cbda-b694-45f4-803e-69340acffb6a.png)

    + On the ***Creat your first Pipeline*** page, click the ***`Create Pipeline`*** button.

    ![image](https://user-images.githubusercontent.com/32679444/236181461-6b3130a7-de95-4428-b4a1-165bc22e691e.png)

    + On the ***Where is your code?*** page, select ***`GitHub (YAML)`***.

    ![image](https://user-images.githubusercontent.com/32679444/236182318-247833a3-4868-4e4d-bf90-c842db55aac7.png)

    + On the ***Select a repository*** page, select the GitHub repository.

    ![image](https://user-images.githubusercontent.com/32679444/236183144-b086eba9-6cef-4132-bf76-b83ded6758cb.png)

    + On the ***Review your pipeline YAML*** page, confirm the "azureServiceConnectionId:", "Python version:", and other YAML file parameter values are correct for the deployment then click the ***`Save and run`*** button option on the upper right-hand of the page.

    ![image](https://user-images.githubusercontent.com/32679444/236187046-02864fdf-5222-4e1f-97ed-4690235ce5d4.png)

    + On the ***Save and run*** dialog box, enter a commmit message, select ***`Commit directly to the main branch`*** option, and click the ***`Save and run`*** button to lauch the deployment.

    ![image](https://user-images.githubusercontent.com/32679444/236188896-8a429814-4445-491f-8f30-e0c2508ff0cf.png)

    + Once the deploment completes, the navigate to ***Deploy Azure Web Appp*** as shown in the following screenshot to confirm a successful deployment.

    ![image](https://user-images.githubusercontent.com/32679444/236193672-a38d4d00-d88b-40c4-95d1-4996595ae80d.png)

    + Done

- Remember to delete the Azure Resource Group used for the demo to avoid incurring Azure billing cost.  MM

- Thank you for following the demo.  MM


# TechChefMM demo flask machine learning service CI/CD DevOps project. MM

# Project Screenshots:

## Screenshot showing the project cloned into Azure Cloud Shell.
![image](https://user-images.githubusercontent.com/32679444/234542762-180b15b1-ea54-462e-90eb-2512106d984e.png)

## Screenshot showing the passing tests that are displayed after running the make all command from the Makefile.
![image](https://user-images.githubusercontent.com/32679444/234545252-a8128ac7-5d99-44df-a572-e29f88b46fa7.png)

## Screenshot showing passing GitHub Acitons build.
![image](https://user-images.githubusercontent.com/32679444/234260125-d47ff217-a565-4dea-9389-270a5f21ff2b.png)

## GitHub Actions badge.
[![Python application test with Github Actions](https://github.com/MM-MikeM/techchefmm-flask-ml-service/actions/workflows/main.yml/badge.svg)](https://github.com/MM-MikeM/techchefmm-flask-ml-service/actions/workflows/main.yml)

## Prediction run against working deployed Azure Application.
![image](https://user-images.githubusercontent.com/32679444/235363785-5d9ed347-b034-49a8-9e3b-984ed303e041.png)

## Logs inspection from the running application.
![image](https://user-images.githubusercontent.com/32679444/235364349-921d6e0f-1a16-4da8-8d37-d6b9fb05a0e0.png)

## Load test the application using Locust
![image](https://user-images.githubusercontent.com/32679444/235365451-807179f7-f1e2-4d35-9758-6c7c77002225.png)

## Successful deploy of the Azure Web App : techchefmm-flask-ml-service project in Azure Pipelines
![image](https://user-images.githubusercontent.com/32679444/235444955-2981b4af-c2b8-4e21-9790-7c030b8a01ab.png)