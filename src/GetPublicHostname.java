import java.net.*;
import java.util.*;
import java.util.regex.Pattern;

public class GetPublicHostname
{
	public static void main(String[] args) throws Throwable
	{
		String url="http://"+GetPublicHostname.tellMyIP()+":8080/Twitter-Assi1/twitmapsse";
		
		System.out.println(url);
	}
	public static String tellMyIP()
	{
		try{
		//System.out.println("Host addr: " + InetAddress.getLocalHost().getHostAddress());  // often returns "127.0.0.1"
        Enumeration<NetworkInterface> n = NetworkInterface.getNetworkInterfaces();
        for (; n.hasMoreElements();)
        {
                NetworkInterface e = n.nextElement();
                //System.out.println("Interface: " + e.getName());
                if(!e.getName().equals("eth0"))
                continue;
                Enumeration<InetAddress> a = e.getInetAddresses();
                		a.nextElement();
                      //  System.out.println("  " + addr.getHostAddress());
                        InetAddress addr2 = a.nextElement();
                        //System.out.println("  " + addr2.getHostAddress());
                        return addr2.getHostAddress();

        }}
		catch(Exception e){
			e.printStackTrace();
		}
return "";
	}
	
 }