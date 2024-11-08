package com.stuti.order.magement.model;

import jakarta.persistence.*;


@Entity
@Table(name = "address")
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // This will auto-generate the ID
    private Long id;  // Primary key field

    private String street;
    private String city;
    private String state;
    private String zipCode;

    @Enumerated(EnumType.STRING)
    private AddressType addressType;

}
