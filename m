Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTLoZ-0005iu-Lg for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 10:38:37 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HTLoS-00085c-Mt
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 10:38:35 -0700
Date: Mon, 19 Mar 2007 13:36:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070319173629.GA11790@c2.user-mode-linux.org>
References: <0A01463223B8164194908CAC85B66A1201AD3E2E@ZMY16EXM67.ds.mot.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A01463223B8164194908CAC85B66A1201AD3E2E@ZMY16EXM67.ds.mot.com>
Subject: Re: [uml-devel] Regarding System call virtualization
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Krishnappa Abhijith-A21204 <abhijith@motorola.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 19, 2007 at 10:38:27AM +0800, Krishnappa Abhijith-A21204 wrote:
>         Is the below flow correct for UML (TT mode)

Maybe, maybe not - your terminology is somewhat confusing.

> 1. UML process wants to execute a sys call say open().
> 2. UML TT comes to know this

By having PTRACE_SYSCALL on the host return status SIGTRAP | 0x80 from wait().

> annuls with getpid(), and UML TT executes
> open() on behalf of UML process.

If UML TT refers to the tracing thread, this is wrong.  The TT ptraces
a set of (UML) kernel register values into the process, and it (not
the TT) executes the open.

> 3. UML process executes the getpid() and returns and signals TT.

This happened before step 2.

> 4. By this time UML TT has finished executing the system call open and
> has returned back, so TT fills in the registers of UML process.

The system-call-making process finished executing in the UML kernel,
and signals the TT (by sending itself a signal, which will bump the TT
out of wait()) that it should return to userspace.

> 5. Now UML process executes normally with the open file descriptor.
>  
> If the above steps are correct, then How does UML protects host kernel.
> because even here TT will ask for host kernel services which may corrupt
> host kernel ? 

The *host* kernel is protected by hardware.  UML is a normal process
with no more access to the host kernel than ls.

There is a related, good question here, which is how is the UML kernel
protected, given that it is present, and not protected, in the process
address space.  The answer is that it isn't, at least not without
severe performance penalties.  This is largely what led to the skas
modes.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
