Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1UEzKn-0007U8-9X
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Mar 2013 09:47:57 +0000
Received: from mail-we0-f181.google.com ([74.125.82.181])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UEzKm-0000TM-B1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Mar 2013 09:47:57 +0000
Received: by mail-we0-f181.google.com with SMTP id t44so3223927wey.26
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 11 Mar 2013 02:47:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130311085321.GB4656@godbox>
References: <20130311085321.GB4656@godbox>
Date: Mon, 11 Mar 2013 10:47:50 +0100
Message-ID: <CAFLxGvxDxjtyGZgzZAfoovfkGpv-fqObGXyYJ63q8Sz=qY4Nfw@mail.gmail.com>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] Linux 3.9-rc2, ARCH=um does not build
To: Dhiru Kholia <dhiru.kholia@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 11, 2013 at 9:53 AM, Dhiru Kholia <dhiru.kholia@gmail.com> wrot=
e:
> Hi,
>
> $ make ARCH=3Dum defconfig
> $ make ARCH=3Dum
> ...
> arch/um/os-Linux/signal.c:18:8: error: conflicting types for =91sig_info=
=92
> In file included from arch/um/os-Linux/signal.c:12:0:
> /repos/linux/arch/um/include/shared/as-layout.h:64:15: note: previous dec=
laration of =91sig_info=92 was here
> arch/um/os-Linux/signal.c:19:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> arch/um/os-Linux/signal.c:19:2: warning: (near initialization for =91sig_=
info[5]=92) [enabled by default]
> arch/um/os-Linux/signal.c:20:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> arch/um/os-Linux/signal.c:20:2: warning: (near initialization for =91sig_=
info[8]=92) [enabled by default]
> arch/um/os-Linux/signal.c:21:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> arch/um/os-Linux/signal.c:21:2: warning: (near initialization for =91sig_=
info[4]=92) [enabled by default]
> arch/um/os-Linux/signal.c:22:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> arch/um/os-Linux/signal.c:22:2: warning: (near initialization for =91sig_=
info[28]=92) [enabled by default]
> arch/um/os-Linux/signal.c:23:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> arch/um/os-Linux/signal.c:23:2: warning: (near initialization for =91sig_=
info[7]=92) [enabled by default]
> arch/um/os-Linux/signal.c:24:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> arch/um/os-Linux/signal.c:24:2: warning: (near initialization for =91sig_=
info[11]=92) [enabled by default]
> arch/um/os-Linux/signal.c:25:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> arch/um/os-Linux/signal.c:25:2: warning: (near initialization for =91sig_=
info[29]=92) [enabled by default]
> arch/um/os-Linux/signal.c:26:2: warning: initialization from incompatible=
 pointer type [enabled by default]
> arch/um/os-Linux/signal.c:26:2: warning: (near initialization for =91sig_=
info[26]=92) [enabled by default]
> arch/um/os-Linux/signal.c:133:1: warning: initialization from incompatibl=
e pointer type [enabled by default]
> arch/um/os-Linux/signal.c:133:1: warning: (near initialization for =91han=
dlers[26]=92) [enabled by default]
> make[1]: *** [arch/um/os-Linux/signal.o] Error 1

A fix for that was already posted to Linus.
It will be visible in 3.9-rc3.

If you then still face the issue, shout! :)

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  =

Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  =

endpoint security space. For insight on selecting the right partner to =

tackle endpoint security challenges, access the full report. =

http://p.sf.net/sfu/symantec-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

