[TOC]

------

## Flink introduction

1. features

   1. Low latency
   2. High throughput
   3. Accuracy of results and good fault tolerance

2. Flink Stream processing

   1. Apache Flink is a framework and distributed processing engine for stateful computations over unbonded and bouded data streams

   2. Application scenarios of Flink

      ![image-20220717205729478](flink.assets/image-20220717205729478.png)

   3. Traditional data processing structures

      1. On-Line Transaction Processing(OLTP)
      2. On-Line Analysis processing(OLAP)

   4. layered

      1. SQL  |  Top-level language	
      2. Table API  |  Declarative domain-specific language
      3. DataDtream / DataSet API  |  Core API
      4. Stateful flow processing  |  The underlying API