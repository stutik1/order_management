# order_management



Here's a step-by-step guide to building a basic telecom order management application using Java, Spring Boot, JPA, H2, Swagger, and YAML:

### 1. **Set Up the Spring Boot Project**
   - Create a new Spring Boot project in your preferred IDE (e.g., IntelliJ IDEA, Eclipse).
   - Select the following dependencies:
     - Spring Web
     - Spring Data JPA
     - H2 Database
     - Spring Boot DevTools (for development convenience)
     - Springfox Swagger 2 (for API documentation)

### 2. **Define the Application Structure**
   Organize your project structure as follows:
   ```
   src/main/java/com/yourpackage/telecom
   ├── controller
   ├── model
   ├── repository
   ├── service
   └── config
   ```

### 3. **Define Entities (Model Classes)**

   Create the model classes in the `model` package:

   - **Product.java**
     ```java
     @Entity
     public class Product {
         @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
         private Long id;
         private String name;
         private String description;
         private double price;
         // Getters and setters
     }
     ```

   - **Customer.java**
     ```java
     @Entity
     public class Customer {
         @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
         private Long id;
         private String name;
         private String email;
         // Getters and setters
     }
     ```

   - **Address.java**
     ```java
     @Entity
     public class Address {
         @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
         private Long id;
         private String street;
         private String city;
         private String state;
         private String zipCode;
         // Getters and setters
     }
     ```

   - **Order.java**
     ```java
     @Entity
     public class Order {
         @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
         private Long id;
         @ManyToOne private Customer customer;
         @OneToMany private List<Product> products;
         @OneToOne private Address shippingAddress;
         private LocalDate orderDate;
         // Getters and setters
     }
     ```

### 4. **Create Repositories**

   Define repository interfaces in the `repository` package:
   - **ProductRepository.java**
     ```java
     public interface ProductRepository extends JpaRepository<Product, Long> { }
     ```

   - **CustomerRepository.java**
     ```java
     public interface CustomerRepository extends JpaRepository<Customer, Long> { }
     ```

   - **OrderRepository.java**
     ```java
     public interface OrderRepository extends JpaRepository<Order, Long> { }
     ```

   - **AddressRepository.java**
     ```java
     public interface AddressRepository extends JpaRepository<Address, Long> { }
     ```

### 5. **Create Service Layer**

   Implement service classes in the `service` package for business logic.

   - **ProductService.java**
     ```java
     @Service
     public class ProductService {
         @Autowired private ProductRepository productRepository;
         public Product saveProduct(Product product) { return productRepository.save(product); }
         public List<Product> getAllProducts() { return productRepository.findAll(); }
     }
     ```

   - Repeat similar structures for `CustomerService`, `OrderService`, and `AddressService`.

### 6. **Create Controller Layer**

   Create controllers in the `controller` package to expose APIs.

   - **ProductController.java**
     ```java
     @RestController
     @RequestMapping("/api/products")
     public class ProductController {
         @Autowired private ProductService productService;

         @PostMapping
         public Product createProduct(@RequestBody Product product) {
             return productService.saveProduct(product);
         }

         @GetMapping
         public List<Product> getAllProducts() {
             return productService.getAllProducts();
         }
     }
     ```

   - Similarly, create `CustomerController`, `OrderController`, and `AddressController`.

### 7. **Swagger Configuration**

   - Add Swagger configuration in the `config` package:
     - **SwaggerConfig.java**
       ```java
       @Configuration
       @EnableSwagger2
       public class SwaggerConfig {
           @Bean
           public Docket api() {
               return new Docket(DocumentationType.SWAGGER_2)
                   .select()
                   .apis(RequestHandlerSelectors.basePackage("com.yourpackage.telecom.controller"))
                   .paths(PathSelectors.any())
                   .build();
           }
       }
       ```

### 8. **Application Configuration with YAML**

   In `src/main/resources/application.yaml`, configure your H2 database and other properties:
   ```yaml
   spring:
     datasource:
       url: jdbc:h2:mem:telecomdb
       driver-class-name: org.h2.Driver
       username: sa
       password:
     h2:
       console:
         enabled: true
     jpa:
       hibernate:
         ddl-auto: update
       show-sql: true
   ```

### 9. **Run and Test the Application**
   - Run the application, navigate to `http://localhost:8080/h2-console` for the H2 console, and `http://localhost:8080/swagger-ui.html` for Swagger documentation.

This setup will give you a basic telecom order management application with CRUD operations and API documentation. Let me know if you need further customization or additional features!





Here's the full set of entities, each including fields, relationships, and enum configurations to match your requirements.

### 1. **Product Entity**

```java
import javax.persistence.*;
import java.util.List;

@Entity
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
```

### 2. **Customer Entity**

```java
import javax.persistence.*;
import java.util.List;

@Entity
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;
    private String email;
    
    @OneToMany(mappedBy = "customer")
    private List<Order> orders;

    // Getters and setters
}
```

### 3. **Address Entity**

This entity includes the `AddressType` enum for specifying types like home, office, or other.

```java
import javax.persistence.*;

@Entity
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String street;
    private String city;
    private String state;
    private String zipCode;
    
    @Enumerated(EnumType.STRING)
    private AddressType addressType;

    // Getters and setters
}
```

- **AddressType Enum**

```java
public enum AddressType {
    HOME,
    OFFICE,
    OTHER
}
```

### 4. **Order Entity**

The `Order` entity includes the `status` and `paymentType` enums, as well as a many-to-many relationship with `Product` and one-to-one with `Address`.

```java
import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderId;
    
    @ManyToOne
    private Customer customer;
    
    @ManyToMany
    @JoinTable(
        name = "order_product",
        joinColumns = @JoinColumn(name = "order_id"),
        inverseJoinColumns = @JoinColumn(name = "product_id")
    )
    private List<Product> products;
    
    @Enumerated(EnumType.STRING)
    private Status status;
    
    private LocalDate createDate;
    
    @Enumerated(EnumType.STRING)
    private PaymentType paymentType;
    
    @OneToOne
    private Address address;

    // Getters and setters
}
```

- **Status Enum**

```java
public enum Status {
    PENDING,
    COMPLETED,
    CANCELLED
}
```

- **PaymentType Enum**

```java
public enum PaymentType {
    CREDIT_CARD,
    DEBIT_CARD,
    PAYPAL,
    CASH_ON_DELIVERY
}
```

### Summary of Relationships

1. **Product** and **Order** have a many-to-many relationship with a join table `order_product`.
2. **Customer** and **Order** have a one-to-many relationship, as a customer can create multiple orders.
3. **Order** and **Address** have a one-to-one relationship, as each order has a specific shipping address.
4. **Order** has enums for `status` and `paymentType`, while **Address** uses an `addressType` enum.

These entities should align with your application structure, supporting CRUD operations, relational mapping, and enum management. Let me know if you need further customization or help with other parts of the application!
