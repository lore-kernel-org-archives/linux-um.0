Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRa2D-0002vm-Am for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 09:44:01 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CRa29-0008O4-KG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 09:44:01 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: Synchronization primitives in UML (was: Re: [uml-devel] Re:
	[patch 09/20] uml: use SIG_IGN for empty sighandler)
References: <200411052036.55541.blaisorblade_spam@yahoo.it>
	<20041106051306.GA3038@ccure.user-mode-linux.org>
In-Reply-To: <20041106051306.GA3038@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2838420.DOhiRIlsz9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411091844.44218.blaisorblade_spam@yahoo.it>
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
Date: Tue, 9 Nov 2004 18:44:35 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, akpm@osdl.org, cw@f00f.org

--nextPart2838420.DOhiRIlsz9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 06 November 2004 06:13, Jeff Dike wrote:
> On Fri, Nov 05, 2004 at 08:36:55PM +0100, Blaisorblade wrote:
> > Also, why shouldn't sigprocmask be restartable with the -ERESTART*
> > mechanism?

> Err, that was pause, not sigprocmask.  sigprocmask just switches the sign=
al
> mask.
Ok, I saw it able to return EINTR, so I thought you wanted it to bounce bac=
k=20
there (I wasn't understanding the purpose of the code anyway, now with your=
=20
help it's clear).
> pause is what sits there and waits for something to happen.

> > Wouldn't your kludge break?

> What kludge?
[...]
> You're seeing races where there aren't any.  SIGWINCH is only possible wh=
en
> it gets a controlling tty, which happens after the sigprocmask.
When writing this I was still thinking to sigprocmask() getting SIGWINCH, n=
ot=20
pause. So obviously I said nonsense.

I also understand now what all this is for. When I have time for this, I'll=
 at=20
least copy and paste your mail into a comment, with any needed adjustment.

=46or the semaphore issue, I have some ideas (like using futexes) which nee=
d to=20
be developed a bit:

1) I want to create a semaphore API in os_*.
2) It will be able to use socketpairs.
3) It will be able to use futexes, if they are non-persistant and usable=20
without too much issues (the same way we are going to support Async I/O).
4) It will be used first by the code which could really benefit from the=20
performance increase.
5) It won't use persistant objects.

Any comment on these issues? Also, apart TT context switching, is there any=
=20
other performance-sensitive use of semaphores, which would benefit from usi=
ng=20
futexes?

About this:
> A more basic issue is the interface.

> What I have now is the mapping=20
>  open <-> create
>  read <-> down
>  write <-> up
>  close <-> destroy
> which is way simpler and cleaner than semget, semop, and ??? (I can't
> figure out how to destroy one of these things).

Yes, semget and friends are uglier.

But don't think that the current nested code is simple to read - three=20
semaphores at a time, without a clear name, are not the clearer code on the=
=20
world.
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart2838420.DOhiRIlsz9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBkQIMqH9OHC+5NscRApIMAJ9RsNvhtfSrqg9lQ8402Dg8AE8nDwCfVTzN
ukGiHqSqG1c9ReTQR4OoOrY=
=a5+Q
-----END PGP SIGNATURE-----

--nextPart2838420.DOhiRIlsz9--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
