Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DR5iw-0003if-4K for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 02:54:22 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DR5iv-0003TF-Gd for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 02:54:21 -0700
Message-ID: <4270B2C9.2030603@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <OF558C84FC.0C649F6F-ONC1256FF1.002D4CEF-C1256FF1.002F4B2C@de.ibm.com>
In-Reply-To: <OF558C84FC.0C649F6F-ONC1256FF1.002D4CEF-C1256FF1.002F4B2C@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Again: UML on s390 (31Bit)
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
Date: Thu, 28 Apr 2005 11:54:17 +0200
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Martin Schwidefsky wrote:
> Bodo Stroesser <bstroesser@fujitsu-siemens.com> wrote on 04/27/2005
> 10:21:58 PM:
>>1) UML includes some of the subarch's (s390) headers. I had to
>>    change one of them with the following one-liner, to make this
>>    compile. AFAICS, this change doesn't break compilation of s390
>>    itself.
> 
> 
> This one isn't a problem. I'll add it to the repository.
Thank you!

> 
> 
>>==============================================================================
>>--- linux-2.6.11.orig/arch/s390/kernel/ptrace.c   2005-04-04 18:57:
>>38.000000000 +0200
>>+++ linux-2.6.11/arch/s390/kernel/ptrace.c   2005-04-04 19:01:51.
>>000000000 +0200
>>@@ -726,6 +726,13 @@
>>              ? 0x80 : 0));
>>
>>     /*
>>+    * If debugger has set an invalid syscall number,
>>+    * we prepare to skip syscall restart handling
>>+    */
>>+   if (!entryexit && (long )regs->gprs[2] < 0 )
>>+      regs->trap = -1;
>>+
>>+   /*
>>      * this isn't the same as continuing with a signal, but it will do
>>      * for normal use.  strace only continues with a signal if the
>>      * stopping signal is not SIGTRAP.  -brl
>>==============================================================================
> 
> 
> This patch is not good. !entryexit indicates that you want to change the trap
> indication on the first of the two calls of syscall_trace for a system call. The
> second condition is gprs[2] < 0 but that can be true for a normal system call as
> well, like sys_exit(-1).
Sorry, that's not right. At that point, gprs[2] holds the syscall number, while the
first argument of the syscall is in origgpr2. If the debugger sets the syscall number
to -1, which is an invalid syscall, changing trap to -1 will result in a changed
behavior only in case, that the debugger on the second syscall interception also sets
the syscall result to ERESTARTXXXXX (This again is modifying gprs[2]). ERESTARTXXXXX
normally would/could be handled by do_signal(), but with the patch it no longer will.
So, I think the patch doesn't hurt in normal cases, but does the trick for UML.

> It might even be true for user addresses if we really
> extent the virtual address space to full 64 bit one day (and the hardware can do
> it with a 5 level paging table). To change regs->trap to -1 with the current
> condition is definitly wrong.
> Independent from that it do not understand why you need it at all. If the
> uml host intercepted and invalidated the guest system call the system restart
> indication bit _TIF_RESTART_SVC shouldn't be set because the guest didn't
> execute a system call.
Let my explain a bit more. UML invalidates UML-user's syscalls on the host, processes
the syscall itself and inserts the result into gprs[2] on the second syscall
interception. For nearly all syscalls ERESTARTXXXXX is a result not returned to user,
but handled in UML kernel internally. But that's not true for sys_(rt_)sigreturn.
The "result" of those is the original contents of gpr2 of the interrupted routine,
which accidentally also might be ERESTARTXXXXXXX (BTW, that's the reason for
sys_(rt_)sigreturn setting trap to -1 also). We skip UML's syscall restart handling
in this case, but we need to skip it in the host, too.

> 
> blue skies,
>    Martin
> 
> Martin Schwidefsky
> Linux for zSeries Development & Services
> IBM Deutschland Entwicklung GmbH

Regards,  Bodo


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
