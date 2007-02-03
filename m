Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HDDbQ-0005eu-8l for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Feb 2007 21:38:20 -0800
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]
	helo=pd4mo3so.prod.shaw.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HDDbO-0001ks-PJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Feb 2007 21:38:20 -0800
Received: from pd3mr2so.prod.shaw.ca
	(pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JCV00934GXJBJ70@l-daemon> for
	user-mode-linux-devel@lists.sourceforge.net; Fri,
	02 Feb 2007 22:36:55 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JCV00FYZGXI2D51@pd3mr2so.prod.shaw.ca> for
	user-mode-linux-devel@lists.sourceforge.net; Fri,
	02 Feb 2007 22:36:55 -0700 (MST)
Received: from yellowstone ([70.72.231.95])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JCV00596GXGXDG0@l-daemon> for
	user-mode-linux-devel@lists.sourceforge.net; Fri,
	02 Feb 2007 22:36:54 -0700 (MST)
Date: Fri, 02 Feb 2007 22:36:51 -0700
From: Mohammad Jawwad <mjawwad@shaw.ca>
Message-id: <000001c74755$4f135dd0$ed3a1970$@ca>
MIME-version: 1.0
Content-language: en-us
Subject: [uml-devel] adding a system call in uml
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0884591304=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

This is a multipart message in MIME format.

--===============0884591304==
Content-type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C7471A.A2B485D0"
Content-language: en-us

This is a multipart message in MIME format.

------=_NextPart_000_0001_01C7471A.A2B485D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

How does one add a system call to user mode linux?

I followed the instructions here:=

http://user-mode-linux.sourceforge.net/lksct/

 

Instead of using his stub(which dosent work) I used this one:

 

#include <stdio.h>

#include <sys/syscall.h>

#include <linux/unistd.h>

 

int main()

{

    syscall(253);   // I assigned number 253 to my system call in unistd.h

    return 0;

}

 

The program compiles but dosent print out the the output from the printk()
statement.

Has anybody successfully installed a system call in uml?

 

Thank you


------=_NextPart_000_0001_01C7471A.A2B485D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hello,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>How does one add a system call to user mode =
linux?<o:p></o:p></p>

<p class=3DMsoNormal>I followed the instructions here:=3D<o:p></o:p></p>

<p class=3DMsoNormal><a =
href=3D"http://user-mode-linux.sourceforge.net/lksct/">http://user-mode-l=
inux.sourceforge.net/lksct/</a><o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Instead of using his stub(which dosent work) I used =
this
one:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>#include &lt;stdio.h&gt;<o:p></o:p></p>

<p class=3DMsoNormal>#include &lt;sys/syscall.h&gt;<o:p></o:p></p>

<p class=3DMsoNormal>#include &lt;linux/unistd.h&gt;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>int main()<o:p></o:p></p>

<p class=3DMsoNormal>{<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp;&nbsp; syscall(253);&nbsp;&nbsp; // I =
assigned number 253 to my system
call in unistd.h<o:p></o:p></p>

<p class=3DMsoNormal>&nbsp;&nbsp; &nbsp;return 0;<o:p></o:p></p>

<p class=3DMsoNormal>}<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>The program compiles but dosent print out the the =
output
from the printk() statement.<o:p></o:p></p>

<p class=3DMsoNormal>Has anybody successfully installed a system call in =
uml?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thank you<o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0001_01C7471A.A2B485D0--



--===============0884591304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0884591304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0884591304==--

