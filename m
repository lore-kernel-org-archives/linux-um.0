Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind
Message-ID: <20040804153541.GA7237@ccure.user-mode-linux.org>
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk>
	<200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
	<410FCC70.1050902@enterasys.com>
	<200408031931.i73JVkvv003367@ccure.user-mode-linux.org>
	<yek3c33tk5o.fsf@audi.uk.cyberscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yek3c33tk5o.fsf@audi.uk.cyberscience.com>
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
Date: Wed, 4 Aug 2004 11:35:41 -0400
To: Tom Hughes <thh@cyberscience.com>
Cc: "D. Bahi" <dbahi@enterasys.com>, Nicholas Nethercote <njn25@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

On Wed, Aug 04, 2004 at 08:52:19AM +0100, Tom Hughes wrote:
> >> @@ -39,6 +40,10 @@
> >>  # code which copies from baseBlock before the call, into
> >>  # m_state_static, and back afterwards.
> >>  
> >> +.section .data
> >> +save_ip:
> >> +        .long   0
> >> +
> >>  VG_(do_syscall):
> >>         # Save all the int registers of the real machines state on the
> >>         # simulators stack.
> >> @@ -80,10 +85,27 @@
> >>         movl    VG_(m_state_static)+48, %esi
> >>         movl    VG_(m_state_static)+52, %edi
> >>  
> >> +       cmpl    $__NR_clone, %eax
> >> +       jne     not_clone
> >> +
> >> +       pushl   %eax
> >> +       movl    VG_(m_state_static)+60, %eax
> >> +       movl    %eax, save_ip
> >> +       popl    %eax
> >> +
> >> +       int     $0x80
> >> +
> >> +       cmpl    $0, %eax
> >> +       jne     parent_finish
> >> +
> >> +       jmp     *save_ip
> >> +
> >> +not_clone:
> >>         # esp now refers to the simulatees stack
> >>         # Do the actual system call
> >>         int     $0x80
> 

> But how did you cope with the fact that valgrind doesn't protect it's
> internal data structures in any way? You would have all sorts of
> problems with two threads trying to access the same data.

I think I was mistaken about this firing off another valgrind thread, for
two reasons.  

I remember being concerned about whether the process data was still present
in its normal, not running under valgrind, form.  This would only be a problem
if you were planning on running a non-valgrind thread in the same address
space.

Second, the patch above looks like it extracts the client IP from valigrind's
state and branches to it.  This would make the new thread a non-valgrind one.

So, this being the case, there are no concerns about multi-threading V, just
UML, which isn't your problem.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
