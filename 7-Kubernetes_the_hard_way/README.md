# Section 7: Training Setup

Now that you are about to embark on the journey to build a working K8s cluster the hard way; you have some options here to consider.

You will find a .zip file that has a copy of Kelsey Hightower's tutorial that you can unzip and utilize for this section.  Please don't `git clone` Kelsey's repo directly into your working folder in your own course repo you forked.  Once unpacked, all of the commands and code needed to do the tutorial will be there but the infrastructure and services used are on Google Cloud.  Google offers $400 in free credit for 90 days when you sign-up and the cost per day if you keep the infra stood up on Google is about $5.00 per day.  This is probably the easiest route for completing the tutorial as the commands are all tuned to using the gcloud CLI.  You may wish to use another Cloud provider or your own virtual infrastructure.  Kelsey's tutorial used to have AWS CLI commands to match the gcloud commands; but that was removed a few years ago.  

If you wish to use AWS, there is a zipped folder containing the AWS CLI commands you would need (from https://github.com/slawekzachcial/kubernetes-the-hard-way-aws) to setup the base compute and network infrastructure. Again don't directly clone this repo into your working folder.  One thing to note is that there are no VPC allocations available in the CS AWS account for Sonatype and therefore if you have that situation you will have to modify the tutorial to use the default VPC or look into using the Global Internal Network (GIN) - https://docs.sonatype.com/pages/viewpage.action?pageId=164928165.

## Step 1: Unzip the file(s) you will use for the tutorial
- `unzip 'kubernetes-the-hard-way*.zip'` if you want to unzip both files in one command

## Step 2: Follow the steps highlighted in the tutorial
- please make sure you monitor your spend either in the Sonatype AWS account or the Cloud service you use on your own dime!