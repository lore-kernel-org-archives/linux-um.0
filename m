Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB0238EB81@exch-03.noida.hcltech.com>
From: "Adil  Mujeeb, Noida" <adilm@hcltech.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4D856.1A729CD4"
Subject: [uml-devel] Telnet problem
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
Date: Thu, 2 Dec 2004 15:32:59 +0530
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4D856.1A729CD4
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
Im running uml on RedHat 9 host with command as follows:
 
./linux ubd0=guest1.diff,root_fs con=port:9001 con0=fd:0,fd:1 umid=guest1
mem=32m
 
Now when i try to telnet on uml with command
telnet localhost 9001
 
sometimes it successfully get the login & password prompt to login on uml
and sometimes get hanged and login: prompt doesn't appear.
 
Can anyone throw some light on it why this is happening???

Thanks and Best Regards,
Adil Mujeeb



------_=_NextPart_001_01C4D856.1A729CD4
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 5.00.3821.2800" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=835345809-02122004>Hi,</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=835345809-02122004>Im 
running uml on RedHat 9 host with command as follows:</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=835345809-02122004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=835345809-02122004>./linux ubd0=guest1.diff,root_fs con=port:9001 
con0=fd:0,fd:1 umid=guest1 mem=32m</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=835345809-02122004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=835345809-02122004>Now 
when i try to telnet on uml with command</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=835345809-02122004>telnet 
localhost 9001</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=835345809-02122004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=835345809-02122004>sometimes it successfully get the login &amp; password 
prompt to login on uml and sometimes get hanged and login: prompt doesn't 
appear.</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=835345809-02122004></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=835345809-02122004>Can 
anyone throw some light on it why this is happening???</SPAN></FONT></DIV>
<P><FONT face="Comic Sans MS" size=2>Thanks and Best Regards,</FONT><FONT 
face=Arial><BR><B></B></FONT><B><FONT color=#0000ff face="Times New Roman">Adil 
Mujeeb</FONT></B><BR></P></BODY></HTML>

------_=_NextPart_001_01C4D856.1A729CD4--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
