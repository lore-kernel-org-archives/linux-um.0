Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw4RZ-0001gM-Fm for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 11:11:41 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Aw4Ic-0005X1-JU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 11:02:26 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] System Call Mechanism
References: <40352B06.3030406@users.sourceforge.net>
In-Reply-To: <40352B06.3030406@users.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200402251652.52680.blaisorblade_spam@yahoo.it>
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
Date: Wed, 25 Feb 2004 16:52:52 +0100
Content-Transfer-Encoding: quoted-printable
To: kuas <ku4s@users.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net

Alle 22:30, gioved=EC 19 febbraio 2004, kuas ha scritto:
> Hello,
>
> I'm posting this question to here since this is development problem, the
> other newsgroup seems to be more like users problem and I would think
> this forum would be able to explain more about my question. I will post
> to the other newsgroup if that's the  one where I should really be posting

Perfect choice. I'll try to answer, for things I know or I *think* to know.

> I seems to me the new or current implementation of system call involves
> conversion from interupt 80 at the host OS into signals back in UML
> kernel. Is this the same mechanism for the current TT and SKAS? Or  TT
> mode still using ptrace thread tracing mechanism to intercept the system
> call?

SKAS mode, the more modern one, still uses the same interception mechanism =
as=20
TT: i.e. ptraces the child, intercepts the syscall, nullifies it (i.e. the =

host kernel receives a getpid syscall) and goes on. Look at these files:

arch/um/kernel/skas/process.c: handle_trap () and userspace().
arch/um/kernel/skas/syscall_*.c

Only difference is that in SKAS mode you have one single child process bein=
g=20
ptraced, on the host; it runs the virtual processes code, and does syscall =

with int 0x80 which are intercepted. To do a context switch, UML uses setjm=
p=20
and longjmp to switch the stack state and PTRACE_SWITCH_MM (implemented on =

the host inside arch/i386/kernel/ptrace.c, read the skas patch) to switch t=
he=20
virtual mappings of the child at once. More details about memory handling a=
t=20
request, since you asked for one exact thing and maybe are not interested i=
n=20
this.

> If there is a signal from the host to UML kernel process, there
> must be a signal handler registered by the UML kernel.
>
> Any quick deeper overview about this mechanism would be really welcome.
> Thanks in advance.


--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
