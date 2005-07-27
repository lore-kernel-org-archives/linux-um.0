Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dxovz-00083S-M6	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jul 2005 09:39:07 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1DxovX-00013Q-6t
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Jul 2005 09:39:07 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] NEW compile errors for UMLPPC
References: <838f7c50050720115954d28b25@mail.gmail.com>
	<838f7c5005072412315f9113fe@mail.gmail.com>
	<838f7c5005072511283b6b2d41@mail.gmail.com>
In-Reply-To: <838f7c5005072511283b6b2d41@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507271733.47007.blaisorblade@yahoo.it>
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
Date: Wed, 27 Jul 2005 17:33:46 +0200
To: user-mode-linux-devel@lists.sourceforge.net, ashwin tanugula <ashwin.tanugula@gmail.com>
Cc: jdike@addtoit.com, user-mode-linux-user@lists.sourceforge.net

On Monday 25 July 2005 20:28, ashwin tanugula wrote:
> Hi,
> I think those errors came due to the inclusion of
> include/asm/processor-i386.h. I remover that inclusion and included
> the structure arch_thread in processor-generic.h, which removed the
> previous errors.
>
> Now I am getting the following errors
> - Show quoted text -
>
>
> root@slemieux:/home/ashwin/Desktop/ashwin/linux-2.6.0-test9 # make
> linux ARCH=um  CHK     include/linux/version.h
>  UPD     include/linux/version.h
>  SYMLINK include/asm -> include/asm-um
>  HOSTCC  scripts/genksyms/genksyms.o
>  SHIPPED scripts/genksyms/lex.c
>  SHIPPED scripts/genksyms/parse.h
>  SHIPPED scripts/genksyms/keywords.c
>  HOSTCC  scripts/genksyms/lex.o
>  SHIPPED scripts/genksyms/parse.c
>  HOSTCC  scripts/genksyms/parse.o
>  HOSTLD  scripts/genksyms/genksyms
>  HOSTCC  scripts/split-include
>  HOSTCC  scripts/conmakehash
>  HOSTCC  scripts/docproc
>  HOSTCC  scripts/kallsyms
>  CC      scripts/empty.o
>  HOSTCC  scripts/mk_elfconfig
>  MKELF   scripts/elfconfig.h
>  HOSTCC  scripts/file2alias.o
>  HOSTCC  scripts/modpost.o
>  HOSTLD  scripts/modpost
>  HOSTCC  scripts/pnmtologo
>  HOSTCC  scripts/bin2c
>  SPLIT   include/linux/autoconf.h -> include/config/*
> sed 's/ CONFIG/ UML_CONFIG/'
> /home/ashwin/Desktop/ashwin/linux-2.6.0-test9/include/linux/autoconf.h
>
> > arch/um/include/uml-config.h
>
> make -f scripts/Makefile.build obj=arch/um/util
> gcc -o arch/um/util/mk_task_user.o -c arch/um/util/mk_task_user.c
>  CC      arch/um/util/mk_task_kern.o
> In file included from include/asm/processor.h:13,
>                 from include/asm/thread_info.h:11,
>                 from include/linux/thread_info.h:21,
>                 from include/linux/spinlock.h:12,
>                 from include/linux/capability.h:45,
>                 from include/linux/sched.h:7,
>                 from arch/um/util/mk_task_kern.c:1:
> include/asm/processor-generic.h:118: warning: `struct user' declared
> inside parameter list
> include/asm/processor-generic.h:118: warning: its scope is only this
> definition or declaration, which is probably not what you want
Means that you should have "struct user;" somewhere before that:
when you have this:

void foo(struct bar * foobar);
the compiler assumes an implicit "struct bar;" declaration ending there, which 
won't match with anything else.
> In file included from include/asm/arch/semaphore.h:21,
I'm sure this (asm/arch) still points to asm-i386. Will you do a "make 
mrproper ARCH=um" first? It causes all those "regparm" errors.

For the below one, don't know, sort it out somehow. Since it's declared in 
archparam, update it, comparing with the other ones (it's the only one to 
still define irq_enter/exit).
> include/asm/arch/hardirq.h:82:1: warning: "irq_enter" redefined

> include/asm/archparam.h:34:1: warning: this is the location of the
> previous definition

> include/asm/arch/hardirq.h:91:1: warning: "irq_exit" redefined

> include/asm/archparam.h:35:1: warning: this is the location of the
> previous definition

> ignored In file included from include/linux/bootmem.h:7,
>                 from init/main.c:29:
> include/asm/pgtable.h: In function `pte_file':
> include/asm/pgtable.h:277: error: request for member `pte_low' in
> something not a structure or union
Means that for ppc pte_t is not a struct, which probably has to be fixed.

typedef struct { unsigned long pte; } pte_t;

> In file included from include/linux/skbuff.h:26,
>                 from include/linux/security.h:34,
>                 from init/main.c:34:

On the below one, I don't know, but I would disable HIGHMEM for now, probably 
it doesn't work for i386 either in such a old UML version. Btw, are you at  
least using Jeff DIke's patch? Also, why not updating to a more recent UML 
release? Do as you like, but surely you'll meet the bugs affecting UML itself 
(independent from arch ports) which were already fixed in later releases (for 
instance, module support and HIGHMEM, I guess).
> include/asm/arch/highmem.h: In function `kmap_atomic':
> include/asm/arch/highmem.h:89: error: `CONFIG_HIGHMEM_START'
> undeclared (first use in this function)
> include/asm/arch/highmem.h:89: error: (Each undeclared identifier is
> reported only once
> include/asm/arch/highmem.h:89: error: for each function it appears in.)
> include/asm/arch/highmem.h: In function `kunmap_atomic':
> include/asm/arch/highmem.h:106: error: `CONFIG_HIGHMEM_START'
> undeclared (first use in this function)
> include/asm/arch/highmem.h: In function `kmap_atomic_to_page':
> include/asm/arch/highmem.h:128: error: `CONFIG_HIGHMEM_START'
> undeclared (first use in this function)
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
