Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aw56A-0004jf-7r for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 11:53:38 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Aw4k1-0002FS-Bt for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Feb 2004 11:30:45 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] post-2.6.3 build error
References: <20040223172012.GA29046@bytesex.org>
In-Reply-To: <20040223172012.GA29046@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402252047.59002.blaisorblade_spam@yahoo.it>
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
Date: Wed, 25 Feb 2004 20:47:58 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 18:20, luned=EC 23 febbraio 2004, Gerd Knorr ha scritto:
>   Hi,
>
> You might have noticed already that in latest linus tree um doesn't
> build any more.  The reason is that sys_sched_setscheduler() is declared
> now in linux/sched.h, which conflicts with the declaration in
> arch/um/kernel/sys_call_table.c.  As quick+dirty fix I've just commented
> the declaration.  It builds now, but gives a warning (which is harmless I
> think as the exact type of the function shouldn't matter for the syscall
> table).  Anyone has a better/cleaner fix for that?

I agree that it's harmless (you can add a typecast as it is done for other =

functions there). By the way (unrelated) you could maybe remove include=20
"linux/sys.h" since it claims to be unused.

Nothing cleaner since avoiding the inclusion of sched.h is impossible. And =

this is the fix used for similar cases in that file.

Also, please fix this line:

__NR_sched_yield ] =3D (syscall_handler_t *) yield

It should refer to sys_sched_yield. yield() is not even asmlinkage, so this=
=20
could case serious problems, and it is commented as "for kernel usage". Als=
o=20
I checked i386 syscall table, and it uses sys_sched_yield.

Bye
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
