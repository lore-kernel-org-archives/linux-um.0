Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXkih-0002NN-SS
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 09:16:51 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AXkif-0001FE-Qn
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 09:16:50 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] UML on Alpha
Message-ID: <20031220173249.GC10692@ccure.user-mode-linux.org>
References: <20031220052032.GC1152@erdos.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220052032.GC1152@erdos.home>
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
Date: Sat, 20 Dec 2003 12:32:49 -0500
To: Cameron Patrick <cameron@patrick.wattle.id.au>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Dec 20, 2003 at 01:20:32PM +0800, Cameron Patrick wrote:
> - I'm having trouble getting my head around the relationship between
>   the pt_regs, pt_regs_subarch, uml_pt_regs and sigcontext.  (i.e. what
>   they contain and what they're used for.)

pt_regs is the UML version of the processor state.  It contains, among other
things, the register state of the process as either a sigcontext * (in tt mode)
or an array (in skas mode).  uml_pt_regs is the same thing, basically, except
that it can be used by the userspace portions of UML, while pt_regs can only
be used by the kernel portions of UML since it is defined in a kernel header.

In tt mode, the process register state is stored at the top of the kernel
stack in a struct sigcontext by the host kernel's signal delivery code.
Anything which manipulates the registers will, in tt mode, refer to that
structure through the pointer in the process' pt_regs.

pt_regs_subarch is the pt_regs of the underlying architecture.

> 
> - WTF is happening in arch/um/kernel/frame.c:227 :
>         setup_arch_frame_raw(&raw_si->common.arch,
>                              ucontext->uc_mcontext.fpregs, raw_si->common.sr);
>   I can't see how uc_mcontext (which is of type "struct sigcontext")
>   contains an fpregs member on /any/ architecture, even i386.  gcc
>   certainly thinks it doesn't have an fpregs member on alpha :(

From /usr/include/asm/sigcontext.h on my laptop:

struct sigcontext {
	...
        struct _fpstate * fpstate;
	...
};

> - Alpha system calls don't just return one value, they return two.  A
>   lot of system calls also seem to take advantage of this; e.g. there is
>   no __NR_getpid or __NR_getppid, but instead a __NR_getxpid which
>   returns both.

There should be enough flexibility in the EXECUTE_SYSCALL macro to let you
handle this.  If not, then just mash something in for Alpha, and we'll
clean it up later.

> 
> - Since Alpha is a 64-bit architecture, there are no *64 system calls
>   either.  This also affects other parts of the kernel which use #if to
>   check for Alpha/sparc64/S390/etc to determine whether or not we're on
>   a 64-bit platform.  I've worked around this by adding a -D__um_alpha__
>   to CFLAGS and changing some places which check for __alpha__ to also
>   check for __um_alpha__.  This may not be the cleanest way to do things
>   thought :(

This is a problem.  There should be a CONFIG_64BITS which all the 64 bit
arches set, so we don't have to add #ifdef UML && UML_ALPHA to all these
places.

> 
> - I've needed to add a couple of extra (Alpha-specific) "dummy" headers
>   to include/asm-um which just include include their arch/*.h
>   counterparts.

Fine, we can figure out whether this needs fixing later.

> - I've also changed asm-um/elf.h to only define ELF_EXEC_PAGESIZE,
>   ELF_CLASS and elf_check_arch if they aren't already defined in
>   archparam.  In the case of Alpha, the page size is 8192 (not 4096)
>   and ELF_CLASS is ELFCLASS64 (not ELFCLASS32).  Is there any reason why
>   this weren't being defined in some arch-specific way to begin with?

They should have been.  Feel free to send in cleanups like that as you go.

> - Also, why is elf_check_arch() defined to return (1) in elf.h, whereas
>   'real' architectures actually check something here?  I think that this
>   is a UML bug, as an i386 UML will attempt to run binaries compiled for
>   other platforms.  e.g. on a real i386:

Probably because I never bother figuring out what it was really supposed to
do.  I don't see any reason we can't just steal it from the underlying arch.

> Another thing that would make life a lot easier would be being able to
> cross-compile UML.  Unfortunately that would mean some way of getting
> rid of mk_sc/mk_thread/mk_kern/etc, and I'm not sure what the best
> approach to doing that would be :-/

There was a bit of work in that direction a while back.  What I think would
be a good way to go is to have a arch_headers rule in the Makefile, which
would execute on the target, and generate the headers.  They would land
in a single directory, which you would then copy over to the build box.
The build there would use those headers, or generate them itself if they
weren't present.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
