Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cokop-0000nG-Nq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 07:53:59 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cokon-0004EI-TZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 07:53:59 -0800
From: "Armin M. Warda" <Armin.Warda@gmx.de>
Reply-To: Armin.Warda@gmx.de
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200501101450.32169.Armin.Warda@gmx.de>
	<20050111165848.GA20592@bytesex>
In-Reply-To: <20050111165848.GA20592@bytesex>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1806485.TXk5uJczLf";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501121653.44872.Armin.Warda@gmx.de>
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
Date: Wed, 12 Jan 2005 16:53:38 +0100
To: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net
Cc: "Christopher S. Aker" <caker@theshore.net>, Paolo Giarrusso <blaisorblade_personal@yahoo.it>

--nextPart1806485.TXk5uJczLf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 11 January 2005 17:58, Gerd Knorr wrote:
> Once it is tested and confirmed that this patch actually fixes the
> issue I can take care to put it into the suse kernel and get it
> released with the next security update kernel. =20
> [...]
> So it would be nice if one of you guys can try that=20
> [...]
> The kernel-source rpm has a fully patched suse source tree, you can
> try to apply the patch there and rebuild a kernel. =20

#  2004/12/17 09:18:41-08:00 roland@redhat.com=20
#  [PATCH] fix bogus ECHILD return from wait* with zombie group leader

I tried to apply this patch to the SuSE kernel-source-2.6.8-24.10, but=20
it failed. The reason is obvious: there are other patches necessary=20
before applying this one.

The kernel/exit.c of SuSE 2.6.8-24.10 corresponds to bitkeeper rev=20
1.155, and the above "bogus ECHILD return" fix is in bk rev 1.170 of=20
kernel/exit.c, thus there are at least 15 additional fixes to be=20
considered for backporting from 2.6.10 to SuSE's 2.6.8-24.10.

This is to much for me, as I am no kernel hacker. If no one picks up=20
that job, then my only hope is that SuSE will finally move its SuSE=20
9.2 forward to 2.6.10.

On Saturday 08 January 2005 13:15, Paolo Giarrusso wrote:
> The changelog does not mention our particular bug it but there is a
> good reason for not mentioning it, and it's related to TASK_TRACED
> which is *the* problem in 2.6.9 with UML.

  Armin.

=2D-=20
   --- May the Source be with you! Linux. ---
   --- secure eMail: http://www.gnupg.de/ ---

--nextPart1806485.TXk5uJczLf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB5UgIRyBj5Zbydm0RAiyoAKCJa45xLSy6G9p5Pt0XQ9zIHEVQ4wCfY6/M
u4+JlLSeqACDUQl58/lNk6Q=
=L5hv
-----END PGP SIGNATURE-----

--nextPart1806485.TXk5uJczLf--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
