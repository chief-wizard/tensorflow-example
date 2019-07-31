#!/bin/bash

preprocess_dataset_eid="$(scripts/new_valohai_execution.sh | grep "Created Valohai execution" | sed -e 's/Created Valohai execution "//' -e 's/"$//')"
scripts/wait_for_valohai_execution.sh "$preprocess_dataset_eid"
scripts/get_execution_outputs.sh "$preprocess_dataset_eid"
