#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# To run this example use
# ./bin/spark-submit examples/src/main/r/ml/mlp.R

# Load SparkR library into your R session
library(SparkR)

# Initialize SparkSession
sparkR.session(appName = "SparkR-ML-mlp-example")

# $example on$
# Load training data
df <- read.df("data/mllib/sample_multiclass_classification_data.txt", source = "libsvm")
training <- df
test <- df

# specify layers for the neural network:
# input layer of size 4 (features), two intermediate of size 5 and 4
# and output of size 3 (classes)
layers = c(4, 5, 4, 3)

# Fit a multi-layer perceptron neural network model with spark.mlp
model <- spark.mlp(training, label ~ features, maxIter = 100,
                   layers = layers, blockSize = 128, seed = 1234)

# Model summary
summary(model)

# Prediction
predictions <- predict(model, test)
showDF(predictions)
# $example off$
