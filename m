Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCB3o-0007zo-Bj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 22:34:16 -0800
Received: from rproxy.gmail.com ([64.233.170.201])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DCB3m-0000Ok-He for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 22:34:16 -0800
Received: by rproxy.gmail.com with SMTP id 40so26237rnz
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 17 Mar 2005 22:34:13 -0800 (PST)
Message-ID: <cbec11ac050317223481fb034@mail.gmail.com>
From: Ian McDonald <imcdnzl@gmail.com>
Reply-To: Ian McDonald <imcdnzl@gmail.com>
Subject: Re: [uml-devel] Can't compile under vanilla 2.6.11
In-Reply-To: <200503172240.54876.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <cbec11ac05031719187cb8e7d2@mail.gmail.com>
	<200503172240.54876.rob@landley.net>
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
Date: Fri, 18 Mar 2005 19:34:13 +1300
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

I was doing all that you said here and without the typo for menuconfig
that I put in...

I am running x86 and gcc 2.95.4 - I am suspecting the gcc may be an
issue but maybe I should also pull down the kernel from another mirror
in case my mirror is not good that I am using...


On Thu, 17 Mar 2005 22:40:54 -0500, Rob Landley <rob@landley.net> wrote:
> On Thursday 17 March 2005 10:18 pm, Ian McDonald wrote:
> > Hi there,
> >
> > I've been watching the discussion around 2.6.11 and reading the
> > archives and I can't find the information with any clarity that I
> > need. My problem is that I can't get UML to compile. I can on 2.4.27
> > (with the standard patches) and with 2.6.10 also.
> 
> All I have to do, on x86 under either Knoppix or Red Hat, is (this is off the
> top of my head, so there might be a typo or two):
> 
> tar xvjf linux-2.6.11.tar.bz2
> cd linux-2.6.11
> # Get a usable .config file, you can use "make ARCH=um menuconfig" for this
> # if you know what to select.  This adds a more or less minimal set of options
> # to allnoconfig to provide a usable test system.  Later, you'll want to add
> # thinks like loopback support, UBD, ext2, maybe swap support...
> make ARCH=um allnoconfig
> cat >> .config << EOF
> CONFIG_MODE_TT=y
> CONFIG_LD_SCRIPT_STATIC=y
> CONFIG_BINFMT_ELF=y
> CONFIG_HOSTFS=y
> CONFIG_STDERR_CONSOLE=y
> CONFIG_LBD=y
> CONFIG_PROC_FS=y
> EOF
> yes "" | make ARCH=um oldconfig
> # Now build it.
> make ARCH=um
> # Run it.  Later you might want to add "rootflags" (defaults to rootflags=/)
> # and "mem" (defaults to mem=32M).  "quiet" is nice too...
> ./linux rootfstype=hostfs rw init=/bin/sh
> # Show that the new shell prompt is under UML, not the parent system.
> mount -t proc /proc /proc
> cat /proc/cpuinfo
> 
> The polite way to exit is either "shutdown -n" or "halt -f" (both in sbin,
> which isn't int he path), but when pid 1 is /bin/sh then just "exit" will
> work as well if you don't mind a UML panic message about "tried to kill
> init"...
> 
> Speaking of path: the default UML path ends with ".", and if you try to
> compile anything this triggers some "holier than thou" code in gcc that
> ignores the entire path without even a warning message because it thinks it
> knows better than you, and thus doesn't find the linker.  Just set your PATH
> to "/sbin:/usr/sbin:/bin:/usr/bin" and it should work fine.  (Why this isn't
> the default, I have no idea...)
> 
> > My environment is Debian Woody with 2.4.27 kernel. My gcc version is
> > 2.95.4. I am using default options when I do 'make menu_config
> > ARCH=um'
> 
> There's no underscore in menuconfig.
> 
> > Here is the error that I am experiencing once I do 'make linux ARCH=um':
> > arch/um/kernel/sys_call_table.c:277: duplicate array index in initializer
> > arch/um/kernel/sys_call_table.c:277: (near initialization for
> > `sys_call_table') arch/um/kernel/sys_call_table.c:277: duplicate array
> > index in initializer arch/um/kernel/sys_call_table.c:277: (near
> > initialization for `sys_call_table')
> 
> I remember a problem like that in one of the 2.6.11-pre releases, but it was
> fixed in the final 2.6.11.  What compiler version are you using?
> 
> > The code at line 277 is:
> >        ARCH_SYSCALLS
> >        [ LAST_SYSCALL + 1 ... NR_syscalls ] =
> >                (syscall_handler_t *) sys_ni_syscall
> >
> > I don't quite understand this as it surpasses my C knowledge but if I
> > do a dirty hack and change this to:
> 
> Yeah, I did too.  It was fixed before the 2.6.11 release.  Are you sure you're
> building 2.6.11 sources?
> 
> > Can anybody point me in the right direction?
> 
> You're sure you're using linux-2.6.11.tar.bz2 on x86?
> 
> > Regards,
> >
> > Ian
> 
> Rob
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
