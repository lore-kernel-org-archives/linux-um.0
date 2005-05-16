Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXoBt-000352-BT	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 15:36:01 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DXnVO-00073G-U4	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 14:54:48 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	<200505161908.08373.blaisorblade@yahoo.it>
	<3524bf1f05051611528eb7bc1@mail.gmail.com>
In-Reply-To: <3524bf1f05051611528eb7bc1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505162324.37749.blaisorblade@yahoo.it>
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
Date: Mon, 16 May 2005 23:24:37 +0200
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 16 May 2005 20:52, Young Koh wrote:
> Hi, Thanks for the reply. Let me have one following question.
>
> As my understand, in SKAS mode, tracer and tracee are different host
> processes, and they have UML kernel code and application code
> respectively. (in TT mode, tracee has both kernel and application
> code)
Yes, exactly.
> Suppose the tracee attmpts to invoke a host system call. then, it will
> be intercepted by the tracer as in TT mode. (In TT mode, the tracer
> turns off tracing and sends SIGUSR2 to the tracee, and then, the
> signal handler in the tracee will execute the system call.)
Ok, perfect.
> but, in 
> SKAS mode, because the tracee doesn't have the UML kernel code, only
> the tracer knows about the system call code. The tracer cannot simply
> send a signal to make the tracee execute the system call. Then how
> does it do? Does the tracer execute the system call for the tracee?

Exactly. in arch/um/kernel/skas/process.c, userspace() loops doing 
PTRACE_SYSCALL, and when SIGTRAP | 0x80 is received by waiting on the tracee, 
and it's handled by handle_trap(), which reads the syscall params in the 
registers saved by userspace. You'll probably find the 0x80 strange, since 
ptrace(2) documents SIGTRAP; but in recent UML kernels we set 
PTRACE_O_SYSGOOD so we get the additional 0x80 (which does not happen on 
normal SIGTRAP, due for instance to singlestepping).

See, in arch/i386/kernel/ptrace.c:do_syscall_trace(), the call to 
ptrace_notify().
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
