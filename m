Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFxZb-00062e-Ku for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 09:26:27 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CFxZa-0002V0-2O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Oct 2004 09:26:27 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] Kernel panic: check_ptrace : child exited with status
	0x100
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C56@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Fri, 8 Oct 2004 18:21:51 +0200
Content-Transfer-Encoding: 8bit
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: "Christopher S. Aker" <caker@theshore.net>, jdike@addtoit.com

On Friday 08 October 2004 13:59, BlaisorBlade wrote:
> I.e. you mean that this code (which is only in the 2.6/2.4 Jeff Dike
tree)
> 
> +               n = ptrace(PTRACE_POKEUSER, pid,
PT_SYSCALL_RET_OFFSET,
> +                          os_getpid());
> (which writes the return code value) is not the same as this code
(which is in 
> the 2.6.9-rc2 and following kernels):
> 
>                if (ptrace(PTRACE_GETREGS, pid, 0, &regs) < 0)
>                         panic("check_ptrace : failed to read child "
>                              "registers, errno = %d", errno);
>                 regs.orig_eax = pid;
>                 if (ptrace(PTRACE_SETREGS, pid, 0, &regs) < 0)
>                         panic("check_ptrace : failed to modify child "
>                               "registers, errno = %d", errno);
> (which writes to orig_eax, i.e. the syscall number)? I guess that they
are 
> actually different, but in this case I think that the correct code is
the one 
> found in the first case, i.e. in the jdike kernel tree. But I thought
you 
> used the jdike 2.6.8.1-1um kernel tree.
> 
> So using the jdike code in both kernels (for the guest problem) and
the patch 
> below for the host should solve all the issues, right?
Yes. I agree. But the only thing, that I can say, is, "it should solve".
Currently, I have no 2.6.7 host running, thus I can't test, even if I
would like to.

> Please clarify what you mean by "a certain UML will run only on
certain 
> hosts". You mean a SYSEMU patched UML will use SYSEMU only on certain
hosts, 
> right?
No. The problem is, if UML gets an error calling ptrace(PTRACE_SYSEMU,
...), it will
run without using sysemu. But if the ptrace-call returns "OK", it will
panic, if the
further checks fail!
I thought about host and UML with sysemu-support only. There you have
four possible
combinations, from which only one always panics! The other will work
mostly,
depending on the host-pids the processes have.

> > Solution:
> 
> > - the host-patch for 2.6 should be modified. Before calling
ptrace_notify()
> >   do_syscall_trace() should save the state of the PTRACE_SYSEMU
> > (true/false) and should use that saved state as return value.
> 
> Yes! Oh what fucking error! Is this patch correct (it's cut and paste,
so you 
> may apply it by hand)?
Sorry, I can't do that at the moment. But maybe Christopher can do that?

Bodo

For Christopher:
Sorry, I accidentally missed to CC you on my last mail. So, if you
are not on the list, you didn't missed this plus the mail from
BlaisorBlade.
Please look to the archive or request for a resend from me.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
