package com.macrochallenge.backend.repositories;

import com.macrochallenge.backend.model.School;
import org.springframework.data.jpa.repository.JpaRepository;


public interface SchoolRepository extends JpaRepository<School, Integer> {
   School findOneById(Integer id);
}
