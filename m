Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <balbir@linux.vnet.ibm.com>) id 1L6cbP-0004Ue-DT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Nov 2008 03:04:07 +0000
Received: from e23smtp01.au.ibm.com ([202.81.18.162])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L6cbN-0004um-Dk
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Nov 2008 03:04:07 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id mAU340Ea024112
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 30 Nov 2008 14:04:00 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAU31VFc311716 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 30 Nov 2008 14:01:31 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAU31UA8009342 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 30 Nov 2008 14:01:31 +1100
Date: Sun, 30 Nov 2008 08:31:28 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
Message-ID: <20081130030128.GA8948@balbir.in.ibm.com>
References: <20081129100830.GA24128@balbir.in.ibm.com>
	<2375c9f90811290503s1b4cb9aelaecccc680c6e37d0@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2375c9f90811290503s1b4cb9aelaecccc680c6e37d0@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH][UML] Boot broken due to buffer overrun
Reply-To: balbir@linux.vnet.ibm.com
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
To: Am?rico Wang <xiyou.wangcong@gmail.com>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

* WANG Cong <xiyou.wangcong@gmail.com> [2008-11-29 13:03:42]:

> On Sat, Nov 29, 2008 at 10:08 AM, Balbir Singh
> <balbir@linux.vnet.ibm.com> wrote:
> >
> > mconsole_init() passed 256 bytes as length in os_create_unix_socket, while
> > the sizeof UNIX_PATH_MAX is 108. This patch fixes that problem and avoids
> > a big overrun bug reported on UML bootup.
> >
> > Reported-by: Vikas K Managutte <vikki.km@gmail.com>
> > Reported-by: Sarvesh Kumar Lal Das <skldas@gmail.com>
> > Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>
> > ---
> >
> >  arch/um/drivers/mconsole_kern.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff -puN arch/um/drivers/mconsole_kern.c~fix-uml-buggy-socket-creation arch/um/drivers/mconsole_kern.c
> > --- linux-2.6.28-rc6/arch/um/drivers/mconsole_kern.c~fix-uml-buggy-socket-creation      2008-11-29 15:29:04.000000000 +0530
> > +++ linux-2.6.28-rc6-balbir/arch/um/drivers/mconsole_kern.c     2008-11-29 15:32:23.000000000 +0530
> > @@ -16,6 +16,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/utsname.h>
> > +#include <linux/socket.h>
> > +#include <linux/un.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/mutex.h>
> >  #include <asm/uaccess.h>
> > @@ -785,7 +787,7 @@ static int __init mconsole_init(void)
> >        /* long to avoid size mismatch warnings from gcc */
> >        long sock;
> >        int err;
> > -       char file[256];
> > +       char file[UNIX_PATH_MAX];
> >
> 
> 
> Aha, good spot!
> 
> Please also correct the length of mconsole_socket_name.
>

I did not fix that with UNIX_PATH_MAX since, mconsole_user.c already includes
sys/un.h and sys/socket.h and I did not want to include kernel headers
linux/socket.h and linux/un.h there. I could have hard-coded those
values to 108, but I just let it be for now. If you feel strongly
about it, it can be done.
 
> Anyway,
> 
> Reviewed-by: WANG Cong <wangcong@zeuux.org>

Thanks!

-- 
	Balbir

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
