Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <tschmelcher@google.com>) id 1TsOUs-0002KF-JU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jan 2013 02:00:58 +0000
Received: from mail-ia0-f178.google.com ([209.85.210.178])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TsOUr-00047w-U3
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jan 2013 02:00:58 +0000
Received: by mail-ia0-f178.google.com with SMTP id k25so16985952iah.37
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 07 Jan 2013 18:00:52 -0800 (PST)
MIME-Version: 1.0
From: Tristan Schmelcher <tschmelcher@google.com>
Date: Mon, 7 Jan 2013 17:55:29 -0800
Message-ID: <CADNZ+wT==gf=MLjeqx5J1Lw3EEmNOmVjWyVrR6jh4QoTM+xoxw@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0715830275862952076=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] File corruption with hostfs and GNU Gold linker
To: user-mode-linux-devel@lists.sourceforge.net

--===============0715830275862952076==
Content-Type: multipart/alternative; boundary=14dae9340a69b4081a04d2bd3e7b

--14dae9340a69b4081a04d2bd3e7b
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I am using UML as part of a hermetic build system and I have encountered an
odd file corruption problem with the GNU Gold linker. When linking a binary
inside a UML VM with Gold, if the output path is on a hostfs mount then all
bytes in the output file produced by Gold are zero. However, the size of
the output file is correct and the debugging output from running gold with
--debug suggests that everything is working, so it seems like the content
is being produced by Gold correctly but the file ends up containing all
zeros instead. It has happened 100% of the time so far and it seems to be
independent of the linker command line or input files.

Are there any known issues where hostfs file content could end up as all
zeros?

Repros on both 2.6.34.13 and 3.7.1. I am using GNU binutils 2.21.1.

Much thanks for any help,

Tristan

--14dae9340a69b4081a04d2bd3e7b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style>Hello,</div><div class=
=3D"gmail_default" style><br></div><div class=3D"gmail_default" style>I am =
using UML as part of a hermetic build system and I have encountered an odd =
file corruption problem with the GNU Gold linker. When linking a binary ins=
ide a UML VM with Gold, if the output path is on a hostfs mount then all by=
tes in the output file produced by Gold are zero. However, the size of the =
output file is correct and the debugging output from running gold with --de=
bug suggests that everything is working, so it seems like the content is be=
ing produced by Gold correctly but the file ends up containing all zeros in=
stead. It has happened 100% of the time so far and it seems to be independe=
nt of the linker command line or input files.</div>

<div class=3D"gmail_default" style><br></div><div class=3D"gmail_default" s=
tyle>Are there any known issues where hostfs file content could end up as a=
ll zeros?</div><div class=3D"gmail_default" style><br></div><div class=3D"g=
mail_default" style>

Repros on both 2.6.34.13 and 3.7.1. I am using GNU binutils=A02.21.1.</div>=
<div class=3D"gmail_default" style><br></div><div class=3D"gmail_default" s=
tyle>Much thanks for any help,</div><div class=3D"gmail_default" style><br>=
</div>

<div class=3D"gmail_default" style>Tristan</div></div>

--14dae9340a69b4081a04d2bd3e7b--


--===============0715830275862952076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Master SQL Server Development, Administration, T-SQL, SSAS, SSIS, SSRS
and more. Get SQL Server skills now (including 2012) with LearnDevNow -
200+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only - learn more at:
http://p.sf.net/sfu/learnmore_122512
--===============0715830275862952076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0715830275862952076==--


