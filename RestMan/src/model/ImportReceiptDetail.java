package model;

public class ImportReceiptDetail {
    private int id;
    private double quantity;
    private double price;
    private Ingredient ingredient;

    public ImportReceiptDetail() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public Ingredient getIngredient() { return ingredient; }
    public void setIngredient(Ingredient ingredient) { this.ingredient = ingredient; }

    /** Thanh tien = so luong x don gia. */
    public double getSubTotal() {
        return quantity * price;
    }
}
