Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Rkx9e-000064-7l
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Jan 2012 12:19:46 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rkx9Y-0007lI-I7
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Jan 2012 12:19:46 +0000
Received: by obcwn6 with SMTP id wn6so1124210obc.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 11 Jan 2012 04:19:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201201111314.32937.toralf.foerster@gmx.de>
References: <201201111314.32937.toralf.foerster@gmx.de>
Date: Wed, 11 Jan 2012 13:19:34 +0100
Message-ID: <CAFLxGvwXtinKJSFeD=-YjT9oLuhFSK_0HASjTD_3ib531RxbAA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] current kernel (git version
	linux-v3.2-6100-ge343a89) crashes
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

2012/1/11 Toralf F=F6rster <toralf.foerster@gmx.de>:
> Hello,
>
> with a recent kernel (pre-rc1) I realized this crash and wondering
> whether it is worth to bisect or if there's already a fix flying around :
>
>

Could be this one:
http://marc.info/?l=3Dlinux-kernel&m=3D132616456304183&w=3D2
http://marc.info/?l=3Dlinux-kernel&m=3D132616483904249&w=3D2

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual =

desktops for less than the cost of PCs and save 60% on VDI infrastructure =

costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

