package recommendation.pojo;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author: wuzhuhao
 * @Date: 19-5-6 下午4:50
 */
public class Param {
    String keyword = "热门景点";//景点必要参数
    String sort = "";//排序参数--人气：pp、推荐‘’、价格升序：pu、价格降序：pd
    String city = "";//城市参数--城市中文
    String subject = "";//景点类型参数--类型中文
    int page;//页数

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public int getPage() {
        page = page==0?1:page;
        return page==0?1:page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public List<NameValuePair> getList(){
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add( new BasicNameValuePair( "keyword", getKeyword() ) );
        params.add( new BasicNameValuePair( "sort", getSort() ) );
        params.add( new BasicNameValuePair( "city", getCity() ) );
        params.add( new BasicNameValuePair( "subject", getSubject() ) );
        params.add( new BasicNameValuePair( "page", getPage()+"" ) );
        return params;
    }

    @Override
    public String toString() {
        return "Param{" +
                "keyword='" + keyword + '\'' +
                ", sort='" + sort + '\'' +
                ", city='" + city + '\'' +
                ", subject='" + subject + '\'' +
                ", page=" + page +
                '}';
    }
}
