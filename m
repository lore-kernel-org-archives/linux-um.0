Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgJgi-0000JU-Hx for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jul 2004 01:46:28 -0700
Received: from letters.cs.ucsb.edu ([128.111.41.13])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BgJgi-0007kR-4K for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jul 2004 01:46:28 -0700
Message-ID: <40E520AE.8040302@cs.ucsb.edu>
From: "Lamia M.Youseff" <Lyouseff@cs.ucsb.edu>
MIME-Version: 1.0
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] does O_DIRECT hinder greatly file reading performance but
	not writing??
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 02 Jul 2004 01:45:34 -0700
To: lyouseff@cs.ucsb.edu, user-mode-linux-devel@lists.sourceforge.net

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
<meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
<title></title>
          Hi All,<br>
 
<pre class="moz-signature" cols="$mailwrapcol">I am kind of new to UML and I am experiencing a very strange performance hinder with it.
I am running two benchmarks; one that writes a 50Mbyte file and the other one reads a 50Mbyte file.
I tried the benchmarks with and without setting the O_DIRECT flag, in which cases the whole task is done in a matter of seconds(10-30 seconds) except when reading the file with O_DIRECT flag on. In this case, it takes 18-20 min!!!

I am running UML 2.4.19 on top of kernel 2.4.25.  I have time output like that (average of 20 runs) 
</pre>
 
<table cellpadding="2" cellspacing="2" border="1" width="100%">
   <tbody>
     <tr>
       <td valign="top"><b><font color="#000000">Operation<br>
       </font></b></td>
       <td valign="top"><b><font color="#000000">User Time (sec)<br>
       </font></b></td>
       <td valign="top"><b><font color="#000000">Sys Time(sec)<br>
       </font></b></td>
       <td valign="top"><b><font color="#000000">Wall Clock Time(sec)<br>
       </font></b></td>
     </tr>
     <tr>
       <td valign="top">       
      <pre class="moz-signature" cols="$mailwrapcol"><b><font
 color="#000000">Write Without O_DIRECT</font></b></pre>
       </td>
       <td valign="top"><font color="#000000">5.612000<br>
       </font></td>
       <td valign="top"><font color="#000000">0.117500<br>
       </font></td>
       <td valign="top"><font color="#000000">27.164500<br>
       </font></td>
     </tr>
     <tr>
       <td valign="top">       
      <pre class="moz-signature" cols="$mailwrapcol"><b><font
 color="#000000">Write With O_DIRECT</font></b></pre>
       </td>
       <td valign="top"><font color="#000000">10.007000<br>
       </font></td>
       <td valign="top"><font color="#000000">0.017000<br>
       </font></td>
       <td valign="top"><font color="#000000">22.199500<br>
       </font></td>
     </tr>
     <tr>
       <td valign="top">       
      <pre class="moz-signature" cols="$mailwrapcol"><b><font
 color="#000000">Read without O_DIRECT </font></b></pre>
       </td>
       <td valign="top"><font color="#000000">3.035000<br>
       </font></td>
       <td valign="top"><font color="#000000">0.091000<br>
       </font></td>
       <td valign="top"><font color="#000000">7.760000<br>
       </font></td>
     </tr>
     <tr>
       <td valign="top">       
      <pre class="moz-signature" cols="$mailwrapcol"><b><font
 color="#000000">Read With O_DIRECT</font></b></pre>
       </td>
       <td valign="top"><b><font color="#ff0000">21.492000<br>
       </font></b></td>
       <td valign="top"><b><font color="#ff0000">29.680000<br>
       </font></b></td>
       <td valign="top"><b><font color="#ff0000">1133.054000<br>
       </font></b></td>
     </tr>
   
  </tbody> 
</table>
 
<pre class="moz-signature" cols="$mailwrapcol">I would appreciate it very much if somebody would explain to me how to solve that strange performance problem, or even explain why does it happen for reading with O_DIRECT but not without !!??

Thanks allot,
Lamia Youseff
-- </pre>
 
</body>
</html>



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
