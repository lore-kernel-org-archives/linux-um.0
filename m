Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3uAa-0006am-BF for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 03:22:48 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C3uAZ-00083v-5Q for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 03:22:48 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Processes & ptrace
References: <Pine.LNX.4.58.0409021039040.26986@fire.freeside.dnsalias.org>
In-Reply-To: <Pine.LNX.4.58.0409021039040.26986@fire.freeside.dnsalias.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200409051219.08946.blaisorblade_spam@yahoo.it>
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
Date: Sun, 5 Sep 2004 12:19:08 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Carl Holtje <lists@freeside.dnsalias.org>, Sam T Sander <ssander@rocketmail.com>

Alle 16:50, gioved=EC 2 settembre 2004, Carl Holtje ha scritto:
> All-
>
> I'm looking to port user mode linux (UML) to the ARM platform. To this
> end, I've acquired an iPAQ running the 0.7.2 version of the Familiar linux
> distro (http://familiar.handhelds.org/), running the
> 2.4.19-rmk6-pxa1-hh30 kernel.

Few days ago, Sam T Sander <ssander@rocketmail.com> stated he's working on =

such a port, and he had the same problem. So, you should probably join.

My first question is why all this sudden interest in porting UML to ARM - a=
nd=20
by the way, how much RAM does an iPAQ contains?

Also, currently, UML works almost only on i386 (don't be fooled by ia64 and=
=20
ppc folders - the code does not work). So the porting page is out of date, =

and probably the SUBARCH splitting is not perfect. So you should look, for =

administrative details (i.e. the Makefile structure, how to split subarch- =

dependent and independent code, and so on), to the x86_64 for 2.6.4 you can=
=20
find on the main UML page.

And consider my answer (a bit updated from the one I gave him):

as of these days, this requirement has gone away *completely*.

The SYSEMU patch is the new, faster way to avoid that problem (actually, bo=
th=20
for SKAS and TT mode, which is something new from the last time I talked=20
about it).

Without it, when the guest does a syscall, we must avoid it is executed by =
the=20
host; that is, change it to a "getpid" syscall, let it run, make UML actual=
ly=20
run the syscall, replace the return value with the one provided by UML, and=
=20
making the process continue.

It is a patch for the host, which adds a "PTRACE_SYSEMU" (also called=20
PTRACE_SCEMU, but I deprecate the second name) ptrace mode, which is simila=
r=20
to PTRACE_SYSCALL, except that the syscall made by the ptraced process is n=
ot=20
executed. So we don't need the "change the syscall to getpid()" step. And, =

much more important, the host patch is much simpler.

You can find the version posted by Jeff Dike at=20

http://marc.theaimsgroup.com/?l=3Duser-mode-linux-devel&m=3D109323338224468=
&w=3D2

And note that it is just trivial.

> According to the UML porting page
> (http://user-mode-linux.sourceforge.net/arch-port.html),
> the first step is to ensure system call numbers are changeable by ptrace,
> and they provide small C program to compile and test with. The iPAQ
> "fails" this test as child processes have different pids than their
> parents.

Not clear at all what you mean... reading below I'd translate it to "getppi=
d()=20
lies about the real parent, so the test fails". Did I understand you=20
correctly?
However, please note that the getppid() semantics change under ptrace (it=20
returns the tracing process pid, not the real parent, IIRC), and maybe ARM =
is=20
somehow different.

> This seems rather contrary, however, to other observations about the
> system. For example, a listing from top shows processes and their
> associated pid and ppid fields -- many processes report proper parents
> (ppid matches reasonable pids).

> I would certainly hope Familiar is not=20
> monkeying with things to make it appear this way...
Well, you shouldn't be so much suspicious.
> Admitidly, this sounds like a question for the Familiar folks, but I'm
> wondering if this is a kernel issue, and if it's since been fixed in more
> recent kernel versions. (Familiar hasn't been updated in quite some time)

> I'm looking to use the 2.6 kernel for both host and guests, especially
> with 2.6.9-rc1-mm1 containing UML 'natively'. I've looked through the
> kernel changelogs for any helpful nuggets to this end, but have come home
> empty handed.

Hmm, well, it was in the 2.6.8.1-rc1-mm4, and then, after 2.6.9-rc1, it has=
=20
been merged, as you can see here:

http://kerneltrap.org/node/view/3720

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idP47&alloc_id=10808&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
