package recommendation.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @Author: wuzhuhao
 * @Date: 19-5-6 下午8:42
 */
public class ThreadRun {
    /** 接口超时时间 */
    private static final Integer TIME_OUT = 5000;
    static final String PY_URL = "/home/wuzhuhao/programming/ip-pool/proxy_pool-master/Run";
    public static String INTRANET_IP = getIntranetIp(); // 内网IP
    public static String INTERNET_IP = getV4IP(); // 外网IP

    public static Process execPy() {
        Process proc = null;
        try {
            proc = Runtime.getRuntime().exec("python3.6 " + PY_URL);
            proc.waitFor();
//            proc.destroy();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return proc;
    }

    /**
     * 获得内网IP
     * @return 内网IP
     */
    private static String getIntranetIp(){
        try{
            return InetAddress.getLocalHost().getHostAddress();
        } catch(Exception e){
            throw new RuntimeException(e);
        }
    }

    /**
     * 获得外网IP
     * @return 外网IP
     */
    private static String getV4IP(){
        String ip = "";
        String chinaz = "http://ip.chinaz.com";

        StringBuilder inputLine = new StringBuilder();
        String read = "";
        URL url = null;
        HttpURLConnection urlConnection = null;
        BufferedReader in = null;
        try {
            url = new URL(chinaz);
            try {
                urlConnection = (HttpURLConnection) url.openConnection();
                urlConnection.setConnectTimeout(TIME_OUT);
                urlConnection.setReadTimeout(TIME_OUT);
                in = new BufferedReader( new InputStreamReader(urlConnection.getInputStream(),"UTF-8"));
            } catch (Exception e) {
                //如果超时，则返回内网ip
                return INTRANET_IP;
            }
            while((read=in.readLine())!=null){
                inputLine.append(read+"\r\n");
            }
            //System.out.println(inputLine.toString());
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            if(in!=null){
                try {
                    in.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }


        Pattern p = Pattern.compile("\\<dd class\\=\"fz24\">(.*?)\\<\\/dd>");
        Matcher m = p.matcher(inputLine.toString());
        if(m.find()){
            String ipstr = m.group(1);
            ip = ipstr;
            //System.out.println(ipstr);
        }
        if ("".equals(ip)) {
            // 如果没有外网IP，就返回内网IP
            return INTRANET_IP;
        }
        return ip;
    }

    public static void main(String[] args) throws UnknownHostException {
        String ip= InetAddress.getLocalHost().getHostAddress().toString();
        System.out.println(ip);
        System.out.println(getV4IP());
    }
}
