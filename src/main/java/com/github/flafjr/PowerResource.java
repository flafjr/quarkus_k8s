package com.github.flafjr;

import java.util.List;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/power")
public class PowerResource {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<DevicePower> hello() {
        return DevicePower.listAll();
    }
}
