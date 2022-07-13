[TOC]

------



## Gradle introduce

1.  Gradle supports generating JAR packages
1.  Gradle supports managing dependency
1.  Compared to Maven,XML files are abandoned and Groovy language is used in Gradle

## Idea use Gradle

1. File structure
   1. src/main/java Placing production code
   2. src/test/java Placing test code
   3. src/main/resouces Placing production configuration file
   4. src/test/resources Placing test configuration file
   5. src/main/webapp Placing page elements
2. Groovy console

## Groovy syntax

1. First program

   ```groovy
   println("hello world!")
   ```

2. Groovy can omit the trailing ";"

3. Groovy can omit "()"

4. Define variables

   1. "def" defines weakly typed variables

      ```groovy
      def i=18
      ```

   2. Define list

      ```groovy
      def list=['a','b']
      list << 'c'
      println list.get(2)
      ```

   3. Define map

      ```groovy
      def map=['key1':'value1','key2':'value2']
      map.key3='value3'
      println map.get('key3')
      ```

5. Closures in Groovy

   1. Simple Closure

      ```groovy
      def a = {
          println "This is the closures!"
      }
      def method(Closure closure){
          closure()
      }
      method(a)
      ```

   2. Closure with parameters

      ```groovy
      def b = {
          v -> println "hello ${v}"
      }
      def method2(Closure closure){
          closure("xiao ming")
      }
      method2(b)
      ```

      