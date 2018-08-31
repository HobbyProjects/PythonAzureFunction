import datetime
import azure.functions
from subprocess import check_output

def main(timer: azure.functions.TimerRequest) -> str:
    # process timer event...
    # put the current timestamp into the output queue.

    out = check_output(['custodian','run','--output-dir=.','/home/site/wwwroot/custodian.yml'])
    return f'{datetime.datetime.now().timestamp()}'
