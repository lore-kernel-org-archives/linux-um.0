Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GLonI-0001R3-3O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Sep 2006 15:25:52 -0700
Received: from hpsmtp-eml07.kpnxchange.com ([213.75.38.107])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GLonD-0002UV-Mk
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Sep 2006 15:25:52 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Sat, 9 Sep 2006 00:25:28 +0200
Message-ID: <EBD0B8CF381E8B44BB99E8EA137E27C0021AD010@CPEXBE-EML06.kpnsp.local>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<200503072044.49206.blaisorblade@yahoo.it>
	<200503080010.j280ABbc005264@ccure.user-mode-linux.org>
	<200503132106.35599.blaisorblade@yahoo.it>
From: <i.r.wezeman@hetnet.nl>
Subject: Re: [uml-devel] Partial fix! - Was: Re: [BUG report] UML linux-2.6
	latest BK doesn't compile
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0429868319=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.

--===============0429868319==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6D395.B063FA15"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6D395.B063FA15
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi there.

I got a error undefined reference to `__bb_init_func' when compiling uml =
with kernel 2.6.17.6, gcc 4.1.1 and glibc-2.4

Done: make clean && make distclean && make allmodconfig ARCH=3Dum

# CONFIG_GPROF is not set
CONFIG_GCOV=3Dy

#
# UML-specific options
#
# CONFIG_MODE_TT is not set
# CONFIG_STATIC_LINK is not set
CONFIG_MODE_SKAS=3Dy


Build: make linux ARCH=3Dum


edit file: uml/arch/um/os-Linux/sys-i386/registers.c

	err =3D ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
	if(err)
		panic("check_ptrace : PTRACE_GETFPREGS failed, errno =3D %d",
		      errno);
}

#ifndef JB_PC
#define JB_PC 5
#define JB_SP 4
#define JB_BP 3
#endif

void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)

Edit file: uml/arch/um/os-Linux/sys-x86_64/registers.c

		panic("check_ptrace : PTRACE_GETFPREGS failed, errno =3D %d",
		      errno);
}

#ifndef JB_PC
#define JB_PC 7
#define JB_RSP 6
#define JB_RBP 1
#endif=20

void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
{
	struct __jmp_buf_tag *jmpbuf =3D buffer;

Ending:

arch/um/kernel/built-in.o:(__ksymtab+0x238): undefined reference to =
`__bb_init_func'
arch/um/os-Linux/built-in.o: In function `do_syscall_stub':
arch/um/os-Linux/skas/mem.c:63: undefined reference to =
`get_safe_registers'
arch/um/os-Linux/built-in.o: In function `copy_context_skas0':
arch/um/os-Linux/skas/process.c:333: undefined reference to =
`get_safe_registers'
collect2: ld returned 1 exit status
  KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: *** [.tmp_kallsyms1.S] Error 1

I see it must be solved. So wat is happend now?

Ron Wezeman

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org on behalf of Blaisorblade
Sent: Sun 3/13/2005 9:06 PM
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike; Anton Altaparmakov; lkml
Subject: Re: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML =
linux-2.6 latest BK doesn't compile
=20
Ok, I think I finally solved this problem.

A note for Jeff: I forgot to send this email and complained to you =
because you=20
didn't answer... Sorry Jeff.

However, I explained what I say here to him in chat and we agreed on the =
fix.

I'm sending this anyway... and I'm attaching the correct fix we =
discussed.

On Tuesday 08 March 2005 01:10, Jeff Dike wrote:
> blaisorblade@yahoo.it said:
> > a) wrong because you say __GNUC_PATCHLEVEL__ > 4 rather than >=3D

> Correct, this is now fixed.

> > b) wrong because for he the link failed on __bb_init_func at the
> > beginning. So  in the case you need to export BOTH symbols.

> Incorrect, the link failure was caused by trying to export =
__bb_init_func,
> which makes a reference to it, which was subsequently not being =
resolved.
No, the link failure was when linking the first object together in the =
final=20
file.

The symbol was referred to by the wrappers inserted by GCC for gprof /=20
gcov, not by the symbol exporting.

Quoting Anton:
> Yes.  I finally found a way to get it to compile.  Compiling without =
TT
> mode and WITHOUT static build it still fails with the same problem
> (__bb_init_func problem I already reported).  But compiling without TT
> but WITH static build the __bb_init_func problem goes away but instead =
I
> get a __gcov_init missing symbol in my modules.

And it was fixed when linking statically, as you see (because the symbol =
is=20
not defined in dynamic libraries - don't know if this is a bug of glibc, =
I=20
hope not).

What was needed was the addition of another EXPORT_SYMBOL, but it =
couldn't be=20
added for everybody because it causes the build to fail for old =
compilers=20
which don't export the symbol.

And "old compilers" include normal gcc 3.3.4 (I verified this on my =
Gentoo=20
system).

Also, maybe adding a dependency on static linking for GCOV is needed, =
maybe.

After some successful testing (maybe I didn't test all cases), however,=20
something strange happened: the build started failing because now GCC=20
requires the GCOV options (-fprofile-arcs -ftest-coverage) even during=20
linking (because the gcov helper functions are now in a separate =
library). I=20
said "strange" because the same build succeeded with gcc 3.3.4, and I =
didn't=20
understand the difference at first.

This required two changes:
- excluding the profiling options from the mk_* utilities.
- adding the GCOV options to linking (this is even documented now). I've =

retested that this wasn't needed with gcc 3.3.4 (and I guess older =
ones).

Finally, I got an unresolved symbol on __bb_fork_func, and I wasn't able =
to=20
solve this (is it maybe a bug in libc or whatever? I don't know).
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




------_=_NextPart_001_01C6D395.B063FA15
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML =
linux-2.6 latest BK doesn't compile</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi there.<BR>
<BR>
I got a error undefined reference to `__bb_init_func' when compiling uml =
with kernel 2.6.17.6, gcc 4.1.1 and glibc-2.4<BR>
<BR>
Done: make clean &amp;&amp; make distclean &amp;&amp; make allmodconfig =
ARCH=3Dum<BR>
<BR>
# CONFIG_GPROF is not set<BR>
CONFIG_GCOV=3Dy<BR>
<BR>
#<BR>
# UML-specific options<BR>
#<BR>
# CONFIG_MODE_TT is not set<BR>
# CONFIG_STATIC_LINK is not set<BR>
CONFIG_MODE_SKAS=3Dy<BR>
<BR>
<BR>
Build: make linux ARCH=3Dum<BR>
<BR>
<BR>
edit file: uml/arch/um/os-Linux/sys-i386/registers.c<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D =
ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(err)<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; panic(&quot;check_ptrace : =
PTRACE_GETFPREGS failed, errno =3D %d&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errno);<BR>
}<BR>
<BR>
#ifndef JB_PC<BR>
#define JB_PC 5<BR>
#define JB_SP 4<BR>
#define JB_BP 3<BR>
#endif<BR>
<BR>
void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)<BR>
<BR>
Edit file: uml/arch/um/os-Linux/sys-x86_64/registers.c<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; panic(&quot;check_ptrace : =
PTRACE_GETFPREGS failed, errno =3D %d&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errno);<BR>
}<BR>
<BR>
#ifndef JB_PC<BR>
#define JB_PC 7<BR>
#define JB_RSP 6<BR>
#define JB_RBP 1<BR>
#endif<BR>
<BR>
void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct __jmp_buf_tag *jmpbuf =
=3D buffer;<BR>
<BR>
Ending:<BR>
<BR>
arch/um/kernel/built-in.o:(__ksymtab+0x238): undefined reference to =
`__bb_init_func'<BR>
arch/um/os-Linux/built-in.o: In function `do_syscall_stub':<BR>
arch/um/os-Linux/skas/mem.c:63: undefined reference to =
`get_safe_registers'<BR>
arch/um/os-Linux/built-in.o: In function `copy_context_skas0':<BR>
arch/um/os-Linux/skas/process.c:333: undefined reference to =
`get_safe_registers'<BR>
collect2: ld returned 1 exit status<BR>
&nbsp; KSYM&nbsp;&nbsp;&nbsp; .tmp_kallsyms1.S<BR>
nm: '.tmp_vmlinux1': No such file<BR>
No valid symbol.<BR>
make: *** [.tmp_kallsyms1.S] Error 1<BR>
<BR>
I see it must be solved. So wat is happend now?<BR>
<BR>
Ron Wezeman<BR>
<BR>
-----Original Message-----<BR>
From: linux-kernel-owner@vger.kernel.org on behalf of Blaisorblade<BR>
Sent: Sun 3/13/2005 9:06 PM<BR>
To: user-mode-linux-devel@lists.sourceforge.net<BR>
Cc: Jeff Dike; Anton Altaparmakov; lkml<BR>
Subject: Re: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML =
linux-2.6 latest BK doesn't compile<BR>
<BR>
Ok, I think I finally solved this problem.<BR>
<BR>
A note for Jeff: I forgot to send this email and complained to you =
because you<BR>
didn't answer... Sorry Jeff.<BR>
<BR>
However, I explained what I say here to him in chat and we agreed on the =
fix.<BR>
<BR>
I'm sending this anyway... and I'm attaching the correct fix we =
discussed.<BR>
<BR>
On Tuesday 08 March 2005 01:10, Jeff Dike wrote:<BR>
&gt; blaisorblade@yahoo.it said:<BR>
&gt; &gt; a) wrong because you say __GNUC_PATCHLEVEL__ &gt; 4 rather =
than &gt;=3D<BR>
<BR>
&gt; Correct, this is now fixed.<BR>
<BR>
&gt; &gt; b) wrong because for he the link failed on __bb_init_func at =
the<BR>
&gt; &gt; beginning. So&nbsp; in the case you need to export BOTH =
symbols.<BR>
<BR>
&gt; Incorrect, the link failure was caused by trying to export =
__bb_init_func,<BR>
&gt; which makes a reference to it, which was subsequently not being =
resolved.<BR>
No, the link failure was when linking the first object together in the =
final<BR>
file.<BR>
<BR>
The symbol was referred to by the wrappers inserted by GCC for gprof =
/<BR>
gcov, not by the symbol exporting.<BR>
<BR>
Quoting Anton:<BR>
&gt; Yes.&nbsp; I finally found a way to get it to compile.&nbsp; =
Compiling without TT<BR>
&gt; mode and WITHOUT static build it still fails with the same =
problem<BR>
&gt; (__bb_init_func problem I already reported).&nbsp; But compiling =
without TT<BR>
&gt; but WITH static build the __bb_init_func problem goes away but =
instead I<BR>
&gt; get a __gcov_init missing symbol in my modules.<BR>
<BR>
And it was fixed when linking statically, as you see (because the symbol =
is<BR>
not defined in dynamic libraries - don't know if this is a bug of glibc, =
I<BR>
hope not).<BR>
<BR>
What was needed was the addition of another EXPORT_SYMBOL, but it =
couldn't be<BR>
added for everybody because it causes the build to fail for old =
compilers<BR>
which don't export the symbol.<BR>
<BR>
And &quot;old compilers&quot; include normal gcc 3.3.4 (I verified this =
on my Gentoo<BR>
system).<BR>
<BR>
Also, maybe adding a dependency on static linking for GCOV is needed, =
maybe.<BR>
<BR>
After some successful testing (maybe I didn't test all cases), =
however,<BR>
something strange happened: the build started failing because now =
GCC<BR>
requires the GCOV options (-fprofile-arcs -ftest-coverage) even =
during<BR>
linking (because the gcov helper functions are now in a separate =
library). I<BR>
said &quot;strange&quot; because the same build succeeded with gcc =
3.3.4, and I didn't<BR>
understand the difference at first.<BR>
<BR>
This required two changes:<BR>
- excluding the profiling options from the mk_* utilities.<BR>
- adding the GCOV options to linking (this is even documented now). =
I've<BR>
retested that this wasn't needed with gcc 3.3.4 (and I guess older =
ones).<BR>
<BR>
Finally, I got an unresolved symbol on __bb_fork_func, and I wasn't able =
to<BR>
solve this (is it maybe a bug in libc or whatever? I don't know).<BR>
--<BR>
Paolo Giarrusso, aka Blaisorblade<BR>
Linux registered user n. 292729<BR>
<A =
HREF=3D"http://www.user-mode-linux.org/~blaisorblade">http://www.user-mod=
e-linux.org/~blaisorblade</A><BR>
<BR>
<BR>
<BR>
-<BR>
To unsubscribe from this list: send the line &quot;unsubscribe =
linux-kernel&quot; in<BR>
the body of a message to majordomo@vger.kernel.org<BR>
More majordomo info at&nbsp; <A =
HREF=3D"http://vger.kernel.org/majordomo-info.html">http://vger.kernel.or=
g/majordomo-info.html</A><BR>
Please read the FAQ at&nbsp; <A =
HREF=3D"http://www.tux.org/lkml/">http://www.tux.org/lkml/</A><BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6D395.B063FA15--


--===============0429868319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0429868319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0429868319==--
