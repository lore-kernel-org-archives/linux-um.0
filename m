Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4hGB-0002uJ-8q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Feb 2005 07:20:07 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D4hG8-00051f-Kb for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Feb 2005 07:20:07 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH] uml: support a separate build tree;
	support USER_OBJS dependencies
References: <opsl43d9yilfdzum@localhost.localdomain>
	<200502161930.55206.blaisorblade@yahoo.it>
	<opsmf6p3ellfdzum@localhost.localdomain>
In-Reply-To: <opsmf6p3ellfdzum@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200502241919.58716.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 24 Feb 2005 19:19:58 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Vadim Abrossimov <vadim_abrossimov@yahoo.com>, Jeff Dike <jdike@addtoit.com>

On Saturday 19 February 2005 15:04, Vadim Abrossimov wrote:
> On Wed, 16 Feb 2005 19:30:54 +0100, Blaisorblade <blaisorblade@yahoo.it>
>
> wrote:
> > Ok, I have two more requests, if possible:
> > 1) add something like arch/um/Rules.make which is included everywhere
> > needed
>
> Find below the patch which implements Paolo's suggestion with one
> exception:
The patch is totally mangled by the mailer, sorry. Could you please reattach 
it? I've tried fixing it by hand but hadn't got the time.

*) Another suggestion (I'll implement it if you are not going to): the 
creation of USER_SINGLE_OBJS should also be moved to Makefile.rules (the 
below form should be the more general one); so even the "$(filter %_user.o, 
$(USER_SINGLE_OBJS))" snippet could move there.

USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),
$($(f)-objs))

*) About  
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.11-rc3-mm2/patches/user-obj-cleanup
at his end: I've seen that for stub.S you don't succeed to get it working. 
Have you tried setting a_flags for that one only?

*) Someone who has a working tree with this can check whether enabling 
CONFIG_MODVERSIONS works well? Without it it does not work, for what I 
remember, exactly for the kbuild problem.

When time ago I built a similar patch which changed c_flags (it hacked the 
main Makefiles though) it started to work well, since the object 
postprocessing step was also done. So this patch should also achieve this 
goal, I think.

*) (Slightly unrelated) About this change in the "skas0" patch:

Index: linux-2.6.10/arch/um/Makefile-i386
===================================================================
--- linux-2.6.10.orig/arch/um/Makefile-i386     2005-02-12 13:57:48.000000000 
-0500
+++ linux-2.6.10/arch/um/Makefile-i386  2005-02-14 12:36:37.000000000 -0500
@@ -8,7 +8,7 @@
   endif
 endif

-CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH)
+CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH) $(STUB_CFLAGS)
 ARCH_USER_CFLAGS :=

 ifneq ($(CONFIG_GPROF),y)
Index: linux-2.6.10/arch/um/Makefile-x86_64
===================================================================
--- linux-2.6.10.orig/arch/um/Makefile-x86_64   2005-02-12 13:57:48.000000000 
-0500
+++ linux-2.6.10/arch/um/Makefile-x86_64        2005-02-14 12:36:37.000000000 
-0500
@@ -4,7 +4,7 @@
 SUBARCH_LIBS := arch/um/sys-x86_64/
 START := 0x60000000

-CFLAGS += -U__$(SUBARCH)__ -fno-builtin
+CFLAGS += -U__$(SUBARCH)__ -fno-builtin $(STUB_CFLAGS)
 ARCH_USER_CFLAGS := -D__x86_64__

 ELF_ARCH := i386:x86-64

I guess it's actually useless, because STUB_CFLAGS is not defined at that 
point, so it should be undone.
> I put the common definitions in arch/um/scripts/Makefile.rules to be more
> consistent
> with my understanding of conventions.
This form is also ok for me. If when merging they want it further renamed, 
we'll take care of it.

> Also I noticed that including my original patch in his tarball Jeff  
> excluded changes
> in some Makefiles (e.g. arch/um/kernel/Makefile).
> Jeff, had you a problem with those Makefiles?
I don't know what Jeff thought, but do you remember the bug I pointed out 
about USER_CFLAGS and CFLAGS_$@?

Well, that problem would cause a compilation problem on 
arch/um/kernel/frame.o, because this would not work:

CFLAGS_frame.o := -fno-omit-frame-pointer
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
