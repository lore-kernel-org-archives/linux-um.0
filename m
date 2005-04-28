Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRG6I-0002uB-Ib	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:59:10 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DRG6G-0006lR-VZ	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:59:10 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [patch 1/7] uml: fix syscall table by including
	$(SUBARCH)'s one, for i386
Message-ID: <20050428204858.GD25451@ccure.user-mode-linux.org>
References: <20050424181909.81B8F33AED@zion>
	<20050428181053.GQ23013@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428181053.GQ23013@shell0.pdx.osdl.net>
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
Date: Thu, 28 Apr 2005 16:48:58 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: blaisorblade@yahoo.it, akpm@osdl.org, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Apr 28, 2005 at 11:10:53AM -0700, Chris Wright wrote:
> * blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> > 
> > Split the i386 entry.S files into entry.S and syscall_table.S which
> > is included in the previous one (so actually there is no difference between
> > them) and use the syscall_table.S in the UML build, instead of tracking by
> > hand the syscall table changes (which is inherently error-prone).
> 
> Xen can use this as well (it was on my todo list).

Maybe talking out of my ass here, but would it make sense to have the
generic syscalls in asm-generic, in the form of something like:
	SYSCALL(__NR_getpid, sys_getpid)
?

The arch include this into its syscall table, would continue to define
__NR_*, and it would define SYSCALL (but all the syscall tables I've
seen are just arrays of pointers).  This would allow the arches to
automatically get all the generic system calls, and they'd continue to
define on their own any arch-specific things.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
