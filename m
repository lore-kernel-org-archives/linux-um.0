Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB033EBB38@exch-03.noida.hcltech.com>
From: "Adil  Mujeeb, Noida" <adilm@hcltech.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4F400.640F017A"
Subject: [uml-devel] Networking problem.
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
Date: Thu, 6 Jan 2005 20:29:58 +0530
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4F400.640F017A
Content-Type: text/plain;
	charset="iso-8859-1"

Hi all,
i have problem related to networking.
 
CASE 1:
My host machine has 2 ethernet cards.
i have booted a UML & connected its interface eth0 with a bridge. The steps
are as :
 
1. Boot the UMl.
2. Create the tap device & bridge.
3. Add the tap & host interface in the bridge and assign the IP to bridge.
4. config the uml interface with uml_mconsole as eth0=tuntap,tap0
5. enable ip forwarding on host & guest
 
Now Iam able to ping the uml interface from the host & ping back the host
from UML. But from uml iam unable to ping outside the host to other machins
on the same network. I have manipulated the routing table but still im
unable to ping other machines from UML.
 
CASE 2:
Create the vlan device on host with vconfig command.
Boot the UML
Create the tap device & bridge
Add the vlan interface & tap device (tap0) to bridge.
Create the uml switch with -tap option & attach with tap0
config the uml interface with uml_mconsole as eth0=daemon,,unix,socket file
enable ip forwarding on host & guest
Assign an ip to tap device but its unable to ping the uml interface & vice
versa.
 
 
Could anyone plz help me out.

Thanks and Best Regards,
Adil Mujeeb



------_=_NextPart_001_01C4F400.640F017A
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 5.00.3821.2800" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>Hi 
all,</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>i have problem 
related to networking.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=392174514-06012005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>CASE 
1:</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>My host machine has 
2 ethernet cards.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>i have booted a UML 
&amp; connected its interface eth0 with a bridge. The steps are as 
:</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=392174514-06012005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>1. Boot the 
UMl.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>2. Create the tap 
device &amp; bridge.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>3. Add the tap &amp; 
host interface in the bridge and assign the IP to bridge.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>4. config 
the&nbsp;uml interface with uml_mconsole as eth0=tuntap,tap0</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>5. enable ip 
forwarding on host &amp; guest</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=392174514-06012005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>Now Iam able to ping 
the&nbsp;uml interface from the host &amp; ping back the host from UML. But from 
uml iam unable to ping outside the host to other machins on the same network. I 
have manipulated the routing table but still im unable to ping other machines 
from UML.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=392174514-06012005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>CASE 
2:</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>Create the vlan 
device on host with vconfig command.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>Boot the 
UML</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>Create the tap 
device &amp; bridge</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>Add the vlan 
interface &amp; tap device (tap0) to bridge.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>Create the uml 
switch with -tap option &amp; attach with tap0</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>config the&nbsp;uml 
interface with uml_mconsole as eth0=daemon,,unix,socket file</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>enable ip forwarding 
on host &amp; guest</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>Assign an ip to tap 
device but its unable to ping the uml interface &amp; vice 
versa.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=392174514-06012005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=392174514-06012005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=392174514-06012005>Could anyone plz 
help me out.</SPAN></FONT></DIV>
<P><FONT face="Comic Sans MS" size=2>Thanks and Best Regards,</FONT><FONT 
face=Arial><BR><B></B></FONT><B><FONT color=#0000ff face="Times New Roman">Adil 
Mujeeb</FONT></B><BR></P></BODY></HTML>

------_=_NextPart_001_01C4F400.640F017A--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
