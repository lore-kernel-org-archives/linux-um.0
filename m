Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB04F72867@exch-03.noida.hcltech.com>
From: "Adil  Mujeeb, Noida" <adilm@hcltech.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C51D42.A5EA7ECA"
Subject: [uml-devel] Telnet (IPV6) on port
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
Date: Mon, 28 Feb 2005 08:37:33 +0530
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C51D42.A5EA7ECA
Content-Type: text/plain;
	charset="iso-8859-1"

 
Reposting the question.
If there is any clarification required in the question, plz revert back.

Thanks and Best Regards,
Adil Mujeeb

From: user-mode-linux-user-admin@lists.sourceforge.net
[mailto:user-mode-linux-user-admin@lists.sourceforge.net]On Behalf Of Adil
Mujeeb, Noida
Sent: Saturday, February 26, 2005 9:45 PM
To: user-mode-linux-devel@lists.sourceforge.net;
user-mode-linux-user@lists.sourceforge.net
Cc: Mukul Prasad, Noida
Subject: [uml-user] Telnet (IPV6) on port



Hi,
Iam using 2.4.26 linux source and patch it with uml-patch-2.4.26-3 patch.
I have built the uml binary with ipv6 support and my host has ipv6 module
loaded.
The telnet client and daemon are IPV6 supported on the Host machine. Iam
able to telnet on the localhost with ipv6 address. 
For example to telnet on localhost with loopback address ( ::1 ) , it works
fine.
 
Now Im running uml on this host (RedHat 9) with command as follows:
 
./linux ubd0=guest1.diff,root_fs con=port:9001 con0=fd:0,fd:1 umid=guest1
mem=32m
 
Now when i try to telnet on UML with following command :
telnet 127.0.0.1 9001, it works fine
 
But if I telnet with :
telnet ::1 9001
it gives message connection refused.

 
Can anyone throw some light on it why this is happening???
 
Thanks and Best Regards,
Adil Mujeeb



------_=_NextPart_001_01C51D42.A5EA7ECA
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 5.00.3825.700" name=GENERATOR></HEAD>
<BODY>
<DIV>&nbsp;</DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=890260603-28022005>Reposting the question.</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=890260603-28022005>If 
there is any clarification required in the question, plz revert 
back.</SPAN></FONT></DIV>
<P><FONT face="Comic Sans MS" size=2>Thanks and Best Regards,</FONT><FONT 
face=Arial><BR><B></B></FONT><B><FONT color=#0000ff face="Times New Roman">Adil 
Mujeeb</FONT></B><BR><FONT face=Tahoma size=2><BR><B>From:</B> 
user-mode-linux-user-admin@lists.sourceforge.net 
[mailto:user-mode-linux-user-admin@lists.sourceforge.net]<B>On Behalf Of 
</B>Adil Mujeeb, Noida<BR><B>Sent:</B> Saturday, February 26, 2005 9:45 
PM<BR><B>To:</B> user-mode-linux-devel@lists.sourceforge.net; 
user-mode-linux-user@lists.sourceforge.net<BR><B>Cc:</B> Mukul Prasad, 
Noida<BR><B>Subject:</B> [uml-user] Telnet (IPV6) on port<BR><BR></P>
<BLOCKQUOTE style="MARGIN-RIGHT: 0px"></FONT>
  <DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN 
  class=835345809-02122004>Hi,</SPAN></FONT></DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN 
  class=835345809-02122004><SPAN class=877220716-26022005>Iam using 2.4.26 linux 
  source and patch it with uml-patch-2.4.26-3 patch.</SPAN></SPAN></FONT></DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN 
  class=835345809-02122004><SPAN class=877220716-26022005>I have built the uml 
  binary with ipv6 support and my host has ipv6 module 
  loaded.</SPAN></SPAN></FONT></DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN class=877220716-26022005>The 
  telnet client and daemon are IPV6 supported on the Host machine. Iam able to 
  telnet on the localhost with ipv6 address. </SPAN></FONT></DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN class=877220716-26022005>For 
  example to telnet on localhost with loopback address ( ::1 ) , it works 
  fine.</SPAN></FONT></DIV>
  <DIV><FONT face=Arial size=2><SPAN 
  class=877220716-26022005></SPAN></FONT>&nbsp;</DIV>
  <DIV><FONT size=2><FONT color=#0000ff><FONT face=Arial><SPAN 
  class=835345809-02122004><SPAN class=877220716-26022005>Now </SPAN>Im running 
  uml on&nbsp;<SPAN class=877220716-26022005>this host (</SPAN>RedHat 9<SPAN 
  class=877220716-26022005>)</SPAN> with command as 
  follows:</SPAN></FONT></FONT></FONT></DIV>
  <DIV><SPAN class=835345809-02122004></SPAN><FONT color=#0000ff face=Arial 
  size=2>&nbsp;</FONT></DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN 
  class=835345809-02122004>./linux ubd0=guest1.diff,root_fs con=port:9001 
  con0=fd:0,fd:1 umid=guest1 mem=32m</SPAN></FONT></DIV>
  <DIV><SPAN class=835345809-02122004></SPAN><FONT color=#0000ff face=Arial 
  size=2>&nbsp;</FONT></DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN class=877220716-26022005>Now 
  when i try to telnet on UML with following command :</SPAN></FONT></DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN 
  class=877220716-26022005>telnet 127.0.0.1 9001, it works 
  fine</SPAN></FONT></DIV>
  <DIV><FONT face=Arial size=2><SPAN class=835345809-02122004><SPAN 
  class=877220716-26022005></SPAN></SPAN></FONT>&nbsp;</DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN 
  class=835345809-02122004><SPAN class=877220716-26022005>But if I telnet with 
  :</SPAN></SPAN></FONT></DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN 
  class=835345809-02122004><SPAN class=877220716-26022005>telnet ::1 
  9001</SPAN></SPAN></FONT></DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN 
  class=835345809-02122004><SPAN class=877220716-26022005>it gives message 
  connection refused.</SPAN></SPAN></FONT></DIV>
  <DIV><FONT face=Arial size=2><SPAN class=835345809-02122004><SPAN 
  class=877220716-26022005>
  <DIV>&nbsp;</DIV>
  <DIV><FONT color=#0000ff face=Arial size=2><SPAN class=835345809-02122004>Can 
  anyone throw some light on it why this is 
  happening???</SPAN></FONT></SPAN></SPAN></FONT><SPAN 
  class=835345809-02122004></SPAN><FONT face="Comic Sans MS" 
  size=2></FONT></DIV></DIV>
  <DIV><FONT face="Comic Sans MS" size=2></FONT>&nbsp;</DIV>
  <DIV><FONT face="Comic Sans MS" size=2>Thanks and Best Regards,</FONT><FONT 
  face=Arial><BR><B></B></FONT><B><FONT color=#0000ff 
  face="Times New Roman">Adil 
Mujeeb</FONT></B><BR></DIV></DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C51D42.A5EA7ECA--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
