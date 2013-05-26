Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hopsingk@gmail.com>) id 1UgcFg-00087b-4F
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 May 2013 14:48:52 +0000
Received: from mail-we0-f174.google.com ([74.125.82.174])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UgcFc-0003FJ-RJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 May 2013 14:48:52 +0000
Received: by mail-we0-f174.google.com with SMTP id x50so1968726wes.19
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 May 2013 07:48:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFLxGvy_SvjdTJ97DtCFubUAPgJ4tSgZi8LFYNHEwN94cUZLFQ@mail.gmail.com>
References: <CAN-KreM81NDbqZ+XhxD_BjsM=VJz=+nJQ0B1fFTNk69cTSV_8g@mail.gmail.com>
	<CAFLxGvy_SvjdTJ97DtCFubUAPgJ4tSgZi8LFYNHEwN94cUZLFQ@mail.gmail.com>
Date: Sun, 26 May 2013 16:48:42 +0200
Message-ID: <CAN-KreN2SQV6Y=6kV7U5DmhxDctQCn-ocJHL=Jst7i7uhE3eOg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2286131373199313647=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] How is Preemption implemented in User Mode Linux?
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============2286131373199313647==
Content-Type: multipart/alternative; boundary=e89a8f646db5daff7804dda020de

--e89a8f646db5daff7804dda020de
Content-Type: text/plain; charset=ISO-8859-1

Hi, Ok, thanks. I got a little better picture. Is the following true:
- The ptrace-ing parent waits in waitpid() called from within the
 userspace() loops.
- The SIGVTALRM comes in and the signal handler is executed, it'll end up
  in scheduler_tick() and set need_resched() true.
- Because of the signal the waitpid() system call is interrupted and the
  ptrace-ing parent returnes from waitpid().
- At the same time the ptraced userspace slave is stopped (is this the
  case?) therefore the condition WIFSTOPPED(status) is true and
  therefore you end up calling interrupt_end() ?
-- Thanks Konrad




2013/5/26 richard -rw- weinberger <richard.weinberger@gmail.com>

> On Sun, May 26, 2013 at 1:01 AM, Hopsing K <hopsingk@gmail.com> wrote:
> > I'm running UML in Linux 3.2 (Debian) in SKAS0 mode. I compiled UML with
> > defconfig.
> > Now I try to  poked in the source to figure out how Preemption is done
> > in UML. I came so far to understand that there is a ptrace-ing parent and
> > for each UML process a userspace-slave process on the host:
> > arch/um/os-Linux/skas/process.c:userspace(). This routine also has the
> jump
> > to
> > interrupt_end() which calls schedule(). I saw that SIGALRM handler is
> > installed
> > for that ptrace-ing parent and the userspace() loop catches SIGALRM for
> the
> > traced slave. However I didnt see it being called. Only the ptrace-ing
> > parent
> > gets SIGALRM and the signal handler
> arch/um/os-Linux/signal.c:hard_handler()
> > is called directly. With my understanding there must be some connection
> > between
> > hard_handler() and the call to interrupt_end() inside the userspace()
> loop,
> > but I
> > cannot find any, I cannot figure out how Preemption is initiated when the
> > SIGALRM arrives.
> > I wonder: Is all kernel code implementing cooperative threading ? Is
> there
> > no preemption when in kernel space?
> > If a userspace process runs a loop "while(1);" and therefore never calls
> out
> > to the kernel, how can another process been sheduled? The ptrace-ing
> > parent's
> > userspace() loop will never get control back.
> > I can also see a variable userspace_pid[0] that I assume is the active
> > slave-process and that there is only one such process running at any
> time,
> > the others are stopped?
> > I'm really curious how Preemption is done internally in UML, any insight
> > would
> > be welcome.
> > Some question at the side: can you call longjmp from within a signal
> > handler? My first assumption was that UML uses longjmp from within
> > the SIGALRM handler to implement preemption, butseems not to .
> > -- Thanks Konrad
>
> UML installs a SIGVTALRM handler which feeds the TIMER_IRQ.
> In the generic TIMER_IRQ handler Linux runs scheduler_tick() at some point.
>
> Thanks,
> //richard
>

--e89a8f646db5daff7804dda020de
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, Ok, thanks. I got a little better picture. Is the foll=
owing true:<div>- The ptrace-ing parent waits in waitpid() called from with=
in the =A0userspace() loops.</div><div>- The SIGVTALRM comes in and the sig=
nal handler is executed, it&#39;ll end up</div>
<div style>=A0 in scheduler_tick() and set need_resched() true.</div><div s=
tyle>- Because of the signal the waitpid() system call is interrupted and t=
he=A0</div><div style>=A0 ptrace-ing parent returnes from waitpid().</div><=
div style>
- At the same time the ptraced userspace slave is stopped (is this the</div=
><div style>=A0 case?) therefore the condition WIFSTOPPED(status) is true a=
nd=A0</div><div style>=A0 therefore you end up calling interrupt_end() ?</d=
iv>
<div style>-- Thanks Konrad</div><div style>=A0=A0</div><div style><br></di=
v></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2013/=
5/26 richard -rw- weinberger <span dir=3D"ltr">&lt;<a href=3D"mailto:richar=
d.weinberger@gmail.com" target=3D"_blank">richard.weinberger@gmail.com</a>&=
gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On S=
un, May 26, 2013 at 1:01 AM, Hopsing K &lt;<a href=3D"mailto:hopsingk@gmail=
.com">hopsingk@gmail.com</a>&gt; wrote:<br>

&gt; I&#39;m running UML in Linux 3.2 (Debian) in SKAS0 mode. I compiled UM=
L with<br>
&gt; defconfig.<br>
&gt; Now I try to =A0poked in the source to figure out how Preemption is do=
ne<br>
&gt; in UML. I came so far to understand that there is a ptrace-ing parent =
and<br>
&gt; for each UML process a userspace-slave process on the host:<br>
&gt; arch/um/os-Linux/skas/process.c:userspace(). This routine also has the=
 jump<br>
&gt; to<br>
&gt; interrupt_end() which calls schedule(). I saw that SIGALRM handler is<=
br>
&gt; installed<br>
&gt; for that ptrace-ing parent and the userspace() loop catches SIGALRM fo=
r the<br>
&gt; traced slave. However I didnt see it being called. Only the ptrace-ing=
<br>
&gt; parent<br>
&gt; gets SIGALRM and the signal handler arch/um/os-Linux/signal.c:hard_han=
dler()<br>
&gt; is called directly. With my understanding there must be some connectio=
n<br>
&gt; between<br>
&gt; hard_handler() and the call to interrupt_end() inside the userspace() =
loop,<br>
&gt; but I<br>
&gt; cannot find any, I cannot figure out how Preemption is initiated when =
the<br>
&gt; SIGALRM arrives.<br>
&gt; I wonder: Is all kernel code implementing cooperative threading ? Is t=
here<br>
&gt; no preemption when in kernel space?<br>
&gt; If a userspace process runs a loop &quot;while(1);&quot; and therefore=
 never calls out<br>
&gt; to the kernel, how can another process been sheduled? The ptrace-ing<b=
r>
&gt; parent&#39;s<br>
&gt; userspace() loop will never get control back.<br>
&gt; I can also see a variable userspace_pid[0] that I assume is the active=
<br>
&gt; slave-process and that there is only one such process running at any t=
ime,<br>
&gt; the others are stopped?<br>
&gt; I&#39;m really curious how Preemption is done internally in UML, any i=
nsight<br>
&gt; would<br>
&gt; be welcome.<br>
&gt; Some question at the side: can you call longjmp from within a signal<b=
r>
&gt; handler? My first assumption was that UML uses longjmp from within<br>
&gt; the SIGALRM handler to implement preemption, butseems not to .<br>
&gt; -- Thanks Konrad<br>
<br>
</div></div>UML installs a SIGVTALRM handler which feeds the TIMER_IRQ.<br>
In the generic TIMER_IRQ handler Linux runs scheduler_tick() at some point.=
<br>
<br>
Thanks,<br>
//richard<br>
</blockquote></div><br></div>

--e89a8f646db5daff7804dda020de--


--===============2286131373199313647==
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
--===============2286131373199313647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2286131373199313647==--


