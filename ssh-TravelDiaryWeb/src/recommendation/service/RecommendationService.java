package recommendation.service;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import recommendation.pojo.City_Subject;
import recommendation.pojo.Content;
import recommendation.pojo.Data;
import recommendation.pojo.DataList;
import recommendation.pojo.Param;


public class RecommendationService {

    final String ip_url = "http://127.0.0.1:5010/get_all/";
    final String data_url = "http://piao.qunar.com/ticket/list.htm";
    //设置代理
    List<String> ipProxy_list;
    int sc;
    private Content Content;

    public RecommendationService(){
        ipProxy_list = HttpUtil.SendGET(ip_url);
        sc = 0;
    }

	// 获取Subject到action
	public City_Subject getCity_Subject(Param param) {
		// 类型列表
		List<String> subject_list = new ArrayList<String>();
		String res = "";
		res = getHtml(data_url, param, 1);
		Document doc = Jsoup.parse(res);
		Element body = doc.body();
		try {
			subject_list = findSubjectList(body);
		} catch (Exception e) {
			e.printStackTrace();
			return getCity_Subject(param);
		}
		return new City_Subject(null, subject_list);
	}

	// 获取dataList到action 用于分页和添加查询
	public DataList getDataListByPage(Param param) {
		// 类型列表
		List<String> subject_list = new ArrayList<String>();
		// 数据列表
		List<Data> data_list = new ArrayList<Data>();
		// 城市列表
		Map<String, List> city_list = new LinkedHashMap<String, List>();
		// 总页数
		int pageCount = 0;
		String res = "";
		res = getHtml(data_url, param, 1);
		System.out.println("123");
		Document doc = Jsoup.parse(res);
		Element body = doc.body();
		// 爬取主要数据
		data_list = findDataList(param, body);
		// 爬取总页数
		pageCount = findPageCount(body);
		DataList dataList = new DataList(city_list, subject_list, data_list, param, pageCount);
		System.out.println(dataList);
		return dataList;
	}

	// 获取content内容到action
	public Content getContent(String url) {
        String res = "";
        res = getHtml(url, new Param(), 2);
        Document doc = Jsoup.parse(res);
        Element body = doc.body();
        Elements dataElements = body.select("div.mp-description");
        Elements imgs = dataElements.select("div[id=slide]").select("div[id=mp-slider-content]").first().select("img");
        Element tdataE = dataElements.select("div.mp-description-detail").first();
		Element priceE = body
				.select("div.mp-description-detail >div.mp-description-price >span.mp-description-qunar-price").first();
		String price = getElementText(priceE);
		String name = getElementText(tdataE.select("span.mp-description-name").first());
		String level = getElementText(tdataE.select("span.mp-description-level").first());
		String intro = getElementText(tdataE.select("div.mp-description-onesentence").first());
		String addr = getElementText(tdataE.select("span.mp-description-address").first());
		String score = getElementText(tdataE.select("span[id=mp-description-commentscore]").select("span").first());
		String weather = getElementText(
				tdataE.select("div[id=mp-description-weather]").select("span.mp-description-title").first());
		weather += getElementText(
				tdataE.select("div[id=mp-description-weather]").select("span.mp-description-val").first());
		System.out.println(imgs.size());
        String[] imgss = new String[imgs.size()];
        int i = 0;
        for (Element img:imgs){
            imgss[i] = img.attr("src");
            i++;
        }
        Element jDataE = body.select("div[id=mp-charact]").first();
        Element jieshaoE = jDataE.select("div").first().select("div.mp-charact-intro").first();
        Element timeE = jDataE.select("div").first().select("div.mp-charact-time").first();
        Elements jieshaoP = jieshaoE.select("div.mp-charact-desc").select("p");
        String introduce = "";
        for (Element p:jieshaoP){
			introduce += getElementText(p);
        }
		String times = "";
		try {
			times = timeE.select("div.mp-charact-desc").select("p").first().html();
		} catch (NullPointerException e) {
			System.out.println("times字段为空");
		} catch (Exception e) {
			e.printStackTrace();
		}
        Elements tipEs = jDataE.select("div.mp-charact-littletips");
        Map<String,Map<String,String>> tipData = new LinkedHashMap<String, Map<String, String>>();
        for (Element tip:tipEs){
			String tip_name = "";
			try {
				tip_name = tip.select("div").select("h2").text();
			} catch (NullPointerException e) {
				System.out.println("tip_name字段为空");
			} catch (Exception e) {
				e.printStackTrace();
			}
            System.out.println(tip_name);
            Elements divs = tip.select("div > div.mp-littletips > div");
            Map<String,String> dataMap = new LinkedHashMap<String,String>();
            for (Element div:divs){
				String item_name = getElementText(div.select("div.mp-littletips-itemtitle").first());
                String item_content = "";
                Elements pEl = div.select("div.mp-littletips-desc").select("p");
                for (Element p:pEl){
                    item_content+=p.text()+"<br>";
                }
                dataMap.put(item_name,item_content);
            }
            tipData.put(tip_name,dataMap);
        }
		Content content = new Content(imgss, name, level, intro, addr, score, weather, introduce, times, tipData,
				price);
        System.out.println(content);
        return content;
    }

	// 获取景点信息,城市列表,类型列表到action
    public DataList getDataList(Param param) {
		System.out.println("参数:" + param);
        //类型列表
        List<String> subject_list = new ArrayList<String>();
        //数据列表
        List<Data> data_list = new ArrayList<Data>();
        //城市列表
        Map<String,List> city_list = new LinkedHashMap<String, List>();
        //总页数
        int pageCount = 0;
        String res = "";
        res = getHtml(data_url,param,1);
        Document doc = Jsoup.parse(res);
        Element body = doc.body();
		try {
			city_list = findCityList(body);
			subject_list = findSubjectList(body);
		} catch (Exception e) {
			e.printStackTrace();
			return getDataList(param);
		}
        //爬取主要数据
		data_list = findDataList(param, body);
		// 爬取总页数
        pageCount = findPageCount(body);
        DataList dataList = new DataList(city_list, subject_list, data_list, param,pageCount);
        System.out.println(dataList);
        return dataList;
    }

	// 爬取类型列表信息
	public List<String> findSubjectList(Element body) {
		List<String> subject_list = new ArrayList<String>();
		Elements subject_elment = body.select("dl[id=subject-list]");
        if (subject_elment.size()==0){
			throw new RuntimeException("爬取类型节点出错");
        }
        Elements subject_items = subject_elment.get(0).select("dd");
        for (Element subject:subject_items){
            subject_list.add(subject.select("a > span").first().text());
        }
		return subject_list;
	}

	// 爬取总页数
	public int findPageCount(Element body) {
		int pageCount;
		Elements nextEl = body.select("div.pager").select("a.next");
        if (nextEl.size()==0){
			String temp = body.select("div.pager").select("em").text();
			if (temp.isEmpty()) {
				System.out.println("进行为空处理");
				Elements aEl = body.select("div.pager >a");
				pageCount = Integer.parseInt(getElementText(aEl.get(aEl.size() - 1))) + 1;
			} else {
				pageCount = Integer.parseInt(temp);
			}
        }else{
            Elements aEl = body.select("div.pager >a");
			pageCount = Integer.parseInt(getElementText(aEl.get(aEl.size() - 2)));
        }
		return pageCount;
	}

	// 爬取景点列表信息
	public List<Data> findDataList(Param param, Element body) {
		List<Data> data_list = new ArrayList<Data>();
		Element search_list = body.select("div[id=search-list]").first();
        Elements sight_items = search_list.select("div.sight_item");
        for (Element element:sight_items){
			String price = getElementsText(element.select("span.sight_item_price"));
			String contentUrl = getElementAttr(element.select("a[data-click-type=l_title]").first(), "href");
			String img = getElementAttr(element.select("img").first(), "data-original");
			String name = getElementAttr(element, "data-sight-name");
			String districts = getElementAttr(element, "data-districts");
			String point = getElementAttr(element, "data-point");
			String address = getElementAttr(element, "data-address");
			String data_id = getElementAttr(element, "data-id");
            Element levels = element.select("span.level").first();
			Element product_star_levels = element.select("span.product_star_level").first();
			String level = getElementText(levels);
			String product_star_level = getElementText(product_star_levels);
			Element intros = element.select("div.intro").first();
			String intro = getElementText(intros);
			Data data = new Data(districts, name, data_id, param.getSubject(), level, product_star_level.split(" ")[1],
					address, intro, point, img, contentUrl, price);
            data_list.add(data);
        }
		return data_list;
	}

	// 爬取城市列表信息
	public Map<String, List> findCityList(Element body) {
		Map<String, List> city_list = new HashMap<String, List>();
		Elements one_two_list = body.select("div[id=city-more-target]");
        if(one_two_list.size()==0){
			throw new RuntimeException("景点地方标题爬取出错");
        }
        Elements one_items = one_two_list.get(0).select("div[id=tabs]").select("a");
        Elements two_items = one_two_list.get(0).select("div[id=panes]").select("div");
		int index = 1;
		for (Element j : one_items) {
			Elements allDl = two_items.get(index).select("dl");
			index++;
			List<String> dl_data = new ArrayList<String>();
			for (Element elm : allDl) {
				dl_data.add(elm.select("dd").attr("data-value"));
			}
			city_list.put(j.text(), dl_data);
		}
		return city_list;
	}
    
	// 拿取html的信息 type为1用参数，其他为直接用url
    public String getHtml(String url, Param param,int type){
        System.out.println(url);
        String res = "";
        //浏览器列表
        String[] user_agents = new String[]{
                "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36 OPR/26.0.1656.60",
                "Opera/8.0 (Windows NT 5.1; U; en)",
                "Mozilla/5.0 (Windows NT 5.1; U; en; rv:1.8.1) Gecko/20061208 Firefox/2.0.0 Opera 9.50",
                "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en) Opera 9.50",
                "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0",
                "Mozilla/5.0 (X11; U; Linux x86_64; zh-CN; rv:1.9.2.10) Gecko/20100922 Ubuntu/10.10 (maverick) Firefox/3.6.10",
                "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2",
                "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36",
                "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11",
                "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.16 (KHTML, like Gecko) Chrome/10.0.648.133 Safari/534.16",
                "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.101 Safari/537.36",
                "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko",
                "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.11 TaoBrowser/2.0 Safari/536.11",
                "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.71 Safari/537.1 LBBROWSER",
                "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; LBBROWSER)",
                "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; QQDownload 732; .NET4.0C; .NET4.0E; LBBROWSER)",
                "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; QQBrowser/7.0.3698.400)",
                "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; QQDownload 732; .NET4.0C; .NET4.0E)",
                "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.84 Safari/535.11 SE 2.X MetaSr 1.0",
                "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Trident/4.0; SV1; QQDownload 732; .NET4.0C; .NET4.0E; SE 2.X MetaSr 1.0)",
                "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Maxthon/4.4.3.4000 Chrome/30.0.1599.101 Safari/537.36",
                "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 UBrowser/4.0.3214.0 Safari/537.36",
        };
        CloseableHttpClient client = HttpClients.createDefault();
        String proxy_data = "127.0.1.1:8080";
        HttpHost proxy = null;
        if(ipProxy_list.size()!=0){
            //获取代理ip列表的一个
            proxy_data = ipProxy_list.get(sc);
			System.out.println("代理ip:" + proxy_data);
            proxy = new HttpHost
                    (
                            proxy_data.split(":")[0]
                            , Integer.parseInt(proxy_data.split(":")[1])
                            , "http"
                    );
        }
        //新建代理
        RequestConfig config = RequestConfig.custom()
                .setProxy(proxy)
                .setConnectTimeout(5000)
                .setConnectionRequestTimeout(1000)
                .setSocketTimeout(5000)
                .build();
        List<NameValuePair> params = param.getList();
        URI uri = null;
        try {
            uri = new URI(url + "?" + URLEncodedUtils.format(params, "utf-8"));
        } catch (URISyntaxException e) {
            System.out.println("构造参数uri失败，将使用url进行爬取");
        }
        HttpGet get;
        if (uri==null||type!=1){
            get=new HttpGet(url);
        }
        else {
            get=new HttpGet(uri);
        }

        //模拟浏览器 set设置
        get.setConfig(config);
        get.setHeader("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
        get.setHeader("Accept-Encoding", "gzip, deflate, br");
        get.setHeader("Accept-Language", "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3");
        get.setHeader("Connection", "keep-alive");
        get.setHeader("Pragma", "no-cache");
        get.setHeader("Cache-Control", "no-cache");
        get.setHeader("User-Agent", user_agents[(int)(Math.random() * user_agents.length)]);
        try {
            CloseableHttpResponse response = client.execute(get);
            //拿到最终想要的页面
            HttpEntity entity = response.getEntity();
            res = EntityUtils.toString(entity,"utf-8");
            return res;
        } catch (IOException e) {
            System.out.println("获取页面超时，将进行切换代理ip爬取");
            sc++;
            if (sc==ipProxy_list.size()){
                ipProxy_list = HttpUtil.SendGET(ip_url);
                sc = 0;
            }
            return getHtml(url,param,type);
        }
    }

	public String getElementsText(Elements element) {
		try {
			return element.text();
		} catch (NullPointerException e) {
			System.out.println("有字段为空");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getElementText(Element element) {
		try {
			return element.text();
		} catch (NullPointerException e) {
			System.out.println("有字段为空");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public String getElementAttr(Element element, String name) {
		try {
			return element.attr(name);
		} catch (NullPointerException e) {
			System.out.println("有字段为空");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public static void main(String[] args) {
		Param param = new Param();
		param.setKeyword("热门景点");
		param.setPage(1);
		System.out.println(new RecommendationService().getDataList(param));
		String url = "http://piao.qunar.com/ticket/detail_3191715237.html?st=a3clM0QlRTclODMlQUQlRTklOTclQTglRTYlOTklQUYlRTclODIlQjklMjZpZCUzRDE5MTEyNyUyNnR5cGUlM0QwJTI2aWR4JTNEMSUyNnF0JTNEZGVmYXVsdFR5cGUlMjZhcGslM0QyJTI2c2MlM0RXV1clMjZ1ciUzRCVFNSVCOSVCRiVFNSVCNyU5RSUyNmxyJTNEJUU1JUI5JUJGJUU1JUI3JTlFJTI2ZnQlM0QlN0IlN0Q=#from=";
//		String url = "http://piao.qunar.com/ticket/detail_1420207505.html?st=a3clM0QlRTclODMlQUQlRTklOTclQTglRTYlOTklQUYlRTclODIlQjklMjZpZCUzRDQwOTAzJTI2dHlwZSUzRDAlMjZpZHglM0Q1NjUzMCUyNnF0JTNEZGVmYXVsdFR5cGUlMjZhcGslM0QyJTI2c2MlM0RXV1clMjZ1ciUzRCVFNSVCOSVCRiVFNSVCNyU5RSUyNmxyJTNEJUU1JUI5JUJGJUU1JUI3JTlFJTI2ZnQlM0QlN0IlN0Q%3D#from=mpl_search_suggest";
		new RecommendationService().getContent(url);
	}
}