Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <amluto@gmail.com>) id 1Qvfbu-0008SG-4r
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 01:16:58 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Qvfbt-00063x-8P
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Aug 2011 01:16:58 +0000
Received: by yxl11 with SMTP id 11so2141398yxl.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Aug 2011 18:16:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110823010146.GY2203@ZenIV.linux.org.uk>
References: <20110822144051.GD2946@aftab>
	<20110822151305.GV2203@ZenIV.linux.org.uk>
	<CA+55aFwoRO9xxnTyt_gYFdTS9LsaFoCWRuyNeXY7gvrE8CdZ0A@mail.gmail.com>
	<4E52B7F8.3050002@zytor.com>
	<CAObL_7GmMXPUE0Oix1CKTYzqheyJV+ua=WEBUQk5m-LGsvqihw@mail.gmail.com>
	<4E52D280.3010107@zytor.com>
	<CA+55aFw4C+ShLHF2NYZMQ-Lhjow3mJ62_eqO_iAww2nh7V_-Uw@mail.gmail.com>
	<20110823000314.GW2203@ZenIV.linux.org.uk>
	<4E52EF2A.8060608@zytor.com>
	<CA+55aFx9zRTD72jaztLvyB68ejHcqM3Z3=b+6W64opfYu3ANjA@mail.gmail.com>
	<20110823010146.GY2203@ZenIV.linux.org.uk>
Date: Mon, 22 Aug 2011 21:16:50 -0400
Message-ID: <CAObL_7FG8eFTZ4djKH0T8tbRf2h6+iOm=OXr8194nvzc+w+a9A@mail.gmail.com>
From: Andrew Lutomirski <luto@mit.edu>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7354316279481545066=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] SYSCALL,
 ptrace and syscall restart breakages (Re: [RFC] weird crap with
 vdso on uml/i386)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@amd64.org>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>

--===============7354316279481545066==
Content-Type: multipart/alternative; boundary=000e0cd22f68519fea04ab21f3ba

--000e0cd22f68519fea04ab21f3ba
Content-Type: text/plain; charset=ISO-8859-1

On Aug 22, 2011 9:01 PM, "Al Viro" <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Aug 22, 2011 at 05:22:07PM -0700, Linus Torvalds wrote:
>
> > You guys seem to positively _want_ to make this a bigger issue than it
> > is. As far as I can tell, nobody has ever even noticed this problem
> > before, and we already have a trivial fix ("don't do it then") for the
> > case Al actually did notice.
>
> I'm not sure.   What I've noticed was complete weirdness in uml,
apparently
> dependent on SYSCALL vs. SYSENTER or int 0x80.  With following round of
> RTFS and finding what looks like an ugly issue with restarts.
>
> What I don't understand at all is how the hell do we manage to avoid much
> more obvious breakage all the time we ptrace a 32bit task.  Look:
> __kernel_vsyscall() is
>        push    %ebp
>        movl    %ecx, %ebp
>        syscall
>        movl    $__USER32_DS, %ecx
>        movl    %ecx, %ss
>        movl    %ebp, %ecx
>        popl    %ebp
>
> now, what is going to happen to %ebp if we go through IRET path, for any
> reason?  From my reading it appears that right after that IRET we'll have
> ebp containing arg6.  I.e. what we'd pushed on stack.  Now, popl %ebp
> will bring the same value back.  Not a problem.  But what about
> movl %ebp, %ecx?  Again, I'm talking about the case when we have no
> restart at all - just an strace(1) tracing a process.

I suspect that very few things care whether syscall arguments get
clobbered.  The only way it would matter is if gcc reuses the argument in
the ecx slot after an inlined syscall later in the same function.  Any code
that does that is already wrong if the syscall restarts with changed ecx or
if something like UML changes the syscall argument.

--Andy

>
> AFAICS, in that case we ought to have %ecx == %ebp after return from
> __kernel_vsyscall().  Which would blow the things up _very_ fast.
>
> So what the hell am I missing here?

--000e0cd22f68519fea04ab21f3ba
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On Aug 22, 2011 9:01 PM, &quot;Al Viro&quot; &lt;<a href=3D"mailto:viro@zen=
iv.linux.org.uk">viro@zeniv.linux.org.uk</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Aug 22, 2011 at 05:22:07PM -0700, Linus Torvalds wrote:<br>
&gt;<br>
&gt; &gt; You guys seem to positively _want_ to make this a bigger issue th=
an it<br>
&gt; &gt; is. As far as I can tell, nobody has ever even noticed this probl=
em<br>
&gt; &gt; before, and we already have a trivial fix (&quot;don&#39;t do it =
then&quot;) for the<br>
&gt; &gt; case Al actually did notice.<br>
&gt;<br>
&gt; I&#39;m not sure. =A0 What I&#39;ve noticed was complete weirdness in =
uml, apparently<br>
&gt; dependent on SYSCALL vs. SYSENTER or int 0x80. =A0With following round=
 of<br>
&gt; RTFS and finding what looks like an ugly issue with restarts.<br>
&gt;<br>
&gt; What I don&#39;t understand at all is how the hell do we manage to avo=
id much<br>
&gt; more obvious breakage all the time we ptrace a 32bit task. =A0Look:<br=
>
&gt; __kernel_vsyscall() is<br>
&gt; =A0 =A0 =A0 =A0push =A0 =A0%ebp<br>
&gt; =A0 =A0 =A0 =A0movl =A0 =A0%ecx, %ebp<br>
&gt; =A0 =A0 =A0 =A0syscall<br>
&gt; =A0 =A0 =A0 =A0movl =A0 =A0$__USER32_DS, %ecx<br>
&gt; =A0 =A0 =A0 =A0movl =A0 =A0%ecx, %ss<br>
&gt; =A0 =A0 =A0 =A0movl =A0 =A0%ebp, %ecx<br>
&gt; =A0 =A0 =A0 =A0popl =A0 =A0%ebp<br>
&gt;<br>
&gt; now, what is going to happen to %ebp if we go through IRET path, for a=
ny<br>
&gt; reason? =A0From my reading it appears that right after that IRET we&#3=
9;ll have<br>
&gt; ebp containing arg6. =A0I.e. what we&#39;d pushed on stack. =A0Now, po=
pl %ebp<br>
&gt; will bring the same value back. =A0Not a problem. =A0But what about<br=
>
&gt; movl %ebp, %ecx? =A0Again, I&#39;m talking about the case when we have=
 no<br>
&gt; restart at all - just an strace(1) tracing a process.</p>
<p>I suspect that very few things care whether syscall arguments get clobbe=
red.=A0 The only way it would matter is if gcc reuses the argument in the e=
cx slot after an inlined syscall later in the same function.=A0 Any code th=
at does that is already wrong if the syscall restarts with changed ecx or i=
f something like UML changes the syscall argument.</p>

<p>--Andy<br></p>
<p>&gt;<br>
&gt; AFAICS, in that case we ought to have %ecx =3D=3D %ebp after return fr=
om<br>
&gt; __kernel_vsyscall(). =A0Which would blow the things up _very_ fast.<br=
>
&gt;<br>
&gt; So what the hell am I missing here?<br>
</p>

--000e0cd22f68519fea04ab21f3ba--


--===============7354316279481545066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2

--===============7354316279481545066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7354316279481545066==--


