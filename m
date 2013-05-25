Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hopsingk@gmail.com>) id 1UgNSx-0005kN-Jj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 May 2013 23:01:35 +0000
Received: from mail-wg0-f50.google.com ([74.125.82.50])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UgNSw-0007ma-HL
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 25 May 2013 23:01:35 +0000
Received: by mail-wg0-f50.google.com with SMTP id k13so3595696wgh.29
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 25 May 2013 16:01:28 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 26 May 2013 01:01:28 +0200
Message-ID: <CAN-KreM81NDbqZ+XhxD_BjsM=VJz=+nJQ0B1fFTNk69cTSV_8g@mail.gmail.com>
From: Hopsing K <hopsingk@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8339702701749875926=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] How is Preemption implemented in User Mode Linux?
To: user-mode-linux-devel@lists.sourceforge.net

--===============8339702701749875926==
Content-Type: multipart/alternative; boundary=089e01419d744584c104dd92e5c1

--089e01419d744584c104dd92e5c1
Content-Type: text/plain; charset=ISO-8859-1

I'm running UML in Linux 3.2 (Debian) in SKAS0 mode. I compiled UML with
defconfig.
Now I try to  poked in the source to figure out how Preemption is done
in UML. I came so far to understand that there is a ptrace-ing parent and
for each UML process a userspace-slave process on the host:
arch/um/os-Linux/skas/process.c:userspace(). This routine also has the jump
to
interrupt_end() which calls schedule(). I saw that SIGALRM handler is
installed
for that ptrace-ing parent and the userspace() loop catches SIGALRM for the
traced slave. However I didnt see it being called. Only the ptrace-ing
parent
gets SIGALRM and the signal handler
arch/um/os-Linux/signal.c:hard_handler()
is called directly. With my understanding there must be some connection
between
hard_handler() and the call to interrupt_end() inside the userspace() loop,
but I
cannot find any, I cannot figure out how Preemption is initiated when the
SIGALRM arrives.
I wonder: Is all kernel code implementing cooperative threading ? Is there
no preemption when in kernel space?
If a userspace process runs a loop "while(1);" and therefore never calls out
to the kernel, how can another process been sheduled? The ptrace-ing
parent's
userspace() loop will never get control back.
I can also see a variable userspace_pid[0] that I assume is the active
slave-process and that there is only one such process running at any time,
the others are stopped?
I'm really curious how Preemption is done internally in UML, any insight
would
be welcome.
Some question at the side: can you call longjmp from within a signal
handler? My first assumption was that UML uses longjmp from within
the SIGALRM handler to implement preemption, butseems not to .
-- Thanks Konrad

--089e01419d744584c104dd92e5c1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m running UML in Linux 3.2 (Debian) in SKAS0 mode. I=
 compiled UML with defconfig.=A0<div style>Now I try to =A0poked in the sou=
rce to figure out how Preemption is done</div><div style>in UML. I came so =
far to understand that there is a ptrace-ing parent and=A0</div>
<div style>for each UML process a userspace-slave process on the host:=A0</=
div><div style>arch/um/os-Linux/skas/process.c:userspace(). This routine al=
so has the jump to=A0</div><div style>interrupt_end() which calls schedule(=
). I saw that SIGALRM handler is installed</div>
<div style>for that ptrace-ing parent and the userspace() loop catches SIGA=
LRM for the</div><div style>traced slave. However I didnt see it being call=
ed. Only the ptrace-ing parent</div><div style>gets SIGALRM and the signal =
handler arch/um/os-Linux/signal.c:hard_handler()=A0</div>
<div style>is called directly. With my understanding there must be some con=
nection between</div><div style>hard_handler() and the call to interrupt_en=
d() inside the userspace() loop, but I=A0</div><div style>cannot find any, =
I cannot figure out how Preemption is initiated when the=A0</div>
<div style>SIGALRM arrives.=A0</div><div style>I wonder: Is all kernel code=
 implementing cooperative threading ? Is there=A0</div><div style>no preemp=
tion when in kernel space?</div><div style>If a userspace process runs a lo=
op &quot;while(1);&quot; and therefore never calls out</div>
<div style>to the kernel, how can another process been sheduled? The ptrace=
-ing parent&#39;s=A0</div><div style>userspace() loop will never get contro=
l back.=A0</div><div style>I can also see a variable userspace_pid[0] that =
I assume is the active<br>
</div><div style>slave-process and that there is only one such process runn=
ing at any time,</div><div style>the others are stopped?</div><div style>I&=
#39;m really curious how Preemption is done internally in UML, any insight =
would=A0</div>
<div style>be welcome.</div><div style>Some question at the side: can you c=
all longjmp from within a signal</div><div style>handler? My first assumpti=
on was that UML uses longjmp from within</div><div style>the SIGALRM handle=
r to implement preemption, butseems not to .</div>
<div style>-- Thanks Konrad</div><div style><br></div></div>

--089e01419d744584c104dd92e5c1--


--===============8339702701749875926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
--===============8339702701749875926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============8339702701749875926==--


