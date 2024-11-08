package com.stuti.order.magement.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String description;
    private double price;

    @ManyToMany(mappedBy = "products")
    private List<Order> orders;

    // Getters and setters
}