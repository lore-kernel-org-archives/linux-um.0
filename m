Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRbOf-0002bf-4x for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 11:11:17 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CRbOe-0007At-27 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 11:11:17 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411021952.09095.blaisorblade_spam@yahoo.it>
	<4190F385.1000802@fujitsu-siemens.com>
In-Reply-To: <4190F385.1000802@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13106165.R6jIYklPJm";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411092012.05383.blaisorblade_spam@yahoo.it>
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
Date: Tue, 9 Nov 2004 20:11:32 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>, Roland Kaeser <roli8200@yahoo.de>, Nuno Silva <nuno.silva@vgertech.com>, Antoine Martin <antoine@nagafix.co.uk>, Sven =?iso-8859-15?q?K=F6hler?= <skoehler@upb.de>, Dennis Muhlestein <devel@muhlesteins.com>

--nextPart13106165.R6jIYklPJm
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 09 November 2004 17:42, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Friday 29 October 2004 11:26, Roland Kaeser wrote:
> > This is executed by a clone() child. What happens is that, with NPTL,
> > both the father and the son have the same pid, so the SIGSTOP is routed
> > to the wrong thread. However, this is not expected: having the same pid
> > should be reserved to when clone is called with CLONE_THREAD in the
> > flags. I've verified that this is not happening in this case, even with
> > strace (to make sure glibc is not playing any dirty tricks). But for so=
me
> > reasons, the kernel is behaving as if this happened.

> Sorry, I have to oppose. The threads don't have the same pid! Only the
> getpid()- call to the lib returns the pid of the father.

This makes much more sense than my thoughts. I said I was going to investig=
ate=20
on that, but had no time yet.

This fact (glibc caches getpid() results) was even known because already=20
posted, and I guessed that this could happen only with TLS support.

Also, not a lot of days ago, I was thinking to this issue for the UML start=
up=20
tests (they rely on ptrace() catching the syscall done by the child and=20
modifying it, so they would fail with the caching).

Still, I didn't realize this was the problem. Thanks for your help, as alwa=
ys.

> I wrote a small test program (attached). Please compile it with:
>
>     gcc -static -o test_getpid_static test_getpid.c        and
>     gcc -o test_getpid_nptl test_getpid.c

> Using the two programs, you can see the following:

> 1) having linked my test with -static, each "getpid()" in the test results
> in a syscall (try "strace test_getpid_static")
> 2) linking without -static (I assume, this means using NPTL), only the
> first getpid() does a syscall, I guess, the further calls deliver a
> pid-value buffered in the lib! (try "strace test_getpid_static")
> The test here requests and prints out its pid twice, then it exits. But
> strace will show you two getpid()-calls only in case of the _static
> program.

> 3) the pid-history seen in 1 and 2 is used even for a child created with
> "clone()", regardless which clone-flags are used! Try "test_getpid_static
> clone" and "test_getpid_nptl clone" to see, what happens.

>     After printing its pid twice, the program now creates a child via
> "clone()". The child requests its *real* pid via a "by-hand-syscall". Than
> it stops itself and is ptraced by the father, which prints out a message,
> if the child does a *real* getpid()-syscall.

>     Note: If you remove the two getpid()-calls at the beginning of main(),
> the child will work correctly even with NPTL, since there isn't yet a
> buffered pid ...

> Summary: I guess, the behavior of NPTL is a bug. Do you agree? To which
> list should a bugreport be mailed?

I don't think it's exactly a bug, but it could be more of a pitfall. Why? W=
hen=20
using pthread_create, it will also setup a different per-thread TLS area.

Now, the question is: clone() is a syscall, so no such setup is done. Is it=
=20
correct to wrap it to do this?

However, even fork() is a syscall, but I think that it does not have this=20
problem. Would you mind testing if fork() correctly works?

I must also say, that I saw, in fact, a clone() wrapper in glibc; only I th=
ink=20
it's not used when issuing clone() calls, which only do the syscall and a=20
little setup to jump to the provided function.

Anyway, it must documented in getpid() and clone() man-pages, at least.

> To work around, we could use the by-hand-syscall for os_getpid(). I didn't
> test it, but I'm quite shure, that it fixes the problem.

I'm on the same position. I'm going to test that on my Gentoo host.
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart13106165.R6jIYklPJm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBkRaFqH9OHC+5NscRApIMAKCOrG1/XQOIemTOhb/UDX2kHQ4tUQCfXNde
TLVhrKKfpJlo9WpERQlWhCQ=
=6abb
-----END PGP SIGNATURE-----

--nextPart13106165.R6jIYklPJm--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
