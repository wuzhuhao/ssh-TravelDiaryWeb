package recommendation.pojo;

/**
 * @Author: wuzhuhao
 * @Date: 19-5-6 下午7:55
 */
public class Data {
    String districts;//区域
    String name;//景点名
    String data_id;//景点id
    String subject;//景点类型
    String level;//级别
    String product_star_level;//热度
    String address;//详细地址
    String intro;//特色
    String point;//纬度
    String img;//图片
    String url;//内容url
	String price;// 参考价格

	public Data(String districts, String name, String data_id, String subject, String level, String product_star_level,
			String address, String intro, String point, String img, String url, String price) {
        this.districts = districts;
        this.name = name;
        this.data_id = data_id;
        this.subject = subject;
        this.level = level;
        this.product_star_level = product_star_level;
        this.address = address;
        this.intro = intro;
        this.point = point;
        this.img = img;
        this.url = url;
		this.price = price;
    }

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getDistricts() {
        return districts;
    }

    public void setDistricts(String districts) {
        this.districts = districts;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getData_id() {
        return data_id;
    }

    public void setData_id(String data_id) {
        this.data_id = data_id;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getProduct_star_level() {
        return product_star_level;
    }

    public void setProduct_star_level(String product_star_level) {
        this.product_star_level = product_star_level;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public String getPoint() {
        return point;
    }

    public void setPoint(String point) {
        this.point = point;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

	@Override
	public String toString() {
		return "Data [districts=" + districts + ", name=" + name + ", data_id=" + data_id + ", subject=" + subject
				+ ", level=" + level + ", product_star_level=" + product_star_level + ", address=" + address
				+ ", intro=" + intro + ", point=" + point + ", img=" + img + ", url=" + url + ", price=" + price + "]";
	}

}
