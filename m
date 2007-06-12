Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hy47h-0000t5-AD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2007 04:01:17 -0700
Received: from winmain.rutgers.edu ([128.6.230.194] helo=liman.rutgers.edu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hy47g-0003m3-P9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jun 2007 04:01:17 -0700
From: "George Hadjichristofi" <gh@winlab.rutgers.edu>
Date: Tue, 12 Jun 2007 07:01:05 -0400
Message-ID: <010701c7ace0$f98b0d80$d8c8a8c0@angel4>
MIME-Version: 1.0
Subject: [uml-devel] UDP vs. TCP performance over UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1367514456=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 'shruti singhal' <shruti20@gmail.com>

This is a multi-part message in MIME format.

--===============1367514456==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0108_01C7ACBF.72796D80"

This is a multi-part message in MIME format.

------=_NextPart_000_0108_01C7ACBF.72796D80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear All,

 

We are doing some UML performance testing and we are getting some
non-sensible UDP statistics.

We have deployed the following network of two nodes:

A--------B

 

Node A is connected to node B via a wired link (100 Mbps) and node A is
running one UML instance. 

We used the Iperf traffic generator to execute performance measurements for
both TCP and UDP.

 

Measurements:

 When we use TCP the throughput is 100 Mbps from the UML instance of node A
to the host kernel of node B and 100 Mbps from the host kernel of node A to
the host kernel of node B.  However, when we use UDP the throughput is only
26 Mbps from the UML instance on node A to the host kernel of node B, but
100 Mbps from the host kernel of node A to the host kernel of node B.  We
also notice that a large number of packets were dropped in the case of UDP
over UML.

 

What is the reason that UDP throughput is so much lower than TCP?

Why are packets being dropped given that Iperf is blocking? 

 

We appreciate any guidance on this matter.

 

Regards,

George Hadjichristofi

WINLAB, Rutgers University

 


------=_NextPart_000_0108_01C7ACBF.72796D80
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceType"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"PlaceName"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
p.MsoBodyTextIndent, li.MsoBodyTextIndent, div.MsoBodyTextIndent
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:.25in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
p.StyleBodyTextIndentFirstline0After6pt, =
li.StyleBodyTextIndentFirstline0After6pt, =
div.StyleBodyTextIndentFirstline0After6pt
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:6.0pt;
	margin-left:0in;
	text-align:justify;
	font-size:10.0pt;
	font-family:"Times New Roman";}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Dear All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We are doing some UML performance testing and we are =
getting
some non-sensible UDP statistics.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We have deployed the following network of two =
nodes:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>A--------B<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Node A is connected to node B via a wired link (100 =
Mbps)
and node A is running one UML instance. <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We used the Iperf traffic generator to execute =
performance
measurements for both TCP and UDP.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Measurements:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;When we use TCP the throughput is 100 Mbps from =
the
UML instance of node A to the host kernel of node B and 100 Mbps from =
the host
kernel of node A to the host kernel of node B. &nbsp;However, when we =
use UDP
the throughput is only 26 Mbps from the UML instance on node A to the =
host
kernel of node B, but 100 Mbps from the host kernel of node A to the =
host
kernel of node B. &nbsp;We also notice that a large number of packets =
were
dropped in the case of UDP over UML.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>What is the reason that UDP throughput is so much =
lower than
TCP?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Why are packets being dropped given that Iperf is =
blocking? <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We appreciate any guidance on this =
matter.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Regards,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>George Hadjichristofi<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>WINLAB, <st1:place w:st=3D"on"><st1:PlaceName =
w:st=3D"on">Rutgers</st1:PlaceName>
 <st1:PlaceType =
w:st=3D"on">University</st1:PlaceType></st1:place><o:p></o:p></span></fon=
t></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0108_01C7ACBF.72796D80--



--===============1367514456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1367514456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1367514456==--


