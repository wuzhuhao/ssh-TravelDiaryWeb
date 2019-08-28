package recommendation.pojo;

import java.util.List;
import java.util.Map;

/**
 * @Author: wuzhuhao
 * @Date: 19-5-6 下午8:03
 */
public class DataList {
	//城市信息
    Map<String, List> city_list;
    //类型信息
    List<String> subject_list;
    //页面list
    List<Data> data_list;
    Param param;
    int PageCount;

    public DataList(Map<String, List> city_list, List<String> subject_list, List<Data> data_list, Param param, int pageCount) {
        this.city_list = city_list;
        this.subject_list = subject_list;
        this.data_list = data_list;
        this.param = param;
        PageCount = pageCount;
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

    public List<Data> getData_list() {
        return data_list;
    }

    public void setData_list(List<Data> data_list) {
        this.data_list = data_list;
    }

    public Param getParam() {
        return param;
    }

    public void setParam(Param param) {
        this.param = param;
    }

    public int getPageCount() {
        return PageCount;
    }

    public void setPageCount(int pageCount) {
        PageCount = pageCount;
    }

    @Override
    public String toString() {
        return "DataList{" +
                "city_list=" + city_list +
                ",\n subject_list=" + subject_list +
                ",\n data_list=" + data_list +
                ",\n param=" + param +
                ",\n PageCount=" + PageCount +
                '}';
    }
}
