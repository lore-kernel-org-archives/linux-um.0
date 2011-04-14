Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <james_mcmechan@hotmail.com>) id 1QASYW-0003i8-FZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Apr 2011 19:50:20 +0000
Received: from col0-omc3-s2.col0.hotmail.com ([65.55.34.140])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QASYV-0004aH-HI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Apr 2011 19:50:20 +0000
Message-ID: <COL101-W165ED5CB17434202CE273DE2AD0@phx.gbl>
From: James McMechan <james_mcmechan@hotmail.com>
Date: Thu, 14 Apr 2011 19:50:13 +0000
In-Reply-To: <201104141552.42213.richard@nod.at>
References: <201104132150.05623.richard@nod.at>,
	<19878.42746.60978.537126@pilspetsen.it.uu.se>,
	<201104141552.42213.richard@nod.at>
MIME-Version: 1.0
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
Subject: Re: [uml-devel] gcc-4.6.0 generates no code for sub_preempt_count()
To: richard@nod.at, mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, uml devel <user-mode-linux-devel@lists.sourceforge.net>


> Am Donnerstag 14 April 2011, 09:49:14 schrieb Mikael Pettersson:
> > Richard Weinberger writes:
> > > Hi,
> > >
> > > I'm facing a very strange issue with gcc-4.6.0 and UML.
> > > Within __local_bh_enable() gcc generates no code for
> > > sub_preempt_count().
> > >
> > > See:
> > > http://userweb.kernel.org/~rw/uml-gcc460/__local_bh_enable-gcc460.txt
> > > vs.
> > > http://userweb.kernel.org/~rw/uml-gcc460/__local_bh_enable-gcc431.txt
> > >
> > > Interestingly it generates code for add_preempt_count().
> > > I can reproduce this on x86 and x86_64.
> > >
> > > The problem has to do with UML's current_thread_info() function.
> > > When I replace it with arch/x86's (unportable) variant gcc generates
> > > code.
> > >
> > > Any ideas whether this is a gcc or a kernel issue?

It looks like a gcc error with one of the optimization passes

> > Please provide a standalone test case.
>
> There you go!
> http://userweb.kernel.org/~rw/uml-gcc460/testcase.c

Replacing inline with __attribute__((noinline)) makes it produce code again

without requiring asm("esp")/asm("rsp") tricks and the code appears to be w=
orking

I think gcc is assuming only low bits in the address of stack vars and thou=
ght they

were all masked out :( with this change my test version of gcc-4.6.0 works =
for x86/amd64

I have not yet gotten 4.6.0 to install yet so I was testing with xgcc from =
the failed build


--- testcase.orig=A0=A0=A0=A0=A0=A0 2011-04-14 08:34:24.000000000 -0700

+++ testcase.c=A0 2011-04-14 12:17:44.000000000 -0700

@@ -31,7 +31,7 @@

=A0}

=A0#else

=A0/* UML */

-static inline struct thread_info *current_thread_info(void)

+static __attribute__((noinline)) struct thread_info *current_thread_info(v=
oid)

=A0{

=A0=A0 struct thread_info *ti;

=A0=A0 unsigned long mask =3D THREAD_SIZE - 1;>

> Thanks,
> //richard

 		 	   		  =

---------------------------------------------------------------------------=
---
Benefiting from Server Virtualization: Beyond Initial Workload =

Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve =

application availability and disaster protection. Learn more about boosting =

the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

