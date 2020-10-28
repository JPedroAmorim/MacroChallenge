package com.macrochallenge.backend.model.dto;

import lombok.Data;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
public class AccumulatedResultsDTO {
    @NonNull
    private String totalNumberOfQuestions;

    @NonNull
    private String totalNumberOfCorrectAnswers;
}
