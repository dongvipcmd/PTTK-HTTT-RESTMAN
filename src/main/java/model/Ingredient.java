package model;

public class Ingredient {
    private int id;
    private String name;
    private String massUnits;
    private double price;
    private String note;

    public Ingredient() {
       
    }

    public Ingredient(int id, String name, String massUnits, double price, String note) {
        this.id = id;
        this.name = name;
        this.massUnits = massUnits;
        this.price = price;
        this.note = note;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getMassUnits() { return massUnits; }
    public void setMassUnits(String massUnits) { this.massUnits = massUnits; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}