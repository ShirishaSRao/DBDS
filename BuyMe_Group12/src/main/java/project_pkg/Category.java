package project_pkg;

import java.util.ArrayList;
import java.util.List;

public class Category {
	int categoryID;
	String categoryName;
	public List<SubCategory> subCategories = new ArrayList<>();
	
	public Category(int cid, String cname) {
		this.categoryID = cid;
		this.categoryName = cname;
	}
}