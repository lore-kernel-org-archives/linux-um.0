Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tschmelcher@google.com>) id 1TyrkS-0004Bu-4o
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Jan 2013 22:27:48 +0000
Received: from mail-oa0-f43.google.com ([209.85.219.43])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TyrkR-0001xY-2c
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Jan 2013 22:27:48 +0000
Received: by mail-oa0-f43.google.com with SMTP id n1so932388oag.30
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 25 Jan 2013 14:27:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130108223151.368c5c49@spider.haslach.nod.at>
References: <CADNZ+wT==gf=MLjeqx5J1Lw3EEmNOmVjWyVrR6jh4QoTM+xoxw@mail.gmail.com>
	<20130108074356.03f539c2@spider.haslach.nod.at>
	<CADNZ+wRfo6W_x4bg4PX7=yDYJ3Y1e6En-+0gHmzNcPKNs3YLkA@mail.gmail.com>
	<CADNZ+wSkpb6uXRrK__xopF1TPVtANXid9AHukSxkWZ3r6ZnvGg@mail.gmail.com>
	<20130108223151.368c5c49@spider.haslach.nod.at>
From: Tristan Schmelcher <tschmelcher@google.com>
Date: Fri, 25 Jan 2013 14:27:21 -0800
Message-ID: <CADNZ+wTwFtr5dMhBBQd7jDObe30w3JgnVGk+-kqNiH_j3yw+8A@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3849922004810787884=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] File corruption with hostfs and GNU Gold linker
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

--===============3849922004810787884==
Content-Type: multipart/alternative; boundary=e89a8f64790383e21304d4246fcc

--e89a8f64790383e21304d4246fcc
Content-Type: text/plain; charset=ISO-8859-1

Hello again, Richard. Wondering if you have a rough patch that you'd like
me to try out. If not, I'd be happy to work on the fix if you could give me
some pointers to where the issue is in the hostfs code.


On 8 January 2013 13:31, Richard Weinberger <richard@nod.at> wrote:

> Am Tue, 8 Jan 2013 13:30:09 -0800
> schrieb Tristan Schmelcher <tschmelcher@google.com>:
>
> > Here's a minimal test program that repros the problem.
>
> I wrote already a test program. :)
> Currently fixing hostfs...
>
> Thanks,
> //richard
>

--e89a8f64790383e21304d4246fcc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello again, Richard. Wondering if you have a rough patch =
that you&#39;d like me to try out. If not, I&#39;d be happy to work on the =
fix if you could give me some pointers to where the issue is in the hostfs =
code.</div>

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On 8 January =
2013 13:31, Richard Weinberger <span dir=3D"ltr">&lt;<a href=3D"mailto:rich=
ard@nod.at" target=3D"_blank">richard@nod.at</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">

Am Tue, 8 Jan 2013 13:30:09 -0800<br>
schrieb Tristan Schmelcher &lt;<a href=3D"mailto:tschmelcher@google.com">ts=
chmelcher@google.com</a>&gt;:<br>
<div class=3D"im"><br>
&gt; Here&#39;s a minimal test program that repros the problem.<br>
<br>
</div>I wrote already a test program. :)<br>
Currently fixing hostfs...<br>
<br>
Thanks,<br>
//richard<br>
</blockquote></div><br></div>

--e89a8f64790383e21304d4246fcc--


--===============3849922004810787884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
--===============3849922004810787884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3849922004810787884==--


