#!/usr/bin/python3.3
import subprocess
import sys

if len(sys.argv) == 1:
  subprocess.call(["rm", ".git/hooks/pre-commit"])
  with open(".git/hooks/pre-commit", "w") as starter:
    starter.write("./autotest.py testing\n")
  subprocess.call(["sudo", "chmod", "+x", ".git/hooks/pre-commit"])
elif len(sys.argv) == 2 and sys.argv[1] == "testing":
  readme = open("README.rdoc", "w")
  readme.write("Для добавления автоматического тестирования при коммите запустите autotest.py\n" +
                "ВНИМАНИЕ! Генерация хука для автотеста затрёт существующий!\n")
  author_info = subprocess.check_output(["git", "var", "GIT_AUTHOR_IDENT"]).decode("utf-8")
  readme.write("Information about last tested commit\n")
  readme.write("Author : " + author_info.split(" ")[0] + "\n")
  readme.write(subprocess.check_output(["date", "+%H:%M  %d.%m.%y"]).decode("utf-8"))
  test_results = ""
  try:
    test_results = subprocess.check_output(["bundle", "exec", "rake", "test"])
  except subprocess.CalledProcessError as error:
    test_results = error.output
  readme.write(test_results.decode("utf-8").split("\n")[-2] + "\n")
  readme.write("\nДля коммита без тестирования используйте параметр --no-verify")
  subprocess.call(["git", "add", "-A"])
else:
  print("wrong parameters")
  exit(1)
