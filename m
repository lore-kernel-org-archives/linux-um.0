Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CyZUk-0007gz-LR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 09:49:50 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CyZUi-0001M9-VV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Feb 2005 09:49:50 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [BUG report] UML linux-2.6 latest BK doesn't
	compile
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<200502081122.22613.blaisorblade@yahoo.it>
	<1107859254.582.4.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1107859254.582.4.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502081848.46270.blaisorblade@yahoo.it>
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
Date: Tue, 8 Feb 2005 18:48:46 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>

On Tuesday 08 February 2005 11:40, Anton Altaparmakov wrote:
> On Tue, 2005-02-08 at 11:22 +0100, Blaisorblade wrote:
> > On Tuesday 08 February 2005 11:09, Anton Altaparmakov wrote:
> > > Hi,
> > >
> > > With the current linux-2.6 BK tree I get this when trying to compile
> > > UML:
> > >
> > >   CC      init/version.o
> > >   LD      init/built-in.o
> > >   LD      .tmp_vmlinux1
> > > arch/um/kernel/built-in.o(__ksymtab+0x2b0): In function `um_execve':
> > > arch/um/kernel/exec_kern.c:59: undefined reference to `__bb_init_func'
> > > collect2: ld returned 1 exit status
> > >   KSYM    .tmp_kallsyms1.S
> > > nm: '.tmp_vmlinux1': No such file
> > > /bin/bash: line 1: 26161 Exit 1                  nm -n .tmp_vmlinux1
> > >      26162 Segmentation fault      | scripts/kallsyms >.tmp_kallsyms1.S
> > > make: *** [.tmp_kallsyms1.S] Error 139
> > >
> > > This is with SKAS mode enabled and TT disabled.  My .config is
> > > attached.
> >
> > Hmm - I do not understand at all where `__bb_init_func' comes from (not
> > from UML by sure, only from kernel headers possibly). And from
> > preprocessing the source (of the -bk4 snapshot), nothing similar comes
> > out.
>
> It is from UML.  'bk -r grep __bb_init_func' gives:
>
> arch/um/kernel/gmon_syms.c      1.1     extern void __bb_init_func(void
> *);
> arch/um/kernel/gmon_syms.c      1.1     EXPORT_SYMBOL(__bb_init_func);
>
> The kernel compiles fine with the same .config but TT mode also enabled.

> So I suspect that in the non-TT case the gmon_syms binary
> linked into the kernel
I think it *is* still linked.
> so the symbol is missing or something like 
> that...
Hmm, the difference is likely in the build commands:

1) Simply because the build is dynamic in the non-TT mode case (no idea)
2) bug in Makefiles.... but I didn't see anything strange:

arch/um/Makefile-skas (included only when SKAS mode is enabled):

PROFILE += -pg

CFLAGS-$(CONFIG_GCOV) += -fprofile-arcs -ftest-coverage
CFLAGS-$(CONFIG_GPROF) += $(PROFILE)
LINK-$(CONFIG_GPROF) += $(PROFILE)

the Makefiles were heavily changed, however, recently (after 2.6.10).
> Also note I am using the latest BK as pulled about an hour ago.  I don't
> know how old the snapshot you are using is in comparison.
Last daily snapshot, when I posted. (Now we are at -bk5). However I only built 
the file on which you saw the warning, not everything.
> Lots of UML 
> changes were pulled in by my pull...

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
