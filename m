Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JrzOA-00068R-3C for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 10:49:42 -0700
Received: from an-out-0708.google.com ([209.85.132.246])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JrzO9-0001DG-Lq
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 10:49:42 -0700
Received: by an-out-0708.google.com with SMTP id b21so332128ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 02 May 2008 10:49:40 -0700 (PDT)
Message-ID: <804dabb00805021049q773ddee8i1f2a21a05368b74e@mail.gmail.com>
Date: Sat, 3 May 2008 01:49:40 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <20080502155058.GA7843@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00804280853ld50a9f3o333f0f8d46f2a2ea@mail.gmail.com>
	<804dabb00804290502m771fe2cfm21f7be4534d56b65@mail.gmail.com>
	<20080429153746.GB9143@c2.user-mode-linux.org>
	<804dabb00804300924p3b1e1113vcbec90129ffa0f12@mail.gmail.com>
	<20080430184746.GA12021@c2.user-mode-linux.org>
	<804dabb00804301635s2b82a7f8hff4689d2952721dd@mail.gmail.com>
	<20080501151551.GB6303@c2.user-mode-linux.org>
	<804dabb00805010913q547d115fpfd51f47c1c92f5e4@mail.gmail.com>
	<804dabb00805010918q68741b64s5c7fd7b6bc006d17@mail.gmail.com>
	<20080502155058.GA7843@c2.user-mode-linux.org>
Subject: Re: [uml-devel] arch/um/Makefile:100: *** missing separator. Stop.
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Not sure why, but your current instructions works!!!

On 5/2/08, Jeff Dike <jdike@addtoit.com> wrote:
> On Fri, May 02, 2008 at 12:18:34AM +0800, Peter Teoh wrote:
>  > In case if anyone is wondering what this line 107 means in the arch/um/Makefile:
>  >
>  >     104 ifneq ($(KBUILD_SRC),)
>  >     105 $(shell mkdir -p $(ARCH_DIR) && ln -fsn
>  > $(srctree)/$(ARCH_DIR)/Kconfig.$(SUBARCH) $(ARCH_DIR)/Kconfig.arch)
>  >     106 else
>  >     107 $(shell cd $(ARCH_DIR) && ln -sf Kconfig.$(SUBARCH) Kconfig.arch)
>  >     108 endif
>  >
>  > Different version of Linux kernel tried, will always end up at the
>  > same line above, btw, although the line number can be different.
>
>
> Color me clueless as to what's going on.  However, since the offending
>  line is conditional on !KBUILD_SRC, you can try
>      mkdir obj ; make ARCH=um O=obj
>  and see if the behavior changes.  Maybe it'll produce a different and
>  more informative error.
>
>  I suspect you'll get exactly the same error because make is failing to
>  parse the Makefile and hasn't got around to actually interpretting
>  it.  If so, then just delete that line and see what happens.
>
>
>                  Jeff
>
>  --
>  Work email - jdike at linux dot intel dot com
>

This is what I have done, not sure if anything wrong:

a.   mkdir obj;make oldconfig ARCH=um O=obj

This created one file in obj, but after that created infinite number
of make -C processes running in the background.....I stopped that.

ps -ef and the following repeated MANY MANY TIMES:

root     32742 32658  0 01:13 pts/2    00:00:00 make -C
/mnt/hd0/download/linux-2.6-latest KBUILD_SRC= oldconfig
root     32745 32742  0 01:13 pts/2    00:00:00 make -C
/mnt/hd0/download/linux-2.6-latest/obj
/mnt/hd0/download/linux-2.6-latest/obj KBUILD_SRC=/mnt/hd0/dow

So, not okay.

b.   mkdir obj; make ARCH=um O=obj

As per instructed.....it works except it complained no config file (in
obj directory), and suggested to do a mrproper for the current parent
directory.   So I copied the .config to obj directory, make mrproper
in parent directory, and then cd to obj and make oldconfig there, and
then "make":

cp .config obj
make mrproper
cd obj
make oldconfig ARCH=um
make ARCH=um

Now it gives error:

  HOSTCC  scripts/kallsyms
  CC      init/main.o
In file included from
/mnt/hd0/download/linux-2.6-latest/arch/um/include/um_uaccess.h:10,
                 from include2/asm/uaccess.h:41,
                 from include2/asm/thread_info.h:13,
                 from
/mnt/hd0/download/linux-2.6-latest/include/linux/thread_info.h:47,
                 from
/mnt/hd0/download/linux-2.6-latest/include/linux/preempt.h:9,
                 from
/mnt/hd0/download/linux-2.6-latest/include/linux/spinlock.h:49,
                 from
/mnt/hd0/download/linux-2.6-latest/include/linux/seqlock.h:29,
                 from /mnt/hd0/download/linux-2.6-latest/include/linux/time.h:8,
                 from
/mnt/hd0/download/linux-2.6-latest/include/linux/stat.h:60,
                 from
/mnt/hd0/download/linux-2.6-latest/include/linux/module.h:10,
                 from /mnt/hd0/download/linux-2.6-latest/init/main.c:13:
include2/asm/fixmap.h:38: error: 'NR_CPUS' undeclared here (not in a function)
In file included from /mnt/hd0/download/linux-2.6-latest/include/linux/rmap.h:9,
                 from /mnt/hd0/download/linux-2.6-latest/init/main.c:49:
/mnt/hd0/download/linux-2.6-latest/include/linux/mm.h: In function
'is_vmalloc_addr':
/mnt/hd0/download/linux-2.6-latest/include/linux/mm.h:266: error:
'PKMAP_BASE' undeclared (first use in this function)
/mnt/hd0/download/linux-2.6-latest/include/linux/mm.h:266: error:
(Each undeclared identifier is reported only once
/mnt/hd0/download/linux-2.6-latest/include/linux/mm.h:266: error: for
each function it appears in.)
/mnt/hd0/download/linux-2.6-latest/include/linux/mm.h:270: warning:
control reaches end of non-void function
make[3]: *** [init/main.o] Error 1
make[2]: *** [init] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2


Just to ask this:

Noticed that I cd to obj, and everything from that subdirectory is
appended with ARCH=um, correct?

Taking away the ARCH=um, it naturally compiled to the end without
error, but it is not right, as there is no UM coming out from the
built - correct?

-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
