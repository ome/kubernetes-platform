#!/bin/sh
gsed -re 's%(\s+server:).+%\1 https://ebi-embassy-kubetest.openmicroscopy.org:6443%' \
    ../kubespray/artifacts/admin.conf > \
    ebi-kubetest
#    ~/.kube/ebi-kubetest
