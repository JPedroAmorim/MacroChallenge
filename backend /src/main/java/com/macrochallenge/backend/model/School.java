package com.macrochallenge.backend.model;

import lombok.Data;
import lombok.NonNull;

import javax.persistence.*;
import java.util.ArrayList;

@Data
@Entity
public class School {

    @Id
    @SequenceGenerator(name = "id", sequenceName = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "id")
    private Integer id;

    @NonNull
    private String name;

    @NonNull
    private ArrayList<String> location;
}
