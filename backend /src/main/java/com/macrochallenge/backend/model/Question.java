package com.macrochallenge.backend.model;


import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import org.springframework.lang.Nullable;

import javax.persistence.*;

@Entity
@Data
@NoArgsConstructor
public class Question {
    @Id
    @SequenceGenerator(name = "id", sequenceName = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "id")
    private Integer id;

    @ManyToOne
    private Test test;

    @NonNull
    @Column(length = 2000)
    private String text;

    @Nullable
    private String number;

    @Nullable
    private String images; // URL das imagens

    @Nullable
    private String subtitle;

    @NonNull
    @Column(length = 2000)
    private String options;

    @NonNull
    private String answer;
}
