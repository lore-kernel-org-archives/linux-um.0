Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWblH-007eTP-EX
 for linux-um@lists.infradead.org; Wed, 14 Apr 2021 09:24:40 +0000
Message-ID: <c35e321fe3d3e6993c0d9a1ad638230a8f77866b.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
From: Benjamin Berg <benjamin@sipsolutions.net>
Date: Wed, 14 Apr 2021 11:24:19 +0200
In-Reply-To: <9f8280540bbc6f3c857ac5749eeafcd145577da3.camel@sipsolutions.net>
References: <20210414055217.543246-1-avagin@gmail.com>
 <78cdee11-1923-595f-90d2-e236efbafa6a@cambridgegreys.com>
 <9f8280540bbc6f3c857ac5749eeafcd145577da3.camel@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7286723506748638714=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>


--===============7286723506748638714==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-7RgkmP5TmgdmmPtYS/8k"


--=-7RgkmP5TmgdmmPtYS/8k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-04-14 at 09:34 +0200, Johannes Berg wrote:
> On Wed, 2021-04-14 at 08:22 +0100, Anton Ivanov wrote:
> > On 14/04/2021 06:52, Andrei Vagin wrote:
> > > We already have process_vm_readv and process_vm_writev to read and
> > > write
> > > to a process memory faster than we can do this with ptrace. And now
> > > it
> > > is time for process_vm_exec that allows executing code in an
> > > address
> > > space of another process. We can do this with ptrace but it is much
> > > slower.
> > >=20
> > > =3D Use-cases =3D
> > >=20
> > > Here are two known use-cases. The first one is =E2=80=9Capplication k=
ernel=E2=80=9D
> > > sandboxes like User-mode Linux and gVisor. In this case, we have a
> > > process that runs the sandbox kernel and a set of stub processes
> > > that
> > > are used to manage guest address spaces. Guest code is executed in
> > > the
> > > context of stub processes but all system calls are intercepted and
> > > handled in the sandbox kernel. Right now, these sort of sandboxes
> > > use
> > > PTRACE_SYSEMU to trap system calls, but the process_vm_exec can
> > > significantly speed them up.
> >=20
> > Certainly interesting, but will require um to rework most of its
> > memory=20
> > management and we will most likely need extra mm support to make use
> > of=20
> > it in UML. We are not likely to get away just with one syscall there.
>=20
> Might help the seccomp mode though:
>=20
> https://patchwork.ozlabs.org/project/linux-um/list/?series=3D231980

Hmm, to me it sounds like it replaces both ptrace and seccomp mode
while completely avoiding the scheduling overhead that these techniques
have. I think everything UML needs is covered:

 * The new API can do syscalls in the target memory space
   (we can modify the address space)
 * The new API can run code until the next syscall happens
   (or a signal happens, which means SIGALRM for scheduling works)
 * Single step tracing should work by setting EFLAGS

I think the memory management itself stays fundamentally the same. We
just do the initial clone() using CLONE_STOPPED. We don't need any stub
code/data and we have everything we need to modify the address space
and run the userspace process.

Benjamin

--=-7RgkmP5TmgdmmPtYS/8k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmB2tMMACgkQq6ZWhpmF
Y3DHNw/+OI7BooddkdmPX1QVWLfOOcxDuyD/drcEgE5/m7sjUK4zdG+Va3SlAOC+
Nq8D0N3vCjbjxmebMsNDLS47RIy6OaKrpl0iEZkokNIXVkH0tQrehKNLiKdN20cf
Ktu6yNW+F1QT4DC/M9MHVvgRHzxxJb34beVdUXOCPcqKE1fMHAHorHRrJ2Pn6Z+2
whcdWFKkD+k8dPcQ8SV+djNebYqK/8tkc/nnGbi/NXXJ05eLXqDRSgWMDPYQwqsV
5ngFDYVCIqXS21nNjQaw1YbxevY4F58w82LLGoumMygx9VCYs6JCm7eWF2ommPuP
DF4OdXD0/JTZOv0bPc7dZgB3YcpkL6KnBSj52Ps7AmVgtF8+pGc/syimY3cGVGsR
+2IbShWAFAS5oE04GVc53iRZaqLjO2gryPHqE3QGrcSMZzAxP3F6m6ne7exDvwJO
+aNbR3zcJWuFtcIgkhVSIBJRRNyQNsAovZypSuYNgCuJbNk7fYpYW8KEkf6PBhhJ
aPLvTOEgreYeKknKl4P2NGpkr/dPjQZtucXQIu5+LflL4fFR61cqi6VskAhuDThj
j2Zf8PvWVY5BqpnFSDHa1jucsWsIzthSZbh12NuYi8yRfiDMoUYfoB9dPbm7GfzK
n1H6HwrMZzFSPXBGspLWzGGyStY0IqX/r+KpSWmQqcsH8s+5wDQ=
=MzgV
-----END PGP SIGNATURE-----

--=-7RgkmP5TmgdmmPtYS/8k--



--===============7286723506748638714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============7286723506748638714==--



