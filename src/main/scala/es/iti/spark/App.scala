package es.iti.spark

/**
 * Example.
 */

import org.apache.spark._
import org.neo4j.spark._
import org.apache.spark.graphx._
import org.apache.spark.graphx.lib._
import org.neo4j.spark.Neo4jPartition
import org.graphframes._

object App {


  def main(args: Array[String]): Unit = {
    println("Neo4!")

    val conf = new SparkConf()
    conf.setMaster("spark://192.168.2.207:7077")
    conf.setAppName("Neo4j")
    conf.set("spark.neo4j.bolt.url", "bolt://192.168.2.207:7687")
    conf.set("spark.neo4j.bolt.user", "neo4j")
    conf.set("spark.neo4j.bolt.password", "123456")

    val sc = SparkContext.getOrCreate(conf)

    // neo4
    println("creando contexto neo4j")

    //val neo = Neo4j(sc)

    val count = sc.parallelize(1 to 100000000).filter { _ =>
      val x = math.random
      val y = math.random
      x*x + y*y < 1
    }.count()
    println(s"Pi is roughly ${4.0 * count / 100000000}")

    sc.stop()

  /*
   println("cargando grafo...")
   val graphQuery = "MATCH (n:Person)-[r:KNOWS]->(m:Person) RETURN id(n) as source, id(m) as target, type(r) as value SKIP {_skip} LIMIT {_limit}"
   val graph: Graph[Long, String] = neo.rels(graphQuery).partitions(7).batch(200).loadGraph
   println(graph.vertices.count)
   println(graph.edges.count)

   println("calculando pagerank...")
   val graph2 = PageRank.run(graph, numIter = 5)
   val v = graph.vertices.take(5)

   println("salvando grafo...")
   neo.saveGraph(graph, "rank")
*/


    /*
    val graphFrame = neo.pattern(("Person","id"),("KNOWS",null), ("Person","id")).partitions(3).rows(1000).loadGraphFrame

    println(graphFrame.vertices.count)
    //     => 100
    println(graphFrame.edges.count)
    //     => 1000

    val pageRankFrame = graphFrame.pageRank.maxIter(5).run()
    val ranked = pageRankFrame.vertices
    ranked.printSchema()

    val top3 = ranked.orderBy(ranked.col("pagerank").desc).take(3)
    println(top3)
    */


  }

}
