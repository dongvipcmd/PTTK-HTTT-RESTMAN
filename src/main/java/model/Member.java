package model;

public class Member {
    
    private int id;
    private String username;
    private String name;
    private String dob;
    private String address;
    private String email;
    private String phoneNumber;
    
    public Member(){
        
    }

    public Member(int id, String username, String name, String dob, String address, String email, String phoneNumber) {
        this.id = id;
        this.username = username;
        this.name = name;
        this.dob = dob;
        this.address = address;
        this.email = email;
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public String getDob() {
        return dob;
    }

    public String getEmail() {
        return email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getUsername() {
        return username;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setUsername(String username) {
        this.username = username;
    }
      
}