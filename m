Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXZXa-0005MF-CJ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 21:20:38 -0800
Received: from i164-068.nv.iinet.net.au ([203.59.164.68] helo=cp.yi.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXZXZ-00046O-3w
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 21:20:37 -0800
Received: from erdos.home ([10.0.1.2] helo=erdos)
	by cp.yi.org with esmtp (Exim 3.36 #1 (Debian))
	id 1AXZXV-0008PF-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 20 Dec 2003 13:20:33 +0800
Received: from cameron by erdos with local (Exim 3.36 #1 (Debian))
	id 1AXZXU-0000st-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 20 Dec 2003 13:20:32 +0800
From: Cameron Patrick <cameron@patrick.wattle.id.au>
Message-ID: <20031220052032.GC1152@erdos.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] UML on Alpha
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 20 Dec 2003 13:20:32 +0800
To: user-mode-linux-devel@lists.sourceforge.net

Hi all,

I've been looking into porting User-Mode Linux to the alpha.  I've made
a start by copying the i386-specific bits into {sys,sysdep,etc}-alpha,
following the porting guide on u-m-l.sf.net (which is sadly out of
date), and generally hacking stuff so that it looked appropriate.
Large portions of the kernel now seem to compile :-D.

Anyway, now I come to this mailing list in search of some explanations
for How UML Works these days in those places where that web site bears
little correlation with reality and I've been unable to work things out
for myself.

- I'm having trouble getting my head around the relationship between
  the pt_regs, pt_regs_subarch, uml_pt_regs and sigcontext.  (i.e. what
  they contain and what they're used for.)

- WTF is happening in arch/um/kernel/frame.c:227 :
        setup_arch_frame_raw(&raw_si->common.arch,
                             ucontext->uc_mcontext.fpregs, raw_si->common.sr);
  I can't see how uc_mcontext (which is of type "struct sigcontext")
  contains an fpregs member on /any/ architecture, even i386.  gcc
  certainly thinks it doesn't have an fpregs member on alpha :(

- Probably a lot more, but I'll try to harass this list only after I've
  spent a while trying to work things out myself.

Some of the problems (and implicit i386-isms) that I've noticed in UML
already are:

- Alpha system calls don't just return one value, they return two.  A
  lot of system calls also seem to take advantage of this; e.g. there is
  no __NR_getpid or __NR_getppid, but instead a __NR_getxpid which
  returns both.

- Since Alpha is a 64-bit architecture, there are no *64 system calls
  either.  This also affects other parts of the kernel which use #if to
  check for Alpha/sparc64/S390/etc to determine whether or not we're on
  a 64-bit platform.  I've worked around this by adding a -D__um_alpha__
  to CFLAGS and changing some places which check for __alpha__ to also
  check for __um_alpha__.  This may not be the cleanest way to do things
  thought :(

- I've needed to add a couple of extra (Alpha-specific) "dummy" headers
  to include/asm-um which just include include their arch/*.h
  counterparts.

- I've also changed asm-um/elf.h to only define ELF_EXEC_PAGESIZE,
  ELF_CLASS and elf_check_arch if they aren't already defined in
  archparam.  In the case of Alpha, the page size is 8192 (not 4096)
  and ELF_CLASS is ELFCLASS64 (not ELFCLASS32).  Is there any reason why
  this weren't being defined in some arch-specific way to begin with?

- Also, why is elf_check_arch() defined to return (1) in elf.h, whereas
  'real' architectures actually check something here?  I think that this
  is a UML bug, as an i386 UML will attempt to run binaries compiled for
  other platforms.  e.g. on a real i386:

  $ file ./stack_test_alpha 
  ./stack_test_alpha: ELF 64-bit LSB executable, Alpha (unofficial), version 1 (SYSV), for GNU/Linux 2.2.0, dynamically linked (uses shared libs), not stripped
  $ ./stack_test_alpha 
  bash: ./stack_test_alpha: cannot execute binary file

  but a UML running on i386 looks like it's trying to execute it:
  $ file ./stack_test_alpha 
  ./stack_test_alpha: ELF 64-bit LSB executable, Alpha (unofficial), version 1 (SYSV), dynamically linked (uses shared libs), not stripped
  $ ./stack_test_alpha 
  bash: ./stack_test_alpha: Cannot allocate memory

Another thing that would make life a lot easier would be being able to
cross-compile UML.  Unfortunately that would mean some way of getting
rid of mk_sc/mk_thread/mk_kern/etc, and I'm not sure what the best
approach to doing that would be :-/

Cheers,

Cameron.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
