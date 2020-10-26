package com.macrochallenge.backend.model.dto;

import lombok.Data;
import lombok.NonNull;

@Data
public class ResultsDTO {
    @NonNull
    private String testName;

    @NonNull
    private String testYear;

    @NonNull
    private Double totalPercentageOfCorrectAnswers;

    @NonNull
    private Integer totalNumberOfQuestions;

    @NonNull
    private Integer totalNumberOfCorrectAnswers;

    @NonNull
    private String rightAnswer;

    @NonNull
    private String wrongAnswer;
}
