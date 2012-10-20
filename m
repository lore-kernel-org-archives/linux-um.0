Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1TPhNW-0001wA-V2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Oct 2012 22:18:46 +0000
Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TPhNW-0001L3-5U
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Oct 2012 22:18:46 +0000
Received: by mail-bk0-f47.google.com with SMTP id jk7so487467bkc.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 20 Oct 2012 15:18:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3527641.WyP7Gpcf54@al>
References: <50796C57.9070303@nod.at> <1610795.Cjb5TqF7v9@al>
	<50830FBA.8040906@nod.at> <3527641.WyP7Gpcf54@al>
Date: Sun, 21 Oct 2012 00:18:39 +0200
Message-ID: <CAFLxGvxzz6VKMNanzSx1NqNWwVTn-Fad5oAzT2LdvT5h_RU-jQ@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] linux-3.6.x ARCH=um will not build
To: Lekensteyn <lekensteyn@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 21, 2012 at 12:07 AM, Lekensteyn <lekensteyn@gmail.com> wrote:
> Hi Richard,
>
> On Saturday 20 October 2012 22:55:22 Richard Weinberger wrote:
>> Is this glibc-2.17?
> This is glibc 2.16 on Arch Linux.
>
>> I've an idea whats going on.
> Great! Meanwhile I've built 3.6.2 with a hack:
>   sed -i '1,1i#include <sys/resource.h>' arch/um/os-Linux/start_up.c
>   sed -i 's|siginfo_t \*|struct siginfo *|' arch/um/os-Linux/signal.c
> (taken from https://aur.archlinux.org/packages/li/linux-usermode/PKGBUILD)

Nice hack. ;)
Here on (OpenSUSE glibc 2.16, gcc 4.7) everything builds fine.

Does Arch have a livecd or something like that where I can reproduce the issue?

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

