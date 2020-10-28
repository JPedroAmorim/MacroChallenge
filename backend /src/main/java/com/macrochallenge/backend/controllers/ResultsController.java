package com.macrochallenge.backend.controllers;

import com.macrochallenge.backend.model.dto.ResultsDTO;
import com.macrochallenge.backend.service.interfaces.ResultsServiceInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("api/v1/results")
@RestController
public class ResultsController {

    private final ResultsServiceInterface resultsService;

    @Autowired
    public ResultsController(ResultsServiceInterface resultsService) {
        this.resultsService = resultsService;
    }

    @PostMapping
    public ResponseEntity<String> addNewResult(@RequestBody ResultsDTO resultsDTO) {
        resultsService.addNewResult(resultsDTO);

        return new ResponseEntity<>("Resultado gravado com sucesso", HttpStatus.OK);
    }
}
