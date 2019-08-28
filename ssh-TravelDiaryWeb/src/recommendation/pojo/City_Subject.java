package recommendation.pojo;

import java.util.List;
import java.util.Map;

public class City_Subject {
	//城市信息
    Map<String, List> city_list;
    //类型信息
    List<String> subject_list;
    
	public City_Subject(Map<String, List> city_list, List<String> subject_list) {
		super();
		this.city_list = city_list;
		this.subject_list = subject_list;
	}
	public Map<String, List> getCity_list() {
		return city_list;
	}
	public void setCity_list(Map<String, List> city_list) {
		this.city_list = city_list;
	}
	public List<String> getSubject_list() {
		return subject_list;
	}
	public void setSubject_list(List<String> subject_list) {
		this.subject_list = subject_list;
	}
    
    
}
