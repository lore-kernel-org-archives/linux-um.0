Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lekensteyn@gmail.com>) id 1TPhjc-0000al-RB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Oct 2012 22:41:36 +0000
Received: from mail-we0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TPhjb-0004bd-Vm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Oct 2012 22:41:36 +0000
Received: by mail-we0-f175.google.com with SMTP id t44so892396wey.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 20 Oct 2012 15:41:29 -0700 (PDT)
From: Lekensteyn <lekensteyn@gmail.com>
Date: Sun, 21 Oct 2012 00:41:28 +0200
Message-ID: <5676341.xM9MmW8x3d@al>
In-Reply-To: <CAFLxGvxzz6VKMNanzSx1NqNWwVTn-Fad5oAzT2LdvT5h_RU-jQ@mail.gmail.com>
References: <50796C57.9070303@nod.at> <3527641.WyP7Gpcf54@al>
	<CAFLxGvxzz6VKMNanzSx1NqNWwVTn-Fad5oAzT2LdvT5h_RU-jQ@mail.gmail.com>
MIME-Version: 1.0
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
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net

On Sunday 21 October 2012 00:18:39 richard -rw- weinberger wrote:
> >> I've an idea whats going on.
> > 
> > Great! Meanwhile I've built 3.6.2 with a hack:
> >   sed -i '1,1i#include <sys/resource.h>' arch/um/os-Linux/start_up.c
> >   sed -i 's|siginfo_t \*|struct siginfo *|' arch/um/os-Linux/signal.c
> >
> > (taken from https://aur.archlinux.org/packages/li/linux-usermode/PKGBUILD)
> 
> Nice hack.
> Here on (OpenSUSE glibc 2.16, gcc 4.7) everything builds fine.
> 
> Does Arch have a livecd or something like that where I can reproduce the
> issue?

Arch Linux tries to use as much unpatched source code as possible, any other 
distribution with recent tools should work. AFAIK there is no "ready to use" 
Live CD available from the official site since you start with almost nothing and 
install the programs at your choice (something like Gentoo, but faster). If 
you want to try it, https://www.archlinux.org/ :)

If you do not feel adventurous, try the iso from this topic 
https://bbs.archlinux.org/viewtopic.php?id=150833.

Regards,
Peter

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

