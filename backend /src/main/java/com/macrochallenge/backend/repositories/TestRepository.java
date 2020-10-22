package com.macrochallenge.backend.repositories;

import com.macrochallenge.backend.model.Test;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface TestRepository extends JpaRepository<Test, Integer> {
    Optional<Test> findByName(String name);
}
