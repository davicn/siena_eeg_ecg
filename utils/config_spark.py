import os 
from platform import platform


if 'WSL2' in platform():
    user_path = '/mnt/c/Users/davi.nascimento/'
else:
    user_path = '/home/davi/'

os.system("sudo apt-get install openjdk-11-jdk-headless -y -qq > /dev/null")
os.system("wget https://dlcdn.apache.org/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz")
os.system("tar xf spark-3.2.1-bin-hadoop3.2.tgz")

if os.path.exists(f'{user_path}spark-3.2.1-bin-hadoop3.2')== False:
    os.system(f"mv spark-3.2.1-bin-hadoop3.2 {user_path}")

os.system("rm spark-3.2.1-bin-hadoop3.2.tgz")


os.environ["JAVA_HOME"] = "/usr/lib/jvm/java-11-openjdk-amd64"
os.environ["SPARK_HOME"] = f"{user_path}spark-3.2.1-bin-hadoop3.2"