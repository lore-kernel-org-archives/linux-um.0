Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRJRR-0007qf-OF	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 17:33:13 -0700
Received: from smtp07.web.de ([217.72.192.225])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DRJRQ-0004Yl-1K
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 17:33:13 -0700
Received: from [213.7.176.32] (helo=tormented-soul)
	by smtp07.web.de with asmtp (TLSv1:EXP1024-RC4-SHA:128)
	(WEB.DE 4.105 #282)	id 1DRJRH-0007WR-00
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Apr 2005 02:33:04 +0200
From: Heiko Przybyl <lil_tux@web.de>
Reply-To: lil_tux@web.de
Subject: Re: [uml-devel] Re: Segfault 2.6.11-rc1-mm1
References: <200504241945.51674.lil_tux@web.de>
	<200504242204.09786.lil_tux@web.de> <200504292252.47087.blaisorblade@yahoo.it>
In-Reply-To: <200504292252.47087.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2556957.t7iG5bp6Vu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504290230.06954.lil_tux@web.de>
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
Date: Fri, 29 Apr 2005 02:30:03 +0200
To: user-mode-linux-devel@lists.sourceforge.net

--nextPart2556957.t7iG5bp6Vu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I managed to get it working, by applying the skas-patch to the host=20
(CONFIG_MODE_TT gives the segfault, and CONFIG_STATIC_LINK with skas doesn'=
t=20
link). My system (the host) is still running in nptl-mode but the guest isn=
't=20
(it's known to not work ;)

> You have recompiled your system or enabled those options?
> Sorry, I forgot to finish the sentence. I have NPTL on my system, so that=
's=20
> not the culprit. The hardened toolchain may be, I'll investigate on this.
It's ok, we're all just humans, ain't we? ;)

Heiko

=2D-=20
* misc stuff
    http://user.cs.tu-berlin.de/~zuxez/

* public gpg-key
    http://user.cs.tu-berlin.de/~zuxez/pubkey.asc


--nextPart2556957.t7iG5bp6Vu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.15 (GNU/Linux)

iD8DBQBCcYAOqrqqic7aKcsRAlw2AJ4xuXol1ljvfvR55w4d/JrZ1HM9HACeLSOf
kfPkETuN2JD6KS0jebQ3d+I=
=YVab
-----END PGP SIGNATURE-----

--nextPart2556957.t7iG5bp6Vu--


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
