Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GNWLh-0003fJ-Pv for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Sep 2006 08:08:25 -0700
Received: from ug-out-1314.google.com ([66.249.92.175])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GNWLg-0005UU-QW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Sep 2006 08:08:25 -0700
Received: by ug-out-1314.google.com with SMTP id s2so2312848uge
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Sep 2006 08:08:19 -0700 (PDT)
Message-ID: <309201e0609130808xa849d0aq162b3ed8d458099e@mail.gmail.com>
Date: Wed, 13 Sep 2006 11:08:18 -0400
From: "Keppler Alecrim" <alecrim@gmail.com>
MIME-Version: 1.0
Subject: [uml-devel] UML HCD
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0986092183=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============0986092183==
Content-Type: multipart/alternative; 
	boundary="----=_Part_180254_24656869.1158160098915"

------=_Part_180254_24656869.1158160098915
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all ,
   I am trying to using McChechan's path(
http://mysite.verizon.net/james.mcmechan/)  but It is returning this error
during the boot :

./linux ubda=../../../fs/root usb_device_name=/proc/bus/usb/005/009
...
[42949373.230000]  uml-hcd: USB User Mode Host Controller
[42949373.230000]  uml-hcd: new USB bus registered, assigned bus number 1
[42949373.230000]  uml-hcd: startup error -19
[42949373.230000]  uml-hcd: USB bus 1 deregistered
...

That is the hardware that I'm using :
Bus 005 Device 009: ID 08ec:0012 M-Systems Flash Disk Pioneers


I'm a newbies but I'm trying to understand and correct this problem.
 Can anyone help me with something?

Thanks

-- 
-- 
Francisco Keppler Silva Alecrim
Instituto Nokia de Tecnologia (INdT)
Open Source Mobile Research Center (OSMRC)

------=_Part_180254_24656869.1158160098915
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all , <br>&nbsp;&nbsp; I am trying to using McChechan's path(<a href="http://mysite.verizon.net/james.mcmechan/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://mysite.verizon.net/james.mcmechan/</a>
)&nbsp; but It is returning this error during the boot : <br><br>./linux ubda=../../../fs/root usb_device_name=/proc/bus/usb/005/009<br>...<br>[42949373.230000]&nbsp; uml-hcd: USB User Mode Host Controller<br>[42949373.230000]&nbsp; uml-hcd: new USB bus registered, assigned bus number 1
<br>[42949373.230000]&nbsp; uml-hcd: startup error -19<br>[42949373.230000]&nbsp; uml-hcd: USB bus 1 deregistered<br>...<br><br>That is the hardware that I'm using : <br>Bus 005 Device 009: ID 08ec:0012 M-Systems Flash Disk Pioneers
<br><br><br>I'm a newbies but I'm trying to understand and correct this problem. <br>&nbsp;Can anyone help me with something? 
<br><br>Thanks <br clear="all"><br>-- <br>-- <br>Francisco Keppler Silva Alecrim <br>Instituto Nokia de Tecnologia (INdT) <br>Open Source Mobile Research Center (OSMRC)


------=_Part_180254_24656869.1158160098915--


--===============0986092183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0986092183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0986092183==--
