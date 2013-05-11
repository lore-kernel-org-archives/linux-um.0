Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Ub5T6-00084A-Py
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 08:47:52 +0000
Received: from mail-wi0-f174.google.com ([209.85.212.174])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ub5T6-000572-2g
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 May 2013 08:47:52 +0000
Received: by mail-wi0-f174.google.com with SMTP id m6so1335946wiv.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 11 May 2013 01:47:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <518E02FB.6040808@gmx.de>
References: <CAFLxGvwen6WwNoh3iZ2j+dK8iQsxVkjhnvaXjdfXATF+mmwtuw@mail.gmail.com>
	<518E02FB.6040808@gmx.de>
Date: Sat, 11 May 2013 10:47:45 +0200
Message-ID: <CAFLxGvxM_zK11csqpFmVw9q1sPTb1nO0=L5r0AUxf9F4mtfXsg@mail.gmail.com>
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
Subject: Re: [uml-devel] Fwd: Re: [uml-user] WARNING: at
	mm/slab_common.c:376 kmalloc_slab+0x33/0x80()
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: Dave Jones <davej@redhat.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sat, May 11, 2013 at 10:36 AM, Toralf F=F6rster <toralf.foerster@gmx.de>=
 wrote:
>
> Dave,
>
> can you pls answer to Richards question:
>
>         So, we trigger "if (WARN_ON_ONCE(size > KMALLOC_MAX_SIZE))".
>         Now I'm wondering what kind of argument string trinity gave to mo=
unt().
>         How long is it?

Hehe, it's not that easy.
We have to find out.
Can you please add a printk() into copy_mount_string() which prints out
the string size?

--
Thanks,
//richard

---------------------------------------------------------------------------=
---
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and =

their applications. This 200-page book is written by three acclaimed =

leaders in the field. The early access version is available now. =

Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

