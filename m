Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhlkT-0002zD-1u for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 06:14:29 -0700
Received: from n26.bullet.mail.ukl.yahoo.com ([87.248.110.143])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JhlkP-0004VQ-D0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 06:14:27 -0700
Date: Fri, 4 Apr 2008 13:14:18 +0000 (GMT)
From: Scott Hadley <scottkhadley@yahoo.co.uk>
MIME-Version: 1.0
Message-ID: <447606.76708.qm@web28406.mail.ukl.yahoo.com>
Subject: [uml-devel] Real time Clock access from a Guest Kernel
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1154066839=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============1154066839==
Content-Type: multipart/alternative; boundary="0-4040720-1207314858=:76708"

--0-4040720-1207314858=:76708
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0AI am trying to port a kernel module from a host machine to a guest=
 kernel but am having some troubles with the real time clock.=0A=0AThe kern=
el module uses the mc146818rtc.h driver to access the hardware clock from t=
he CMOS.  Unfortunately the mc146818rtc.h does not appear to be in the asm-=
um directory and so my module will not compile.=0A=0AIs there any other way=
 that I can get the timing signal from the UML kernel?=0AI need a 8 KHz tim=
ing signal for the module to work.=0A=0AWhat would happen if I try and modi=
fy the UM kernel to allow virtual machines direct access to the CMOS clock.=
  I am only reading the time not setting it?  Is this even possible.=0A=0AI=
 would appreciate any help anyone can give me.=0A=0AYours =0A=0A=0AScott Ha=
dley=0A=0A=0A=0A=0A      __________________________________________________=
_________ =0AYahoo! For Good helps you make a difference  =0A=0Ahttp://uk.p=
romotions.yahoo.com/forgood/
--0-4040720-1207314858=:76708
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>Hi,<br><br>I am trying to port a kernel module from a =
host machine to a guest kernel but am having some troubles with the real ti=
me clock.<br><br>The kernel module uses the mc146818rtc.h driver to access =
the hardware clock from the CMOS.&nbsp; Unfortunately the mc146818rtc.h doe=
s not appear to be in the asm-um directory and so my module will not compil=
e.<br><br>Is there any other way that I can get the timing signal from the =
UML kernel?<br>I need a 8 KHz timing signal for the module to work.<br><br>=
What would happen if I try and modify the UM kernel to allow virtual machin=
es direct access to the CMOS clock.&nbsp; I am only reading the time not se=
tting it?&nbsp; Is this even possible.<br><br>I would appreciate any help a=
nyone can give me.<br><br>Yours <br><br><br>Scott
 Hadley<br></div></div><br>=0A=0A=0A=0A      <hr size=3D1> =0AYahoo! for Go=
od helps you <a href=3D"http://us.rd.yahoo.com/mailuk/taglines/isp/control/=
*http://us.rd.yahoo.com/evt=3D51947/*http://uk.promotions.yahoo.com/forgood=
/">make a difference</a></body></html>
--0-4040720-1207314858=:76708--



--===============1154066839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1154066839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1154066839==--


