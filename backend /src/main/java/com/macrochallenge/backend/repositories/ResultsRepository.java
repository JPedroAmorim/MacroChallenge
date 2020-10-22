package com.macrochallenge.backend.repositories;

import com.macrochallenge.backend.model.Results;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResultsRepository extends JpaRepository<Results, Integer> {
}
