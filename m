Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwRJZ-00031g-6l for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 11:36:57 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AwRA1-0005ov-7N for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 11:27:05 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: post-2.6.3 build error
References: <20040223172012.GA29046@bytesex.org>
	<200402252047.59002.blaisorblade_spam@yahoo.it>
	<87smgyamnx.fsf@bytesex.org>
In-Reply-To: <87smgyamnx.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402262030.56198.blaisorblade_spam@yahoo.it>
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
Date: Thu, 26 Feb 2004 20:30:56 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 22:12, mercoled=EC 25 febbraio 2004, Gerd Knorr ha scritto:
> BlaisorBlade <blaisorblade_spam@yahoo.it> writes:
> > __NR_sched_yield ] =3D (syscall_handler_t *) yield
> >
> > It should refer to sys_sched_yield. yield() is not even asmlinkage, so
> > this could case serious problems, and it is commented as "for kernel
> > usage". Also I checked i386 syscall table, and it uses sys_sched_yield.
>
> There is another related one (asmlinkage where it shouldn't be) in
> mprotect.c.

Good catch.

> With the new CONFIG_REGPARM config option it becomes
> really important to get that right ...

Yes, however I think that one asmlinkage more is not very bad (old conventi=
on=20
used where the call can be optimized), but that a missing asmlinkage could =
be=20
crashy. At least until the prototype is correct; I just noticed that=20
do_mprotect is protoized without asmlinkage - and this can be actually=20
crashy. Luckily CONFIG_REGPARM is not in the stock kernel.

If it were, that could have explained some Skas-2.6 crashes which can be se=
en=20
here (there is already one BUG hit which explains it in part, see here: "Ho=
st=20
2.6.2/3 + CFQ + BlaisorBlade patches"... but on one kernel it Oopsed and on=
=20
another it crashed, so there could be something else).

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
