Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds6V3-0000d6-O2	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 15:11:41 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.44)
	id 1Ds6V0-00050A-2m	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 15:11:41 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200507120018.51436.blaisorblade@yahoo.it>
Subject: [uml-devel] CONFIG_REGPARM - prevent_tail_call doubts (context: SKAS3
	bug in detail)
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
Date: Tue, 12 Jul 2005 00:18:50 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>, LKML <linux-kernel@vger.kernel.org>

I just diagnosed (and announced) a big bug affecting the SKAS3 patch: namely, 
syscall parameter values stored in registers may be corrupted for some 
syscalls on return, when called through int 0x80, and when CONFIG_REGPARM is 
enabled.

Ok, the diagnosys of the SKAS3 bug I just noticed is that simply, this 
construct:

int do_foo(params...) {
}

asmlinkage int sys_foo(params...) {
	return do_foo(a_new_param, params...);
}

does not work, because sys_foo() is optimized to reorder parameters on the 
stack and to tail-call do_foo. The corrupted parameters on the stack will 
then be restored (when calling with int $0x80) inside the userspace 
registers. From entry.S, especially from this comment:

	/* if something modifies registers it must also disable sysexit */

it's clear that when using SYSENTER registers are not restored (even verified 
through sys_iopl() code, which touched EFLAGS).

I've used prevent_tail_call to fix this, and it works (verified with tests and 
assembly inspection). I even think I've understood why it works... it's clear 
why it disallows tail call, but I thought that GCC could create a normal call 
reusing some space from the stack frame of sys_foo, to create the stack frame 
of do_foo... it's just that it wouldn't improve speed.

This construct is used for four syscalls (sys_mmap2, old_mmap, sys_mprotect, 
sys_modify_ldt) and I verified the bug for all sys_mmap2 and sys_mprotect, 
and I'm sure about modify_ldt because the compiled code is identical to 
sys_mprotect().

I initially noticed this with the errno-vs-NPTL fix I and Al Viro discussed 
some time ago: it used indeed mmap2() and triggered the bug.

Luckily, strace reads the correct data (since syscall params are read before 
the syscall is done) so I couldn't do anything else than understand something 
bad was happening.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
