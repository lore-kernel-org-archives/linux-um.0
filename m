Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <4CEA4EAF.6090209@cs.atlas-brb.de>
References: <4CEA4EAF.6090209@cs.atlas-brb.de>
Date: Mon, 22 Nov 2010 14:26:43 +0100
Message-ID: <AANLkTikk6dvPJjG9CxVRrfYGuS+a5KbedYOrKq7GjmEC@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [uml-devel] immediately segfault with con0=tty:/dev/ttyXY
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Nico Rittner <nrittner@cs.atlas-brb.de>
Cc: gentoo-user@lists.gentoo.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Mon, Nov 22, 2010 at 12:06 PM, Nico Rittner <nrittner@cs.atlas-brb.de> w=
rote:
> immediately segfault with con0=3Dtty:/dev/tty10
>
> Calling UML with con0=3Dtty:/dev/tty10 immediately
> leads to segfault.
>
> uml : ~ $ bin/image initrd=3Dbin/initrd init=3D/linuxrc mem=3D256M
> umid=3Dapp.dev.dpvw eth0=3Dtuntap,,,192.168.178.21 con0=3Dtty:/dev/tty9 c=
on1=3Dnull
> con2=3Dnull con3=3Dnull con4=3Dnull con5=3Dnull con6=3Dnull con7=3Dnull c=
on8=3Dnull
> con9=3Dnull con10=3Dnull con11=3Dnull con12=3Dnull root=3D/dev/ram0 realm=
=3Dgrw
> readonly=3D/dev/ubdb readwrite=3D/dev/ubdc ubdc=3Dmachines/app.dev.dpvw/u=
bdc
> ubda=3Dmachines/app.dev.dpvw/ubda ubdb=3Dmachines/app.dev.dpvw/ubdb
> Locating the bottom of the address space ... 0x1000
> Locating the top of the address space ... 0xc0000000
> Core dump limits :
> =A0 =A0 =A0 =A0soft - 0
> =A0 =A0 =A0 =A0hard - NONE
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...OK
> Checking advanced syscall emulation patch for ptrace...OK
> Checking for tmpfs mount on /dev/shm...nothing mounted on /dev/shm
> Checking PROT_EXEC mmap in /tmp/...OK
> Checking for the skas3 patch in the host:
> =A0- /proc/mm...not found: No such file or directory
> =A0- PTRACE_FAULTINFO...not found
> =A0- PTRACE_LDT...not found
> UML running in SKAS0 mode
> Segmentation fault
> uml : ~ $
>
> Whenn changing con0 to 'null' or 'fd:0,fd:1'
> the segfault disappears and the uml is booting
> without problems. The user the UML runs
> under is member of the tty group and able to
> write to /dev/ttyXY.
> Both UML and Host source tree is 2.6.34-gentoo-r12
> from gentoo portage. uml config is attached.
>
> The last lines when running with strace are:

Can you please post the output of "strace ./linux con0=3Dtty:/dev/tty9
... 2>&1 | grep tty9"
Does the problem also occur on the most current vanilla kernel?

> waitpid(19109, [{WIFSTOPPED(s) && WSTOPSIG(s) =3D=3D 133}], WSTOPPED|__WA=
LL) =3D
> 19109
> ptrace(PTRACE_GETREGS, 19109, 0, 0x17c59e04) =3D 0
> ptrace(PTRACE_SETREGS, 19109, 0, 0x17c59e04) =3D 0
> ptrace(0x1f /* PTRACE_??? */, 19109, 0, 0) =3D 0
> --- SIGCHLD (Child exited) @ 0 (0) ---
> waitpid(19109, [{WIFSTOPPED(s) && WSTOPSIG(s) =3D=3D SIGSEGV}], WSTOPPED|=
__WALL)
> =3D 19109
> ptrace(PTRACE_GETREGS, 19109, 0, 0x17c59e04) =3D 0
> ptrace(PTRACE_GETFPXREGS, 19109, 0, 0x17c63d58) =3D 0
> ptrace(PTRACE_CONT, 19109, 0, SIGSEGV) =A0=3D 0
> --- SIGCHLD (Child exited) @ 0 (0) ---
> waitpid(19109, [{WIFSTOPPED(s) && WSTOPSIG(s) =3D=3D SIGTRAP}], WSTOPPED|=
__WALL)
> =3D 19109
> ptrace(PTRACE_SETFPXREGS, 19109, 0, 0x17c63d58) =3D 0
> ptrace(PTRACE_SETREGS, 19109, 0, 0x8253960) =3D 0
> ptrace(PTRACE_CONT, 19109, 0, SIG_0) =A0 =A0=3D 0
> --- SIGCHLD (Child exited) @ 0 (0) ---
> waitpid(19109, [{WIFSTOPPED(s) && WSTOPSIG(s) =3D=3D SIGTRAP}], WSTOPPED|=
__WALL)
> =3D 19109
> ptrace(PTRACE_SETREGS, 19109, 0, 0x17c59e04) =3D 0
> ptrace(0x1f /* PTRACE_??? */, 19109, 0, 0) =3D 0
> --- SIGCHLD (Child exited) @ 0 (0) ---
> waitpid(19109, [{WIFSTOPPED(s) && WSTOPSIG(s) =3D=3D 133}], WSTOPPED|__WA=
LL) =3D
> 19109
> ptrace(PTRACE_GETREGS, 19109, 0, 0x17c59e04) =3D 0
> rt_sigaction(SIGSEGV, {SIG_DFL, [SEGV], SA_RESTART}, {0x8070d30, [USR1
> VTALRM WINCH IO], SA_STACK|SA_NODEFER}, 8) =3D 0
> rt_sigaction(SIGTERM, {SIG_IGN, [TERM], SA_RESTART}, {0x806d5c0, [],
> SA_NODEFER|SA_RESETHAND}, 8) =3D 0
> kill(0, SIGTERM <unfinished ...>
>
>
> Further info:
> - gcc version 4.4.4 (Gentoo 4.4.4-r2 p1.2, pie-0.4.5)
> - GNU C Library stable release version 2.11.2
>
> How can i make uml work with ttys as console i/o?
>
>
> Thanks in advance!
>
> Nico
>
> -------------------------------------------------------------------------=
-----
> Beautiful is writing same markup. Internet Explorer 9 supports
> standards for HTML5, CSS3, SVG 1.1, =A0ECMAScript5, and DOM L2 & L3.
> Spend less time writing and =A0rewriting code and more time creating great
> experiences on the web. Be a part of the beta today
> http://p.sf.net/sfu/msIE9-sfdev2dev
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
>



-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

