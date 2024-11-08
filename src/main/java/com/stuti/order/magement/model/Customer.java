package com.stuti.order.magement.model;

import jakarta.persistence.*;
import java.util.List;

    @Entity
    @Table(name = "customers")
    public class Customer {
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;

        private String name;
        private String email;

        @OneToMany(mappedBy = "customer")
        private List<Order> orders;

    }
