Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXkLF-0001Lg-PL
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 08:52:37 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AXkLD-0006Yq-RN
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 08:52:36 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [UML combo patch] 2.6.0 host-skas kernel & UML kernel patch
Message-ID: <20031220170815.GA10692@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0312171735540.8123@earth> <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181304250.3617@earth> <200312191959.27377.blaisorblade_spam@yahoo.it> <20031219211630.GA31977@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031219211630.GA31977@elte.hu>
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
Date: Sat, 20 Dec 2003 12:08:15 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Dec 19, 2003 at 10:16:30PM +0100, Ingo Molnar wrote:
> Jeff, do you know how the new skas4 syscall API will look like, exactly?

Pretty much.  I have it implemented.  It looks like this right now:
	asmlinkage long sys_get_mm(void) - returns a file descriptor referring
to an empty mm
	asmlinkage long sys_mm_indirect(int fd, int syscall, long args[]) -
performs the system call (*sys_call_table)[syscall](args) in the context of
the address space referred to by fd.  The size of the args array is 
arch-dependent.

Some still-open questions
	Should get_mm do a copy_segments from some other address space?  If
so, if may need to take an argument specifying whether this should happen,
and what address space to use.
	Some system calls are problematic in the case of mm_indirect:
		mm_indirect itself - a chain of them can be used to exhaust
		the kernel stack
		exit, exec - these will cause mm_struct refcounting bugs in
		the current implementation.
	The easy solution is to just disallow them, but I'm not sure that's
	right, especially in the case of exec.

PTRACE_MMAP, PTRACE_MUNMAP, and PTRACE_MPROTECT go away.  PTRACE_SWITCH_MM
stays.

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
