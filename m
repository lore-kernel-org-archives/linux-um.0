Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lekensteyn@gmail.com>) id 1TPhCd-0001UC-Fr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Oct 2012 22:07:31 +0000
Received: from mail-we0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TPhCb-0006uG-0u
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Oct 2012 22:07:31 +0000
Received: by mail-we0-f175.google.com with SMTP id t44so884834wey.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 20 Oct 2012 15:07:22 -0700 (PDT)
From: Lekensteyn <lekensteyn@gmail.com>
Date: Sun, 21 Oct 2012 00:07:11 +0200
Message-ID: <3527641.WyP7Gpcf54@al>
In-Reply-To: <50830FBA.8040906@nod.at>
References: <50796C57.9070303@nod.at> <1610795.Cjb5TqF7v9@al>
	<50830FBA.8040906@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi Richard,

On Saturday 20 October 2012 22:55:22 Richard Weinberger wrote:
> Is this glibc-2.17?
This is glibc 2.16 on Arch Linux.

> I've an idea whats going on.
Great! Meanwhile I've built 3.6.2 with a hack:
  sed -i '1,1i#include <sys/resource.h>' arch/um/os-Linux/start_up.c
  sed -i 's|siginfo_t \*|struct siginfo *|' arch/um/os-Linux/signal.c
(taken from https://aur.archlinux.org/packages/li/linux-usermode/PKGBUILD)

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

