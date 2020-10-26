package com.macrochallenge.backend.service.interfaces;

import com.macrochallenge.backend.model.Question;
import com.macrochallenge.backend.model.dto.TestDTO;

import java.util.List;

public interface TestServiceInterface {
    public List<Question> getTestQuestions(TestDTO testDTO);
}