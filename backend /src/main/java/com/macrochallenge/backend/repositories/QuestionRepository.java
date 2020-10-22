package com.macrochallenge.backend.repositories;

import com.macrochallenge.backend.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionRepository extends JpaRepository<Question, Integer> {
}
