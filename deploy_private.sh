{\rtf1\ansi\ansicpg949\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
\
# --- Private \uc0\u49436 \u48260  \u51221 \u48372  ---\
PRIVATE_HOST="10.10.20.6"          # \uc0\u49892 \u51228  Private \u49436 \u48260  IP\
PRIVATE_USER="root"                 # Private \uc0\u49436 \u48260  \u44228 \u51221 \
PRIVATE_KEY="/root/.ssh/id_rsa"     # Public \uc0\u49436 \u48260 \u50640 \u49436  Private \u49436 \u48260  \u51217 \u49549 \u50857  \u53412 \
\
# --- \uc0\u49892 \u54665  \u54980  \u47196 \u44536  \u45224 \u44592 \u44592  ---\
exec > /root/app/deploy_private.log 2>&1\
echo "Starting deployment to Private server..."\
\
\
eval $(ssh-agent -s)\
ssh-add $PRIVATE_KEY\
\
\
ssh -o StrictHostKeyChecking=no $PRIVATE_USER@$PRIVATE_HOST "mkdir -p /root/app"\
\
\
scp -o StrictHostKeyChecking=no /root/app/*.jar $PRIVATE_USER@$PRIVATE_HOST:/root/app/app.jar\
\
\
ssh -o StrictHostKeyChecking=no $PRIVATE_USER@$PRIVATE_HOST "nohup java -jar /root/app/app.jar > /root/app/app.log 2>&1 &"\
\
ssh -o StrictHostKeyChecking=no $PRIVATE_USER@$PRIVATE_HOST "bash </root/deploy.sh"\
\
ssh-agent -k\
\
echo "Deployment to Private server completed."}