package com.macrochallenge.backend.service;

import com.macrochallenge.backend.exceptions.NotFoundException;
import com.macrochallenge.backend.model.Results;
import com.macrochallenge.backend.model.Test;
import com.macrochallenge.backend.model.dto.AccumulatedResultsDTO;
import com.macrochallenge.backend.model.dto.ResultsDTO;
import com.macrochallenge.backend.repositories.ResultsRepository;
import com.macrochallenge.backend.repositories.TestRepository;
import com.macrochallenge.backend.service.interfaces.ResultsServiceInterface;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ResultsService implements ResultsServiceInterface {

    private final TestRepository testRepository;
    private final ResultsRepository resultsRepository;

    @Autowired
    public ResultsService(TestRepository testRepository, ResultsRepository resultsRepository) {
        this.testRepository = testRepository;
        this.resultsRepository = resultsRepository;
    }

    @Override
    public void addNewResult(ResultsDTO resultsDTO) {
        Optional<Test> testForResultOptional = testRepository.findByNameAndYear(resultsDTO.getTestName(),
                resultsDTO.getTestYear());

        if (!testForResultOptional.isPresent()) {
            throw new NotFoundException("Prova não encontrada");
        }

        Test testForResult = testForResultOptional.get();

        Double totalPercentageOfCorrectAnswers = Double.valueOf(resultsDTO.getTotalPercentageOfCorrectAnswers());
        Integer totalNumberOfQuestions = Integer.valueOf(resultsDTO.getTotalNumberOfQuestions());
        Integer totalNumberOfCorrectAnswers = Integer.valueOf(resultsDTO.getTotalNumberOfCorrectAnswers());

        Results resultsEntity = new Results(testForResult, totalPercentageOfCorrectAnswers, totalNumberOfQuestions,
                totalNumberOfCorrectAnswers, resultsDTO.getCorrectAnswers(), resultsDTO.getWrongAnswers());

        resultsRepository.save(resultsEntity);
    }

    @Override
    public AccumulatedResultsDTO getAccumulatedResults() {
        List<Results> allResults = resultsRepository.getAll();

        Integer accumulatedNumberOfQuestions = allResults.stream()
                .mapToInt(Results::getTotalNumberOfQuestions)
                .sum();

        Integer accumulatedNumberOfCorrectAnswers = allResults.stream()
                .mapToInt(Results::getTotalNumberOfCorrectAnswers)
                .sum();

        return new AccumulatedResultsDTO(String.valueOf(accumulatedNumberOfQuestions),
                String.valueOf(accumulatedNumberOfCorrectAnswers));
    }

}
