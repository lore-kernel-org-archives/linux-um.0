Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eh8ak-0005J9-I5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 08:44:30 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Eh8ae-00078p-KK
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 08:44:27 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Testing requested - [PATCH] Fixing SKAS0 compilation
	problem / TT mode bug report
References: <200511272159.38069.blaisorblade@yahoo.it>
	<20051128042327.GA28500@ccure.user-mode-linux.org>
In-Reply-To: <20051128042327.GA28500@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511291728.56515.blaisorblade@yahoo.it>
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
Date: Tue, 29 Nov 2005 17:28:56 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 28 November 2005 05:23, Jeff Dike wrote:
> On Sun, Nov 27, 2005 at 09:59:37PM +0100, Blaisorblade wrote:
> > The attached patch is a (hacky) proposal, alternative to Jeff's
> > fix-stub-syscall6, to fix the SKAS0 compilation problem.

> Bleah :-)

Yep :-).

> > In fact, Jeff's patch makes the problem appear on my system (where I
> > never reproduced it).

> What assembly did you end up with, with my patch?

Actually, looking at it today, it's a different story than the usual one:

====working (from the .s output rather than disassembly):

#APP
        push %ebp ; movl %eax,%ebp ; movl $192,%eax ; int $0x80 ; pop %ebp
#NO_APP
        movl    %eax, %edi
.L4:
        movl    %edi, -1073745896
#APP
        int3

====not-working:

#APP
        push %ebp ; movl %eax,%ebp ; movl $192,%eax ; int $0x80 ; pop %ebp
#NO_APP
        movl    %eax, -16(%ebp)
.L4:
        movl    -16(%ebp), %eax
        movl    %eax, -1073745896
#APP
        int3

Command line for GCC:

  gcc -Wp,-MD,arch/um/kernel/skas/.clone.s.d -Wall -Wundef -Wstrict-prototypes 
-Wno-trigraphs -fno-strict-aliasing -fno-common -ffreestanding -O2 
-fno-omit-frame-pointer -fno-optimize-sibling-calls -D__arch_um__ 
-DSUBARCH=\"i386\" -Dvmap=kernel_vmap 
-Din6addr_loopback=kernel_in6addr_loopback -Iarch/um/include 
-I/home/paolo/Admin/kernel/6/VCS/linux-2.6.14/arch/um/include  
-I/home/paolo/Admin/kernel/6/VCS/linux-2.6.14/arch/um/kernel/tt/include  
-I/home/paolo/Admin/kernel/6/VCS/linux-2.6.14/arch/um/kernel/skas/include 
-D_FILE_OFFSET_BITS=64 -m32 -D_GNU_SOURCE -D_LARGEFILE64_SOURCE  -S -o 
arch/um/kernel/skas/clone.s /home/paolo/Admin/kernel/6/VCS/linux-2.6.14/arch/um/kernel/skas/clone.c

As you see, what's moved is the scratch pid location, put in %edi register 
normally and in the stack on the faulty assembly (btw, I'm puzzled why GCC 
should do this puzzling around).

So, indeed, with your patch GCC understands that the variable is at a known 
location, but becomes silly for other reasons.

So, again: can we finally rewrite clone.c in assembly? Or, otherwise, to use a 
unique assembly macro joining mmap, the return and trap_myself?

It could be nicer to have it in C, but hey, GCC won, we lost. So let gcc suck 
and work without it.

It's fundamentally hacky to get GCC not to use the stack, it's not written for 
that. Either you say "ok, let's copy the whole stack content when remapping" 
a-la switcheroo() or we agree on ASM.

> > #ifdef CONFIG_MODE_SKAS
> > #define KSTK_REG(tsk, reg) \
> >         ({ union uml_pt_regs regs; \
> >            get_thread_regs(&regs, tsk->thread.mode.skas.switch_buf); \
> >            UPT_REG(&regs, reg); })
> > #else
> > #define KSTK_REG(tsk, reg) (0xbadbabe)
> > #endif

> Oops, needs fixing.

Btw, the old code was probably uncorrect but didn't crash except for sysrq-t.

Actually,  in TT mode we possibly don't have the right location (do we save 
the stack pointer before entering the kernel)? Let's just use the old code as 
fallback for that, it's not worth implementing such a feature for TT mode.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
