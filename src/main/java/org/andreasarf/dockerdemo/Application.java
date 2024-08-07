package org.andreasarf.dockerdemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.random.RandomGenerator;
import java.util.random.RandomGeneratorFactory;

@SpringBootApplication
public class Application {

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
		final RandomGenerator randomGenerator = RandomGeneratorFactory.of("L128X128MixRandom").create();
	}

}
