package com.macrochallenge.backend.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("api/v1/applications")
@RestController
public class SchoolController {

    @PostMapping("/{id}/error-submission")
    public ResponseEntity<Object> addNewError(@PathVariable Integer id, @RequestBody ErrorDTO errorDTO) {


        return new ResponseEntity<>("Escola adicionada com sucesso", HttpStatus.OK);
    }
}
