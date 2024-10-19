package com.github.flafjr;

import org.eclipse.microprofile.reactive.messaging.Incoming;

import io.quarkus.logging.Log;
import jakarta.transaction.Transactional;

public class KafkaResource {
    @Transactional
    @Incoming("power")
    public void consumePower(DevicePower devicePower) {
        Log.info("Update device " + devicePower.device + "");
        DevicePower.persist(devicePower);
    }
}
