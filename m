Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBGUM-00065m-83 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Sep 2004 10:37:38 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CBGUL-00082W-5R for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 Sep 2004 10:37:38 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] (no subject)
References: <8B6FF516CBA0194AB0996705076B02520F7C37@ABGEX01E.abg.fsc.net>
In-Reply-To: <8B6FF516CBA0194AB0996705076B02520F7C37@ABGEX01E.abg.fsc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409251934.37710.blaisorblade_spam@yahoo.it>
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
Date: Sat, 25 Sep 2004 19:34:37 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>

On Monday 20 September 2004 21:55, Stroesser, Bodo wrote:
> Today I tried testing interrupted systemcalls on UML 2.6.8.1-1 with the
> incremental patches up to skas-flush-tlb. My host does not yet support
> the new SYSEMU-ptrace.
>
> In skas-mode, the uml system with this kernel doesn't boot! It panics
> with the message:

> Kernel panic: handle_trap - failed to wait at end of syscall, errno = 4,
> status = 4479

> Tracking this down I saw that "errno = 4" from the message is
> misleading!

> It's an old errno, the return value of waitpid() is the pid 
> of the user-thread. It seems to be stopped by SIGCHLD.
Yes, I get some similar failures with the misleading "errno = 4"; I guess it's 
time to fix, maybe, either CATCH_EINTR or just this invocation of it.
However, the problem that UML should not expect the child getting only those 
virtual SIGTRAP (see man 2 ptrace); any other signal in that point should 
IMHO just be ignored. I've not written the patch but it is just adding Yet 
Another Loop, beyond the CATCH_EINTR one (this time no general macro are 
needed).

> I do not understand exactly what happens, but the signal seems to be
> generated while running handle_syscall() called from handle_trap().
> Changing back to the sequence of calling waitpid() and handle_syscall()
> as it has been before the sysemu-patch removed the problem.

> Here is my patch (I also changed the panic message to include "err" and
> to print status in Hex):
This particular part is Ok, but could you, please, avoid trumpling over and 
removing the sysemu code? It's absolutely not needed.
If you enclose the last two ptrace calls in "if (!use_sysemu)" and you move 
the "handle_syscall" after them, you get your fix + no change for sysemu.


> --- tmp/linux-2.6.8.1/arch/um/kernel/skas/process.c     2004-09-17
> 19:20:15.000000000 +0200
>
> +++ linux-2.6.8.1/arch/um/kernel/skas/process.c 2004-09-20
> 21:31:39.451946258 +0200
>
> @@ -68,25 +68,25 @@
>
>                 return;
>
>         }
>
>
>
> -       handle_syscall(regs);
>
A side note: posting HTML messages is bad (on LKML it is enough to be totally 
& completely ignored, I guess); and the above is what the inline patch 
becomes while answering to an HTML message - could you please either send 
plain-text or move the patches to attachments (I strongly prefer the first 
solution)?

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
