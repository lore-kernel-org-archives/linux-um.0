Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sebastien.fremal@gmail.com>) id 1WrOC5-0002PY-TN
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Jun 2014 09:06:13 +0000
Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WrOC5-0005ly-2X
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Jun 2014 09:06:13 +0000
Received: by mail-oa0-f47.google.com with SMTP id i7so4343344oag.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 02 Jun 2014 02:06:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvw+0L2SSXGzddOgG56g1avyuU4EvUG_peMowe65fh02pQ@mail.gmail.com>
References: <CAOV6k-BK_oQQ9MwQ1ggp==QPh-vQ=_Kz7j0rVquqAeuoyjr=4w@mail.gmail.com>
	<CAFLxGvw+0L2SSXGzddOgG56g1avyuU4EvUG_peMowe65fh02pQ@mail.gmail.com>
From: =?UTF-8?B?U8OpYmFzdGllbiBGcsOpbWFs?= <sebastien.fremal@gmail.com>
Date: Mon, 2 Jun 2014 11:05:47 +0200
Message-ID: <CAOV6k-Br0_aa6+3CDZVcqpOwY+YQR7BE8L2kUTSusp8W-3bBKw@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6490524225841689187=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Skas Mode : How does it work ?
To: Richard Weinberger <richard.weinberger@gmail.com>, user-mode-linux-devel@lists.sourceforge.net

--===============6490524225841689187==
Content-Type: multipart/alternative; boundary=e89a8ff1ceb8a6ad4304fad6b468

--e89a8ff1ceb8a6ad4304fad6b468
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for these informations, it helps me to understand how skas works.
I read on the skas website that "This also provides a noticable speedup by
eliminating the signal delivery that used to happen for every UML system
call." I read that UML processes (in TT mode) in user space were controlled
with signals (especially to do the transition between the user mode and the
kernel mode). The presentation of skas suggests that this transition and
communications between UML and its processes are not executed anymore with
signals. Do you know what is used instead ?

Best regards,

Fr=C3=A9mal S=C3=A9bastien

--e89a8ff1ceb8a6ad4304fad6b468
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>Thank you for these informations=
, it helps me to understand how skas works. I read on the skas website that=
 &quot;This also provides a noticable speedup by eliminating the signal del=
ivery that used to happen for every UML system call.&quot; I read that UML =
processes (in TT mode) in user space were controlled with signals (especial=
ly to do the transition between the user mode and the kernel mode). The pre=
sentation of skas suggests that this transition and communications between =
UML and its processes are not executed anymore with signals. Do you know wh=
at is used instead ?</div>

<div><br></div><div>Best regards,</div><div><br></div><div>Fr=C3=A9mal S=C3=
=A9bastien</div></div>

--e89a8ff1ceb8a6ad4304fad6b468--


--===============6490524225841689187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
--===============6490524225841689187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6490524225841689187==--


