import random 
from pyspark import SparkContext

num_samples = 10000

sc =SparkContext()

def inside(p):
    x, y = random.random(), random.random()
    return x*x + y*y < 1

count = sc.parallelize(range(0, num_samples)) \
             .filter(inside).count()
print("Pi is roughly %f" % (4.0 * count / num_samples))