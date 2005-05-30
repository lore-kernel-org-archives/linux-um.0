Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DcoTA-00030k-9D	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 May 2005 10:54:32 -0700
Received: from zcars04f.nortelnetworks.com ([47.129.242.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DcoT5-0005vz-Vb	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 May 2005 10:54:31 -0700
Received: from zrtpd0jn.us.nortel.com (zrtpd0jn.us.nortel.com [47.140.202.35])
	id j4UHsJP16343	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 30 May 2005 13:54:19 -0400 (EDT)
Message-ID: <29D15BBCA340DA4D8146D38B4924FC7A105057@zcarhxm0.corp.nortel.com>
From: "Majid Salame" <msalame@nortel.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C56540.97E6B129"
Subject: [uml-devel] Slower system call with SMP
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
Date: Mon, 30 May 2005 13:54:15 -0400
To: user-mode-linux-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C56540.97E6B129
Content-Type: text/plain


The cost of a system call it seems to be higher when
Running a RHE host with dual CPU (SMP turned on) and the image is patched
with skas patch.

Doe that make sense ? Doing the same test by disabling SMP on the host, and
results are much faster.
NOTE SMP is turned off for the UML.

Thanks,
Majid.



------_=_NextPart_001_01C56540.97E6B129
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">
<META NAME="Generator" CONTENT="MS Exchange Server version 5.5.2658.2">
<TITLE>Slower system call with SMP</TITLE>
</HEAD>
<BODY>
<BR>

<P><FONT SIZE=2>The cost of a system call it seems to be higher when</FONT>
<BR><FONT SIZE=2>Running a RHE host with dual CPU (SMP turned on) and the image is patched with skas patch.</FONT>
</P>

<P><FONT SIZE=2>Doe that make sense ? Doing the same test by disabling SMP on the host, and results are much faster.</FONT>
<BR><FONT SIZE=2>NOTE SMP is turned off for the UML.</FONT>
</P>

<P><FONT SIZE=2>Thanks,</FONT>
<BR><FONT SIZE=2>Majid.</FONT>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C56540.97E6B129--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
