Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBrl3-0004aE-AE for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Sep 2004 02:25:21 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CBrl2-0004aN-Gt for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Sep 2004 02:25:21 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] (no subject)
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C3C@ABGEX01E.abg.fsc.net>
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
Date: Mon, 27 Sep 2004 11:20:06 +0200
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>

On Saturday 25 September 2004 21:35, BlaisorBlade wrote: 
> ...
> This particular part is Ok, but could you, please, avoid trumpling
over and removing the sysemu code? It's absolutely not needed.
> If you enclose the last two ptrace calls in "if (!use_sysemu)" and you
move the "handle_syscall" after them, you get your fix + no change for
sysemu.
Sorry. I didn't intend to break sysemu! Did I miss something or does it
come from my confusing mail format?
Here is the code of handle_trap() after applying the patch:

---
static void handle_trap(int pid, union uml_pt_regs *regs)
{
	int err, syscall_nr, status;

	syscall_nr = PT_SYSCALL_NR(regs->skas.regs);
	UPT_SYSCALL_NR(regs) = syscall_nr;
	if(syscall_nr < 0){
		relay_signal(SIGTRAP, regs);
		return;
	}

	if(!use_sysemu) {
		err = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET,
__NR_getpid);
		if(err < 0)
			panic("handle_trap - nullifying syscall failed,
errno = %d\n",
			      errno);

		err = ptrace(PTRACE_SYSCALL, pid, 0, 0);
		if(err < 0)
			panic("handle_trap - continuing to end of
syscall failed, "
			      "errno = %d\n", errno);

		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
		if((err < 0) || !WIFSTOPPED(status) || 
		   (WSTOPSIG(status) != SIGTRAP))
			panic("handle_trap - failed to wait at end of
syscall, "
			      "err = %d, errno = %d, status = %x\n",
err, errno, status);
	}

	handle_syscall(regs);
}

> ...
> A side note: posting HTML messages is bad (on LKML it is enough to be
totally & completely ignored, I guess); and the above is what the inline
patch becomes while answering to an HTML message - could you please
either send plain-text or move the patches to attachments (I strongly
prefer the first solution)?
OK. Thank you for the advice. Unfortunately I'm missing experience in
writing to mailing lists. And I have to do it with our companies Outlook
client...
In the meantime I found a switch to modify the settings to "text only".
Hope it's better now?

Bodo


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
