@echo off
SETLOCAL

echo ==========================================================================
echo Installing AWS CLI on Windows.
echo -------------------------------------------------------------------------
echo Please ensure that AWSCLIV2.msi is downloaded in the current directory
start /wait msiexec /i AWSCLIV2.msi /quiet /norestart

echo Verifying AWS CLI installation
aws --version

echo ==========================================================================
echo Configuring AWS CLI
echo -------------------------------------------------------------------------
echo AWS Access Key ID:     AKIAWOYZWBWB6ALP6JDX
echo AWS Secret Access Key: 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
echo Default region name:   us-east-1
echo Default output format:
echo --------------------------------------------------------------------------
aws configure

echo -------------------------------------------------------------------------
echo DATE TIME: %DATE% %TIME%
echo -------------------------------------------------------------------------
echo End
echo ==========================================================================
