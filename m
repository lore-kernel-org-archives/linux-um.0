Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJuAG-0003Do-7T for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 06:36:36 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CJuAF-0006R7-H8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Oct 2004 06:36:36 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] basic queries
References: <20041007064432.14876.qmail@webmail46.rediffmail.com>
In-Reply-To: <20041007064432.14876.qmail@webmail46.rediffmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-15"
Message-Id: <200410191535.57682.blaisorblade_spam@yahoo.it>
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
Date: Tue, 19 Oct 2004 15:35:57 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net, young engineer <y.engineer@rediffmail.com>

On Thursday 07 October 2004 08:44, young engineer wrote:
>  =A0 hi all
>  im new to linux and started using UML. Some basic queries from my side
>  1. UML is run as process, is there difference betweeen other normal linux
> processes? is it a higher priority process?
No. In TT mode, it is a completely standard Linux process, with more thread=
s,=20
and making use of Ptrace.
> 2. When UML boots, it does the=20
> same things as a linux kernel booting steps.

> But what devices it=20
> initializes during this process? It is a process so how it does these
> things?

The Linux kernel contains two kinds of initialization code: one related to =
the=20
hw architecture and one independent from the hw architecture. And UML is=20
another "hw architecture", i.e. one different directory in arch/. So it doe=
s=20
not execute any kind of hardware related initialization.

Also, devices are managed by device drivers. Uml does not use the device=20
drivers talking with hardware. For instance, the "Hard Disk" driver used by=
=20
UML manages /dev/ubd* as if they were hard disks, but actually instead of=20
managing the hard disks, it manages some normal file of the host.
> 3. What changes makes it a linux OS to linux process? what changes=20
> makes it a process?
No, read the answer above. You have some wrong ideas to ask this question, =
so=20
I cannot answer directly.

The architecture code handles relationship with the hardware, on physical=20
archs, and with the host, in the UML case. Then, the architecture code=20
provides some basical things to the rest of the kernel (physical RAM, virtu=
al=20
memory, a mean to intercept system calls).

> 4. Is there abstraction like kernel and process inside=20
> a UML which is itself a process? how?
You have threads. One thread is special and runs kernel code (plus some mor=
e=20
kernel code threads). The other threads, in TT mode, run the processes code.
> 5. How system calls & interrupts are=20
> managed in UML?
Both in TT and SKAS mode, it is done by ptrace(2): you ptrace(PTRACE_SYSCAL=
L)=20
a thread running the userspace code, it starts running, then when it does a=
=20
syscall, it is stopped. UML then executes the syscall, while changing the=20
child stack so that the host sees only a getpid() call (which does not hurt=
).

>  6. UML is a process so it has process address space. Is it further divid=
ed
> into kernel address space and user address space in which other process c=
an
> be run in UML or other processes uses host user address space ?
In TT mode, the part 0-2.5G is reserved to the userspace processes, while t=
he=20
part 2.5-3G is reserved for the UML kernel.

In SKAS mode, instead, even if there is one thread which is ptraced (the on=
e=20
in T mode in "ps auxw" output), it runs with different memory spaces. Think=
=20
of more processes, each one with its memory, without the ability to interfe=
re=20
with other ones except for what explicitally allowed by the Linux kernel (i=
n=20
this case the UML one). But they are merged in one process from the host=20
point of view, thanks to the SKAS patch.

About memory layout, the physical memory is mapped from 0-3G inside the UML=
=20
Linux kernel process (the thread with the lowest PID), while each process=20
sees an independent memory layout from 0 to 3G. For comparison, this is lik=
e=20
the layout created by Ingo Molnar's 4G/4G patch.

>  Is there any documents abt internals of UML?
Hmmm - search the main web site, for slides and whatever. You have to dig e=
ven=20
more than with the normal Linux kernel. And remember that the docs you find=
,=20
in the Kernel world, are often outdated, so they contain wrong infos. But=20
even so, they are useful: you must see the differences when reading the=20
source.

>  Plz reply me back ..thanks in advance
Bye and good work with UML!
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
