Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsbZd-0006uq-GO for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jan 2005 22:50:13 -0800
Received: from [202.54.110.230] (helo=ngate.noida.hcltech.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CsbZc-0002mh-In
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jan 2005 22:50:13 -0800
Received: from exch-03.noida.hcltech.com (exch-01 [204.160.254.57])
	by ngate.noida.hcltech.com (8.12.5/8.12.5) with ESMTP id j0N6setd012446
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 23 Jan 2005 12:25:03 +0530
Message-ID: <267988DEACEC5A4D86D5FCD780313FBB03B12C4B@exch-03.noida.hcltech.com>
From: "Vaibhav  Sharma, Noida" <Vaibhavs@noida.hcltech.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C50117.47A094E0"
Subject: [uml-devel] memory
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
Date: Sun, 23 Jan 2005 12:16:34 +0530
To: user-mode-linux-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C50117.47A094E0
Content-Type: text/plain

Hi,
I have to build a simulator, to check the scalability limits in memory
management of linux. For this, the simulator  will provide a large amount of
RAM (in GBs), even if the amout of physical memory is only 512MB. 

Can UML be used for this purpose? I had seen the "mem" option in the kernel
switches option of UML. Can UML simulate such a case? If it does, how UML
handles this? Specifically, can the UML kernel allocate all this amount of
memory (leaving aside the page faults which will be generated in case of
read/write requests to the allocated pages, for it has to use the actual
RAM)? Say, for example if I allocate 4 GB, will the UML kernel allocate all
the amount in the simulated RAM. (maybe it does it in the some swap, or the
/tmp, as the documentation says for the "mem" usage
<http://user-mode-linux.sourceforge.net/switches.html
<http://user-mode-linux.sourceforge.net/switches.html> > .  

If I have wrong interpretation of the "mem" option in UML, please do correct
me. 

TIA, 
Vaibhav 

------_=_NextPart_001_01C50117.47A094E0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.2">
<TITLE>memory</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi,</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">I have to build a simulator, to check =
the scalability limits in memory management of linux. For this, the =
simulator&nbsp; will provide a large amount of RAM (in GBs), even if =
the amout of physical memory is only 512MB. </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Can UML be used for this purpose? I =
had seen the &quot;mem&quot; option in the kernel switches option of =
UML. Can UML simulate such a case? If it does, how UML handles this? =
Specifically, can the UML kernel allocate all this amount of memory =
(leaving aside the page faults which will be generated in case of =
read/write requests to the allocated pages, for it has to use the =
actual RAM)? Say, for example if I allocate 4 GB, will the UML kernel =
allocate all the amount in the simulated RAM. (maybe it does it in the =
some swap, or the /tmp, as the documentation says for the =
&quot;mem&quot; usage &lt;</FONT><A =
HREF=3D"http://user-mode-linux.sourceforge.net/switches.html"><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">http://user-mode-linux.sourceforge.net/switches.html</FON=
T></U></A><FONT SIZE=3D2 FACE=3D"Arial">&gt; .&nbsp; </FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If I have wrong interpretation of the =
&quot;mem&quot; option in UML, please do correct me. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">TIA, </FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">Vaibhav </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C50117.47A094E0--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
