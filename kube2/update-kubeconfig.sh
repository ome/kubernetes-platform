#!/bin/sh
gsed -re 's%(\s+server:).+%\1 https://idr-dev.openmicroscopy.org:6443%' \
    kubespray/artifacts/admin.conf > \
    ebi-kube2
