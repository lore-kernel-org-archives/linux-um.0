Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKJY8-0006qY-HG	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 10:47:28 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKJY7-0007qJ-WA
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 10:47:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.13.2 + gcc 4.01 link error
References: <229e70f2050924085215707921@mail.gmail.com>
	<200509251727.00589.blaisorblade@yahoo.it>
	<229e70f205092612406fa7ecc3@mail.gmail.com>
In-Reply-To: <229e70f205092612406fa7ecc3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509271946.40230.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 27 Sep 2005 19:46:39 +0200
To: Etay Meiri <etay.meiri@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 26 September 2005 21:40, Etay Meiri wrote:
> On 9/25/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> > > dnsdomainname: Unknown host
> >
> > This error is not related to Uml at all and shouldn't give problems in
> > itself,
> > but why dnsdomainname doesn't work on your machine? You should probably
> > fix
> > that.

> Etay: looks like name resolving is not working ok on my machine. I'm
> getting 'host not
> found' when running host on my machine name. The name is configured in
> /etc/hosts
> and 'files' is set first in nsswitch.conf. Looks like the resolver is
> bypassing the hosts file
> and goes directly to the DNS server of my ISP.
No idea on this - I'm answering in a hurry.

> Etay: I updated my kernel tree using:
>
> git pull
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

> (is that the correct way to pull Linus tree?)
I use cogito (see www.kernel.org/git - there's info atop of the page), but the 
above should work, yes.

However -bs2 has been released, while Linus tree is currently not so nice (all 
the fixes exist, waiting to be merged).
> and got the following errors on compilation:
>
> [cl@amber linux-2.6]$ ARCH=um make
Sorry, use make ARCH=um, it's different. And still, run the command on a clean 
tree - CONFIG_X86_L1_CACHE_SHIFT is a clear sign you've some left-overs 
(likely include/asm)
> make[1]: `arch/um/sys-i386/util/mk_sc' is up to date.
> CHK arch/um/include/uml-config.h
> UPD arch/um/include/uml-config.h
> CHK include/linux/version.h
> UPD include/linux/version.h
> SPLIT include/linux/autoconf.h -> include/config/*
> gcc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
> -fno-common -ffreestanding -O2 -fomit-frame-pointer -g -fprofile-arcs
> -ftest-coverage -D__arch_um__ -DSUBARCH=\"i386\" -Iarch/um/include
> -I/home/cl/kernel/linux-2.6/arch/um/kernel/tt/include
> -I/home/cl/kernel/linux-2.6/arch/um/kernel/skas/include -Dvmap=kernel_vmap
> -Din6addr_loopback=kernel_in6addr_loopback -Derrno=kernel_errno
> -Dsigprocmask=kernel_sigprocmask -fno-unit-at-a-time -U__i386__ -Ui386
> -D_LARGEFILE64_SOURCE -Wdeclaration-after-statement -Wno-pointer-sign
> -nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/4.0.1/include
> -D__KERNEL__ -Iinclude -S -o arch/um/kernel-offsets.s
> arch/um/sys-i386/kernel-offsets.c In file included from
> include/asm/thread_info.h:17,
> from include/linux/thread_info.h:21,
> from include/linux/spinlock.h:53,
> from include/linux/capability.h:45,
> from include/linux/sched.h:7,
> from arch/um/sys-i386/kernel-offsets.c:3:
> include/asm/processor.h:69: error: 'CONFIG_X86_L1_CACHE_SHIFT' undeclared
> here (not in a function)
> include/asm/processor.h:69: error: requested alignment is not a constant
> In file included from include/linux/sched.h:12,
> from arch/um/sys-i386/kernel-offsets.c:3:
> include/linux/jiffies.h:27:5: warning: "CONFIG_HZ" is not defined
> include/linux/jiffies.h:29:7: warning: "CONFIG_HZ" is not defined
>
> Thanks a lot for your help,
>
> -Etay
>
> --
>
> > Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> > Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ
> > 215621894)
> > http://www.user-mode-linux.org/~blaisorblade
> >
> >
> > ___________________________________
> > Yahoo! Messenger: chiamate gratuite in tutto il mondo
> > http://it.messenger.yahoo.com
>
> --
> ------------------------------------------------------
> Etay Meiri
> etay.meiri@gmail.com

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
