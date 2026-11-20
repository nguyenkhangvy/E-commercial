package com.unigear.backend.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController

@RequestMapping(value = "/hello")
public class HelloAPI {

    @GetMapping
    public Object hello(){
        return "Test search geanerated by Quangday21";
    }
}
