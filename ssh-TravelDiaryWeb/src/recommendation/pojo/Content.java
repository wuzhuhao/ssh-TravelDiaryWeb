package recommendation.pojo;

import java.util.Arrays;
import java.util.Map;

/**
 * @Author: wuzhuhao
 * @Date: 19-5-6 下午6:20
 */
public class Content {
    String[] imgs;
    String name;
    String level;
    String intro;
    String addr;
    String score;
    String weather;
    String introduce;
    String times;
    Map<String, Map<String,String>> tipData;
	String price;

//    public Content() {
//    }


	public Content(String[] imgs, String name, String level, String intro, String addr, String score, String weather,
			String introduce, String times, Map<String, Map<String, String>> tipData, String price) {
        this.imgs = imgs;
        this.name = name;
        this.level = level;
        this.intro = intro;
        this.addr = addr;
        this.score = score;
        this.weather = weather;
        this.introduce = introduce;
        this.times = times;
        this.tipData = tipData;
		this.price = price;
    }

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String[] getImgs() {
        return imgs;
    }

    public void setImgs(String[] imgs) {
        this.imgs = imgs;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getWeather() {
        return weather;
    }

    public void setWeather(String weather) {
        this.weather = weather;
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public String getTimes() {
        return times;
    }

    public void setTimes(String times) {
        this.times = times;
    }

    public Map<String, Map<String, String>> getTipData() {
        return tipData;
    }

    public void setTipData(Map<String, Map<String, String>> tipData) {
        this.tipData = tipData;
    }

	@Override
	public String toString() {
		return "Content [imgs=" + Arrays.toString(imgs) + ", name=" + name + ", level=" + level + ", intro=" + intro
				+ ", addr=" + addr + ", score=" + score + ", weather=" + weather + ", introduce=" + introduce
				+ ", times=" + times + ", tipData=" + tipData + ", price=" + price + "]";
	}
}
