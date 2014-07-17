Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Fri, 18 Jul 2014 07:13:29 +0800
From: Real Name <enjoymindful@gmail.com>
Message-ID: <20140717231329.GB27382@name>
References: <538F275B.7000508@nod.at>
	<1401941724-6703-1-git-send-email-enjoymindful@gmail.com>
	<1401941724-6703-2-git-send-email-enjoymindful@gmail.com>
	<5390E5FD.5030400@nod.at> <20140621072852.GA6538@name>
	<20140628040628.GA23770@name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140628040628.GA23770@name>
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
Subject: Re: [uml-devel] [PATCH] remove csum_partial_copy_generic_i386 to
 clean up exception table
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Sat, Jun 28, 2014 at 12:06:28PM +0800, Real Name wrote:
> On Sat, Jun 21, 2014 at 03:28:52PM +0800, Real Name wrote:
> > On Thu, Jun 05, 2014 at 11:49:49PM +0200, Richard Weinberger wrote:
> > > Am 05.06.2014 06:15, schrieb Honggang Li:
> > > > arch/x86/um/checksum_32.S had been copy & paste from x86. When build
> > > > x86 uml, csum_partial_copy_generic_i386 mess up the exception table.
> > > > In fact, exception table dose not work in uml kernel.
> > > 
> > > Are you sure that exception tables do not work on UML?
> > > I said, I'm not sure. Can you please find out?
> > 
> > Hi,
> >  After traced i386 uml kernel with gdb , I'm sure exception tables 
> > do *not* work. When csum_partial_copy_generic_i386 read user space memory, 
> > an access error exception arises, however, the segv function always
> > return zero. So, the fixup nerver executed. The uml system hang (not
> > kernel panic).
> 
> The kernel hang because the SEGV signal handler can't modify the EIP
> register in signal context. 
> 
> Here is the summary why exception table dose not works for linux (>3.3):
> 1) broken exception table (706276543b699d80f546e45f8b12574e7b18d952)
> 2) arch_fixup modify the local copy of regs. 	

hi, Richard
ping? are you agree with what i said?

> > 
> > thanks.
> > 
> > > 
> > > In arch/um/kernel/trap.c:segv() we have the mechanism for it:
> > >         else if (!is_user && arch_fixup(ip, regs))
> > >                 goto out;
> 0) access invalid memory address in kernel (no mm for the address. it is
> easy to force invalid memory acess in kernel. I cast 0x1234 as a void
> pointer, and pass it to csum_partial_copy_generic_i386)
> 1) SEGV signal arise
> 1.1) hard_handler (arch/um/os-Linux/signal.c)
> The third argument of hard_handler point to signal context.
> 1.2) call sig_handler 
> 1.3) call sig_handler_common (dump the registers in signal context into
> 	local var struct uml_pt_regs r.). line 36 is the key point why
> exception table dose not works in UML.
> 
> 34         if (sig == SIGSEGV) {
> 35                 /* For segfaults, we want the data from the	sigcontext. */
> 36                 get_regs_from_mc(&r, mc);
> 37                 GET_FAULTINFO_FROM_MC(r.faultinfo, mc);
> 38         
> 
> 1.4) call segv_handler (arch/um/kernel/trap.c)
> 1.5) call segv
> 1.6) call arch_fixup (arch/x86/um/fault.c)
> 1.7) arch_fixup (UPT_IP(regs) = fixup->fixup;) set the EIP register of
> local copy uml_pt_regs
> 1.8) When function return to sig_handler, the EIP change lost
> 1.9) When hard_handler signal handler return, it restore the EIP with
> the address arise the SEGV in step 0. The fixup section never be
> executed. If exception table works, UML kernel should run fixup code in
> here.
> 
> Then repeate step 0 to 1.9, kernel hang on.
> 
> thanks
> 
> > > 
> > > The interesting question is, is this by design or was it just copy&pasted from x86
> > > many moons ago? :)
> > > 
> > > > And csum_partial_copy_generic_i386 never been called. So, delete it.
> > > 
> > > I like such clean ups. :-)
> > > 
> > > Thanks,
> > > //richard

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

