package recommendation.service;

import com.alibaba.fastjson.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Author: wuzhuhao
 * @Date: 19-4-28 上午11:20
 */
public class HttpUtil {

//    public void getDocByJsoup(String href){
//        String ip = "221.237.155.64";
//        int port = 9797;
//        try {
//            Proxy proxy = new Proxy(Proxy.Type.HTTP, new InetSocketAddress(ip, port));
//            URL url = new URL(href);
//            HttpsURLConnection urlcon = (HttpsURLConnection)url.openConnection(proxy);
//            urlcon.connect();  //获取连接  
//            InputStream is = urlcon.getInputStream();
//            BufferedReader buffer = new BufferedReader(new InputStreamReader(is));
//            StringBuffer bs = new StringBuffer();
//            String l = null;
//            while((l=buffer.readLine())!=null){
//                bs.append(l);
//            }
//            System.out.println(bs.toString());
//            Document doc = Jsoup.parse(bs.toString());
//        } catch(Exception e) {
//            e.printStackTrace();
//        }
//    }
    public static List<String> SendGET(String url){
//        System.setProperty("https.proxySet", "true");
//        System.getProperties().put("https.proxyHost", "");
//        System.getProperties().put("https.proxyPort", "");
        String result="";//访问返回结果
        BufferedReader read=null;//读取访问结果
        List<String> list;
        try {
            //创建url
            URL realurl=new URL(url);
            //打开连接
            URLConnection connection=realurl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            //建立连接
            connection.connect();
            // 获取所有响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();
//            // 遍历所有的响应头字段，获取到cookies等
//            for (String key : map.keySet()) {
//                System.out.println(key + "--->" + map.get(key));
//            }
            // 定义 BufferedReader输入流来读取URL的响应
            read = new BufferedReader(new InputStreamReader(
                    connection.getInputStream(),"UTF-8"));
            String line;//循环读取
            while ((line = read.readLine()) != null) {
                result += line;
            }
        } catch (IOException e) {
            System.out.println("连接代理ip池失败");
//            e.printStackTrace();
        }finally{
            if(read!=null){//关闭流
                try {
                    read.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        if (!(result==null||result.equals("")||result.length()==0)){
            list = JSONObject.parseArray(result, String.class);
        }else{
            list = new ArrayList<String>();
        }
        return list;
    }

    public static void main(String[] args) {
        System.out.println(SendGET("http://127.0.0.1:5010/get_all/"));
    }
}