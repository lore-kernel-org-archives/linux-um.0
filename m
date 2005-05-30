Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DcpTj-00065z-VZ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 May 2005 11:59:11 -0700
Received: from zrtps0kn.nortelnetworks.com ([47.140.192.55])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DcpTi-0006cl-3j	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 May 2005 11:59:11 -0700
Message-ID: <29D15BBCA340DA4D8146D38B4924FC7A105059@zcarhxm0.corp.nortel.com>
From: "Majid Salame" <msalame@nortel.com>
Subject: RE: [uml-devel] Slower system call with SMP
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C56549.A26CA839"
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
Date: Mon, 30 May 2005 14:58:58 -0400
To: "'stian@nixia.no'" <stian@nixia.no>
Cc: user-mode-linux-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C56549.A26CA839
Content-Type: text/plain



> UML uses multiple processes for it's buisness. 
With Skas UML is just one process as it appears on the Host, or do you mean
something else.

>When host is 
> SMP, these can be mapped to different cpu's, and when 
> interprocess stuff is to occure, cpu's have to sync.
> 
I saw the syscall about 300% slower, it does not make sense due to
interprocess.
IT should not be that slow, unless missing UML implementation

> Also, some few kernel things is slower on SMP, while 
> user-space things that are not related, and multithreaded 
> apps run faster.
> 
> Stian
> 
> 

------_=_NextPart_001_01C56549.A26CA839
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<META NAME="Generator" CONTENT="MS Exchange Server version 5.5.2658.2">
<TITLE>RE: [uml-devel] Slower system call with SMP</TITLE>
</HEAD>
<BODY>
<BR>
<BR>

<P><FONT SIZE=2>&gt; UML uses multiple processes for it's buisness. </FONT>
<BR><FONT SIZE=2>With Skas UML is just one process as it appears on the Host, or do you mean something else.</FONT>
</P>

<P><FONT SIZE=2>&gt;When host is </FONT>
<BR><FONT SIZE=2>&gt; SMP, these can be mapped to different cpu's, and when </FONT>
<BR><FONT SIZE=2>&gt; interprocess stuff is to occure, cpu's have to sync.</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>I saw the syscall about 300% slower, it does not make sense due to interprocess.</FONT>
<BR><FONT SIZE=2>IT should not be that slow, unless missing UML implementation</FONT>
</P>

<P><FONT SIZE=2>&gt; Also, some few kernel things is slower on SMP, while </FONT>
<BR><FONT SIZE=2>&gt; user-space things that are not related, and multithreaded </FONT>
<BR><FONT SIZE=2>&gt; apps run faster.</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; Stian</FONT>
<BR><FONT SIZE=2>&gt; </FONT>
<BR><FONT SIZE=2>&gt; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C56549.A26CA839--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
