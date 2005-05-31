Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dd7w2-0003PG-99	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 07:41:38 -0700
Received: from zrtps0kp.nortelnetworks.com ([47.140.192.56])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dd7w0-0002H5-Hg	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 07:41:38 -0700
Message-ID: <29D15BBCA340DA4D8146D38B4924FC7A10505B@zcarhxm0.corp.nortel.com>
From: "Majid Salame" <msalame@nortel.com>
Subject: RE: [uml-devel] Slower system call with SMP
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C565EE.D661107C"
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
Date: Tue, 31 May 2005 10:41:32 -0400
To: 'Jeff Dike' <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C565EE.D661107C
Content-Type: text/plain

Yes. And I am trying fork stress test.

Majid.

> -----Original Message-----
> From: Jeff Dike [mailto:jdike@addtoit.com] 
> Sent: Tuesday, May 31, 2005 9:58 AM
> To: Salame, Majid [CAR:2V62:EXCH]
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Subject: Re: [uml-devel] Slower system call with SMP
> 
> 
> > The cost of a system call it seems to be higher when
> > Running a RHE host with dual CPU (SMP turned on) and the image is 
> > patched with skas patch.
> > 
> > Doe that make sense ? Doing the same test by disabling SMP on the 
> > host, and results are much faster.
> 
> What exactly was the test?  A getpid loop?
> 
> 				Jeff
> 
> 

------_=_NextPart_001_01C565EE.D661107C
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.2">
<TITLE>RE: [uml-devel] Slower system call with SMP</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Yes. And I am trying fork stress test.</FONT>
</P>

<P><FONT SIZE=3D2>Majid.</FONT>
</P>

<P><FONT SIZE=3D2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=3D2>&gt; From: Jeff Dike [<A =
HREF=3D"mailto:jdike@addtoit.com">mailto:jdike@addtoit.com</A>] </FONT>
<BR><FONT SIZE=3D2>&gt; Sent: Tuesday, May 31, 2005 9:58 AM</FONT>
<BR><FONT SIZE=3D2>&gt; To: Salame, Majid [CAR:2V62:EXCH]</FONT>
<BR><FONT SIZE=3D2>&gt; Cc: =
user-mode-linux-devel@lists.sourceforge.net</FONT>
<BR><FONT SIZE=3D2>&gt; Subject: Re: [uml-devel] Slower system call =
with SMP</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; The cost of a system call it seems to be =
higher when</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; Running a RHE host with dual CPU (SMP =
turned on) and the image is </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; patched with skas patch.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; Doe that make sense ? Doing the same test =
by disabling SMP on the </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; host, and results are much faster.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; What exactly was the test?&nbsp; A getpid =
loop?</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jeff</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C565EE.D661107C--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
