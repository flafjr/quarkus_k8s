package com.github.flafjr;

import io.quarkus.runtime.annotations.QuarkusMain;
import org.eclipse.microprofile.config.Config;
import org.eclipse.microprofile.config.ConfigProvider;
import io.quarkus.runtime.Quarkus;
@QuarkusMain
public class Main {
    public static void main(String... args) {
        System.out.println("Running main method");
        Config config = ConfigProvider.getConfig();
        System.out.println("Application Properties:");
        config.getPropertyNames()
                .forEach(name -> System.out.println(name + " = " + config.getOptionalValue(name, String.class).orElse("empty")));
        Quarkus.run(args);
    }
}
