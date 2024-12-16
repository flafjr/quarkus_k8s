package com.github.flafjr;

import java.util.List;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.Response.Status;

@Path("/power")
public class PowerResource {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<DevicePower> hello() {
        return DevicePower.listAll();
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response saveDevicePower(DevicePower devicePower) {
        devicePower.persist();
        return Response.status(Status.CREATED).entity(devicePower).build();
    }
}
