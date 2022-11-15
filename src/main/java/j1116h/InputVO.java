package j1116h;

public class InputVO {
	private String name;
	private String strCode;
	private String strProduct;
	private String strSu;
	private String strPrice;
	private int pTot;
	
	public InputVO(String name, String strCode, String strProduct, String strSu, String strPrice, int pTot) {
		super();
		this.name = name;
		this.strCode = strCode;
		this.strProduct = strProduct;
		this.strSu = strSu;
		this.strPrice = strPrice;
		this.pTot = pTot;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStrCode() {
		return strCode;
	}
	public void setStrCode(String strCode) {
		this.strCode = strCode;
	}
	public String getStrProduct() {
		return strProduct;
	}
	public void setStrProduct(String strProduct) {
		this.strProduct = strProduct;
	}
	public String getStrSu() {
		return strSu;
	}
	public void setStrSu(String strSu) {
		this.strSu = strSu;
	}
	public String getStrPrice() {
		return strPrice;
	}
	public void setStrPrice(String strPrice) {
		this.strPrice = strPrice;
	}
	public int getpTot() {
		return pTot;
	}
	public void setpTot(int pTot) {
		this.pTot = pTot;
	}
	@Override
	public String toString() {
		return "InputVO [name=" + name + ", strCode=" + strCode + ", strProduct=" + strProduct + ", strSu=" + strSu
				+ ", strPrice=" + strPrice + ", pTot=" + pTot + "]";
	}
	
	
}
