Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXkhl-0003Ny-Rb	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 11:52:41 -0700
Received: from rproxy.gmail.com ([64.233.170.192])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DXkhi-0000hr-5v	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 11:52:41 -0700
Received: by rproxy.gmail.com with SMTP id j1so942409rnf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 16 May 2005 11:52:37 -0700 (PDT)
Message-ID: <3524bf1f05051611528eb7bc1@mail.gmail.com>
From: Young Koh <young.koh@gmail.com>
Reply-To: Young Koh <young.koh@gmail.com>
Subject: Re: [uml-devel] Explaination of system call function flow in TT mode
In-Reply-To: <200505161908.08373.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
	 <200501282010.50020.blaisorblade@yahoo.it>
	 <3524bf1f05051607085609e111@mail.gmail.com>
	 <200505161908.08373.blaisorblade@yahoo.it>
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
Date: Mon, 16 May 2005 14:52:37 -0400
Content-Transfer-Encoding: quoted-printable
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi, Thanks for the reply. Let me have one following question.=20

As my understand, in SKAS mode, tracer and tracee are different host
processes, and they have UML kernel code and application code
respectively. (in TT mode, tracee has both kernel and application
code)

Suppose the tracee attmpts to invoke a host system call. then, it will
be intercepted by the tracer as in TT mode. (In TT mode, the tracer
turns off tracing and sends SIGUSR2 to the tracee, and then, the
signal handler in the tracee will execute the system call.) but, in
SKAS mode, because the tracee doesn't have the UML kernel code, only
the tracer knows about the system call code. The tracer cannot simply
send a signal to make the tracee execute the system call. Then how
does it do? Does the tracer execute the system call for the tracee?

Thank you,

>=20
> In SKAS mode, instead, the UML scheduler switches back and forth between
> various "processes" (inside UML) which are all running inside userspace, =
and
> ptrace the various host threads (actually collapsed into one userspace
> thread, thanks to SKAS mode) which run only the real userspace code. So t=
he
> ptraced context always executes userspace code and we never turn ptracing
> off.
> --
> Paolo Giarrusso, aka Blaisorblade
> Skype user "PaoloGiarrusso"
> Linux registered user n. 292729
> http://www.user-mode-linux.org/~blaisorblade
>=20
>


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_idt12&alloc_id=16344&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
