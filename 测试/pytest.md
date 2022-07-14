[TOC]

------

## Pytest introduction

1. pytest can find functions prefixed or suffixed with "test", But we need add "Test" to the prefixed or suffix of this class

2. pytest can provide unique temporary path by using the "tmpdir" of parameter

   ```python
   def test_needsfiles(tmpdir):
       print(tmpdir)
       assert 0
   ```

### Pytest has 6 possible exit arguments

- 0：all test pass

- 1：Tests have been collected and execute. But some tests failed to execute

- 2：Tests execution are interrupted

- 3：internal error occurred

- 4：The pytest command is used incorrectly

- 5：No tests were collected

- pytest.ExitCode is their enumerated class

  ```python
  pytest --version   # shows where pytest was imported from
  pytest --fixtures  # show available builtin function arguments
  pytest -h | --help # show help on command line and config file options
  pytest -x           # stop after first failure
  pytest --maxfail=2  # stop after two failures
  pytest test_mod.py  # run test in module
  pytest testing/     # run test in path
  ```

- -r show Abstract message of test

  - `f` -失败
  - `E` -误差
  - `s` 跳过
  - `x` -失败
  - `X` -XPASS
  - `p` 通过
  - `P` -通过输出

### Write a report

1. assert used verified expectation
2.  with pytest.raises(parameter): used assert exception of expectation 
   1. as excinfo: can get message of Exception