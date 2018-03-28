Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <richard@nod.at>) id 1f19AD-0002Pa-GQ
 for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 28 Mar 2018 11:22:45 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f19AA-00DSpX-8O for user-mode-linux-devel@lists.sourceforge.net;
 Wed, 28 Mar 2018 11:22:45 +0000
From: Richard Weinberger <richard@nod.at>
Date: Wed, 28 Mar 2018 13:04:14 +0200
Message-ID: <3115476.io4Xh1L8hP@blindfold>
In-Reply-To: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com>
References: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] UML hangs with hrtimer test module
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Joel Fernandes <agnel.joel@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Am Mittwoch, 28. M=E4rz 2018, 12:28:02 CEST schrieb Joel Fernandes:
> Hi,
> =

> I wrote a kernel module to play with hrtimer subsystem and it hangs
> with UML, Any ideas on why it may be hanging? It doesn't hang on any
> of my other machines. Hopefully I'm not doing something stupid, but I
> don't think I am..
> =

> It appears the timer handler does fire. However, the UML process is
> continously doing a kill(SIGALRM) to the host, and the shell hangs.
> Here's the continous strace output of UML's process at the time of the
> hang: https://hastebin.com/ikehadapon.sql
> =

> To build UML, I do:
> make ARCH=3Dum x86_64_defconfig
> =

> UML kernel version is v4.16-rc4
> =

> Here's the module I'm loading:

Please share the full sources that compile.
The I can have a look.

Thanks,
//richard

---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

