Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6A7F-0004f3-9F for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 08:48:41 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C6A7E-0001Gw-BA for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 11 Sep 2004 08:48:41 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
References: <20040826020626.GA28471@malice.crymeariver.org>
	<200409102352.i8ANql0O004842@ccure.user-mode-linux.org>
In-Reply-To: <200409102352.i8ANql0O004842@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409111745.18659.blaisorblade_spam@yahoo.it>
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
Date: Sat, 11 Sep 2004 17:45:18 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, David Jeffery <djeffery@britsys.net>

On Saturday 11 September 2004 01:52, Jeff Dike wrote:
> djeffery@britsys.net said:
> > The problem is caused by the incorrect implementation of sys_clone().
> >  sys_clone() is an ugly beast that has different arguements depending
> > on  the architecture.  For i386 and ppc, the child tid is passed as
> > the  5th arguement instead of as the 4th arguement as as some other
> > architectures (like x86-64) do.  The 4th arguement on i386 and ppc
> > doesn't look to be used by the kernel.
>
> This is fixed in my tree.  It was a lot simpler than your patch, or what I
> led you to believe.  I just moved sys_clone from syscall_kern.c to
> arch/um/sys-i386/syscalls.c and fixed the interface.

Jeff, please fix your patch again - the unused argument is the fourth, not the 
third:

original one
+#if defined(__subarch_i386__) || defined(__subarch_ppc__)
+long sys_clone_5arg(unsigned long clone_flags, unsigned long newsp,
+               int *parent_tid, unsigned long unused, int *child_tid)
+{
+        return sys_clone(clone_flags, newsp, parent_tid, child_tid);
+}
+#endif

Also, Andrew Morton wrote some UML fixes (for scheduler bugs) on his own. Did 
you already note this or you want them forwarded?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
