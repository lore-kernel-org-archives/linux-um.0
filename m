Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ClpKP-0001fj-5h for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Jan 2005 06:06:29 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1ClpKH-0000Qq-H3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Jan 2005 06:06:28 -0800
From: "Armin M. Warda" <Armin.Warda@gmx.de>
Reply-To: Armin.Warda@gmx.de
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200501031531.19246.Armin.Warda@gmx.de>
	<20050104115947.GA3715@bytesex>
In-Reply-To: <20050104115947.GA3715@bytesex>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1654982.ygiZVM4r5E";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501041506.05104.Armin.Warda@gmx.de>
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
Date: Tue, 4 Jan 2005 15:05:59 +0100
To: Gerd Knorr <kraxel@bytesex.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Paolo Giarrusso <blaisorblade_personal@yahoo.it>, "Christopher S. Aker" <caker@theshore.net>

--nextPart1654982.ygiZVM4r5E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 04 January 2005 12:59, you wrote:
> Intrestingly mm/shmem.c (which implements shmfs/tmpfs)=20
> hasn't been touched since Nov 19 according to bitkeeper ...

I don't think the problem is in tmpfs!=20

When I saw the problem for the 1st time, of cause I immediately=20
blamed tmpfs and switched to a reiserfs /tmp, but to my surprise
the problem did not go away. Finally I even tested an ext3 /tmp -=20
just to be sure - and the problem was reproduced, too.

That was with SuSE-2.6.8-24* Host-Kernels.

  Armin.

=2D-=20
   --- May the Source be with you! Linux. ---
   --- secure eMail: http://www.gnupg.de/ ---

--nextPart1654982.ygiZVM4r5E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB2qLMRyBj5Zbydm0RAn73AJ9iBW7k9rX6s9X+vEN8p7auklmC9gCfXAgJ
DLGHf3Y//dPMALCTqyrbolo=
=oxdo
-----END PGP SIGNATURE-----

--nextPart1654982.ygiZVM4r5E--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
