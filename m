Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtZKZ-0002eE-E5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 14:38:39 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CtZKV-0006up-OG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 14:38:39 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20041118160909.GA7630@halcrow.us>
	<200411181839.26596.blaisorblade_spam@yahoo.it>
	<20050125215416.GA2912@halcrow.us>
In-Reply-To: <20050125215416.GA2912@halcrow.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501252337.58219.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] keyring syscalls
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
Date: Tue, 25 Jan 2005 23:37:57 +0100
To: Michael Halcrow <uml@halcrow.us>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Tuesday 25 January 2005 22:54, Michael Halcrow wrote:
> On Thu, Nov 18, 2004 at 06:39:26PM +0100, Blaisorblade wrote:
> > On Thursday 18 November 2004 17:09, Michael Halcrow wrote:
> > Ok, please list the new syscalls - I see at least add_key() and
> > request_key() too - are these three the only ones? I'll build the
> > patch ASAP when getting your answer.
>
> I spent some more time today trying to implement these silly
> request_key, add_key, and keyctl syscalls in the 2.6.10 kernel, but I
> haven't had any luck.  It would be a *tremendous* help for me in my
> filesystem development if I could just get these syscalls working in
> UML; it is much more tedious having to use kgdb in my debugging.  I
> tried adding entries on to the end of the
> include/sysdep-i386/syscalls.h and the kernel/sys_call_table.c files.
> I also exported the symbols in os-Linux/user_syms.c.  I am trying to
> work from the documentation here:
>
> http://jdike.stearns.org/uml/arch-port.html
>
> I am not entirely clear on the function that ``[ 222 ] =
> sys_ni_syscall,'' at the end of the table in syscalls.h is supposed to
> serve.  Syscalls in UML contstitutes new territory for me.
Well, like 
> I would assume that the __NR_* assignments in the UML environment are
> identical to those of the host system.  That means that request_key,
> for example, maps to identifier 288 on the i386 architecture, right?
Yes, because when a program says "I want to call the write() syscall", all it 
contains to identify the "write" syscall between all the existing ones is the 
__NR_write value... so it is very important that they never change (on the 
same architecture). As long as UML must emulate i386, the identifiers must 
match.

> The keyctl.c utility defines these syscall identifiers, so I need to
> make sure that I get the numbers right for the syscall table lookup.

> Thanks,
> Mike
Well, it should be fixed in the -mm tree (and probably in 2.6.11-rc2-bk2, I 
guess, though it's not tested)... browse the patches at 
http://user-mode-linux.sourceforge.net/patches.html.

It should be in next release...
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
