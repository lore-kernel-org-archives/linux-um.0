Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sebastien.fremal@gmail.com>) id 1WpHu0-0007Ru-2I
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 May 2014 13:58:52 +0000
Received: from mail-oa0-f50.google.com ([209.85.219.50])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WpHty-0005JK-BN
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 May 2014 13:58:51 +0000
Received: by mail-oa0-f50.google.com with SMTP id i7so9565529oag.23
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 27 May 2014 06:58:44 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?U8OpYmFzdGllbiBGcsOpbWFs?= <sebastien.fremal@gmail.com>
Date: Tue, 27 May 2014 15:58:24 +0200
Message-ID: <CAOV6k-BK_oQQ9MwQ1ggp==QPh-vQ=_Kz7j0rVquqAeuoyjr=4w@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4030680064919585869=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Skas Mode : How does it work ?
To: user-mode-linux-devel@lists.sourceforge.net

--===============4030680064919585869==
Content-Type: multipart/alternative; boundary=001a11c20c5619155104fa621878

--001a11c20c5619155104fa621878
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'm a PhD Student studying virtualization methods. I found an article on
UML explaining how it works in TT mode (
https://www.kernel.org/doc/ols/2001/uml.pdf).

I read that there is now a skas mode fixing security and performance
issuses of the TT mode (http://user-mode-linux.sourceforge.net/old/skas.htm=
l),
but I don't find informations on how it works. It seems that the tracing
thread doesn't exist in skas mode. I'm searching informations on how this
system works, especially how system calls are virtualized. Is this
information available somewhere ?

Best regards,

S=C3=A9bastien Fr=C3=A9mal

--001a11c20c5619155104fa621878
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hello,<br><br></div>I&#39;m a PhD Student s=
tudying virtualization methods. I found an article on UML explaining how it=
 works in TT mode (<a href=3D"https://www.kernel.org/doc/ols/2001/uml.pdf">=
https://www.kernel.org/doc/ols/2001/uml.pdf</a>).<br>

<br></div>I read that there is now a skas mode fixing security and performa=
nce issuses of the TT mode (<a href=3D"http://user-mode-linux.sourceforge.n=
et/old/skas.html">http://user-mode-linux.sourceforge.net/old/skas.html</a>)=
, but I don&#39;t find informations on how it works. It seems that the trac=
ing thread doesn&#39;t exist in skas mode. I&#39;m searching informations o=
n how this system works, especially how system calls are virtualized. Is th=
is information available somewhere ?<br>

<br></div>Best regards,<br><br>S=C3=A9bastien Fr=C3=A9mal<br></div>

--001a11c20c5619155104fa621878--


--===============4030680064919585869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The best possible search technologies are now affordable for all companies.
Download your FREE open source Enterprise Search Engine today!
Our experts will assist you in its installation for $59/mo, no commitment.
Test it for FREE on our Cloud platform anytime!
http://pubads.g.doubleclick.net/gampad/clk?id=145328191&iu=/4140/ostg.clktrk
--===============4030680064919585869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============4030680064919585869==--


