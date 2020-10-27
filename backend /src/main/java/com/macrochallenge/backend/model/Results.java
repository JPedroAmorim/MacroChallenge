package com.macrochallenge.backend.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
public class Results {
    @Id
    @SequenceGenerator(name = "id", sequenceName = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "id")
    private Integer id;

    @ManyToOne
    private Test test;

    @NonNull
    private Double totalPercentageOfCorrectAnswers;

    @NonNull
    private Integer totalNumberOfQuestions;

    @NonNull
    private Integer totalNumberOfCorrectAnswers;

    @NonNull
    private String rightAnswers;

    @NonNull
    private String wrongAnswers;

    public Results(Test test, Double totalPercentageOfCorrectAnswers, Integer totalNumberOfQuestions,
                   Integer totalNumberOfCorrectAnswers, String rightAnswers, String wrongAnswers) {
        this.test = test;
        this.totalPercentageOfCorrectAnswers = totalPercentageOfCorrectAnswers;
        this.totalNumberOfQuestions = totalNumberOfQuestions;
        this.totalNumberOfCorrectAnswers = totalNumberOfCorrectAnswers;
        this.rightAnswers = rightAnswers;
        this.wrongAnswers = wrongAnswers;
    }
}