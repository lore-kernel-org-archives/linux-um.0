Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ck2q5-0005u7-Fa for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Dec 2004 08:07:49 -0800
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Ck2q3-00047c-Mx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Dec 2004 08:07:48 -0800
From: "Armin M. Warda" <Armin.Warda@gmx.de>
Reply-To: Armin.Warda@gmx.de
References: <200412140958.58402.Armin.Warda@ePost.De>
	<20041216183604.GB24982@bytesex>
	<200412162013.21197.blaisorblade_personal@yahoo.it>
In-Reply-To: <200412162013.21197.blaisorblade_personal@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1949118.CmYVAM1vlQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412301520.48951.Armin.Warda@gmx.de>
Subject: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE 9.2)
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
Date: Thu, 30 Dec 2004 15:20:42 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>

--nextPart1949118.CmYVAM1vlQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Hi,

just tried again with SuSE host kernel 2.6.8-24.10: same problem.

(Is 2.6.8-24.10 a 2.6.8 with back-ported fixes from 2.6.10 ?)

  Armin.

On Thursday 16 December 2004 20:13, Paolo Giarrusso wrote:
> On Thursday 16 December 2004 19:36, Gerd Knorr wrote:
> > > Well, this matches some other reports of a different problem
> > > (impossible to unmount a fs used by UML) which probably relates
> > > to 2.6.9 host bugs.
> > >
> > > I'd suggest trying to reproduce the bug with a 2.6.8.1 +
> > > SKAS3-v7 patch, or checking what's different in the SuSE kernel
> > > from vanilla 2.6.8.1 (I'm particularly suspiscious about the
> > > TASK_TRACED introduction).
> >
> > The suse 2.6.8 kernel is actually 2.6.9-rc2, thus more close to
> > 2.6.9 than 2.6.8.  Especially it already has the TASK_TRACED
> > stuff and I've used the 2.6.9 version of the skas v7 patch
> >
> > (and also thats why I've
> > suggested to check against 2.6.9 not 2.6.8.1 vanilla to see if
> > the issue is still there).
>
> Remember that there was an invisible reference from died UMLs that
> kept the tmpfs from being unmounted (multiply reported, I
> experienced that too). Well, it the file is kept used, then it will
> keep using the tmpfs space. So nothing new....

=2D-=20
   --- May the Source be with you! Linux. ---
   --- secure eMail: http://www.gnupg.de/ ---

--nextPart1949118.CmYVAM1vlQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB1A7ARyBj5Zbydm0RAqbLAKDVNijt42LzTx2oRZot2mBrtELNagCgiYiZ
69IzeWRxL6G8rx+elKvv7Bs=
=IHLK
-----END PGP SIGNATURE-----

--nextPart1949118.CmYVAM1vlQ--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
