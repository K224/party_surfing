#!/usr/bin/python3
import subprocess
import sys

if len(sys.argv) == 1:
  subprocess.call(["rm", ".git/hooks/pre-commit"])
  with open(".git/hooks/pre-commit", "w") as starter:
    starter.write("./autotest.py testing\n")
  subprocess.call(["sudo", "chmod", "+x", ".git/hooks/pre-commit"])
elif len(sys.argv) == 2 and sys.argv[1] == "testing":
  readme = open("README.md", "w")
  branch_names = subprocess.check_output(["git", "branch"]).decode("utf-8").split("\n")
  branch_name = "master"
  for name in branch_names:
    if name[0] == '*':
      branch_name = name.split(' ')[1]
      break
  readme.write("[![Build Status](https://travis-ci.org/K224/party_surfing.svg?branch=" + branch_name + ")](https://travis-ci.org/K224/party_surfing)")
  readme.write("[![Coverage Status](https://coveralls.io/repos/K224/party_surfing/badge.svg?branch=" + branch_name + ")](https://coveralls.io/r/K224/party_surfing?branch=" + branch_name + ")")
  readme.write("Для добавления автоматического тестирования при коммите запустите autotest.py\n\n" +
                "ВНИМАНИЕ! Генерация хука для автотеста затрёт существующий!\n\n")
  author_info = subprocess.check_output(["git", "var", "GIT_AUTHOR_IDENT"]).decode("utf-8")
  readme.write("**Информация о последнем протестированном коммите:**\n")
  readme.write("* Автор : " + author_info.split(" ")[0] + "\n")
  readme.write("* Дата : " + subprocess.check_output(["date", "+%H:%M  %d.%m.%y"]).decode("utf-8"))
  test_results = ""
  try:
    test_results = subprocess.check_output(["bundle", "exec", "rake", "test"])
  except subprocess.CalledProcessError as error:
    test_results = error.output
  readme.write("* " + test_results.decode("utf-8").split("\n")[-2] + "\n\n")
  #readme.write("После тестирования выполняется команда 'git add -A', следите за актуальность списка игнорируемых файлов.\n")
  readme.write("\nДля коммита без тестирования используйте параметр --no-verify.")
  readme.close()
  subprocess.call(["git", "add", ":/README.md"])
else:
  print("wrong parameters")
  exit(1)
