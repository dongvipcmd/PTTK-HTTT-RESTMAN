DROP DATABASE IF EXISTS restman;
CREATE DATABASE restman CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE restman;

CREATE TABLE tblMember (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(255),
  dob INT,
  address VARCHAR(255),
  email VARCHAR(255),
  phoneNumber VARCHAR(255)
);

CREATE TABLE tblStaff (
  tblMemberid INT PRIMARY KEY,
  staffId VARCHAR(255) UNIQUE,
  position VARCHAR(255),
  FOREIGN KEY (tblMemberid) REFERENCES tblMember(id)
);

CREATE TABLE tblWareHouseStaff (
  tblStafftblMemberid INT PRIMARY KEY,
  FOREIGN KEY (tblStafftblMemberid) REFERENCES tblStaff(tblMemberid)
);

CREATE TABLE tblDish (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price DOUBLE,
  note VARCHAR(255),
  image VARCHAR(255)
);

CREATE TABLE tblSupplier (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255),
  phoneNumber VARCHAR(255),
  note VARCHAR(255)
);

CREATE TABLE tblIngredient (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  massUnits VARCHAR(255),
  quantity DOUBLE DEFAULT 0,
  note VARCHAR(255)
);

CREATE TABLE tblImportReceipt (
  id INT AUTO_INCREMENT PRIMARY KEY,
  importDate DATE,
  totalPrice DOUBLE,
  tblWareHouseStafftblStafftblMemberid INT NOT NULL,
  Supplierid INT NOT NULL,
  FOREIGN KEY (tblWareHouseStafftblStafftblMemberid) REFERENCES tblWareHouseStaff(tblStafftblMemberid),
  FOREIGN KEY (Supplierid) REFERENCES tblSupplier(id)
);

CREATE TABLE tblImportReceiptDetail (
  id INT AUTO_INCREMENT PRIMARY KEY,
  quantity DOUBLE,
  price DOUBLE,
  tblImportReceiptid INT NOT NULL,
  tblIngredientid INT NOT NULL,
  FOREIGN KEY (tblImportReceiptid) REFERENCES tblImportReceipt(id),
  FOREIGN KEY (tblIngredientid) REFERENCES tblIngredient(id)
);

-- Du lieu mau
INSERT INTO tblMember(username, password, name) VALUES ('kho1', '123', 'Nguyễn Văn Kho');
INSERT INTO tblStaff(tblMemberid, staffId, position) VALUES (1, 'NV01', 'WAREHOUSE');
INSERT INTO tblWareHouseStaff VALUES (1);

INSERT INTO tblDish(name, price, note, image) VALUES
 ('Phở bò', 50000, 'Phở bò tái nạm, nước dùng hầm xương 12 tiếng', ''),
 ('Bún chả', 45000, 'Bún chả Hà Nội, thịt nướng than hoa', ''),
 ('Gỏi cuốn', 30000, 'Gỏi cuốn tôm thịt, chấm tương đặc biệt', ''),
 ('Cơm rang dưa bò', 55000, 'Cơm rang dưa cải với thịt bò xào', '');

INSERT INTO tblSupplier(name, address, phoneNumber, note) VALUES
 ('Công ty Thực phẩm A', 'Hà Nội', '0901234567', ''),
 ('Nông trại Xanh', 'Hưng Yên', '0907654321', '');

INSERT INTO tblIngredient(name, massUnits) VALUES
 ('Thịt bò', 'kg'), ('Bún tươi', 'kg'), ('Hành lá', 'bó'), ('Tôm', 'kg');
