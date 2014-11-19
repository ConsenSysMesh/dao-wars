from subprocess import check_output

def compile_solidity(filename):
    return check_output(["./solc", filename]).split('\n')[-3].split(" ")[-1].strip().decode('hex')
