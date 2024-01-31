#!/bin/bash
javac src/App.java -d lib      
mkdir $1 
mkdir $1/bin
mkdir $1/lib
mkdir $1/src
printf"
public class Aap{
	public static void (String[] args){
	System.out.println(\"hola mundo!\");
	}
}">>$1/src/App.java
"
