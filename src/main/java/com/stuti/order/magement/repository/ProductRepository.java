package com.stuti.order.magement.repository;

import com.stuti.order.magement.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> { }

