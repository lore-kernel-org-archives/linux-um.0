Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sfr@canb.auug.org.au>) id 1KvhPD-0005Of-ED
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Oct 2008 23:58:23 +0000
Received: from chilli.pcug.org.au ([203.10.76.44] helo=smtps.tip.net.au)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KvhP3-0001S8-DI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Oct 2008 23:58:23 +0000
Date: Fri, 31 Oct 2008 10:38:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Message-Id: <20081031103820.7e81f7f1.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0810300925590.4898@anakin>
References: <804dabb00810291851xc617690wac1404176437fb84@mail.gmail.com>
	<Pine.LNX.4.64.0810300925590.4898@anakin>
Mime-Version: 1.0
Subject: Re: [uml-devel] =?utf-8?q?=22warning=3A_passing_argument_1_of_?=
	=?utf-8?q?=E2=80=98um=5Fexecve=E2=80=99_discards_qualifiers_from_pointer_?=
	=?utf-8?q?target_type=22?=
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7331043301695645367=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-next@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

--===============7331043301695645367==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__31_Oct_2008_10_38_20_+1100_kSE83CpICyBylQ=Q"

--Signature=_Fri__31_Oct_2008_10_38_20_+1100_kSE83CpICyBylQ=Q
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Thu, 30 Oct 2008 09:31:04 +0100 (CET) Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
>
> I see there are no UML builds yet on
> http://kisskb.ellerman.id.au/kisskb/matrix/.
> Perhaps it would be a good idea to add them?

We would love to, but we can't figure out how to cross build an x86 based
uml kernel on a powerpc machine.  Any hints?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__31_Oct_2008_10_38_20_+1100_kSE83CpICyBylQ=Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkKRWwACgkQjjKRsyhoI8yQzACfV9J8VMbJ5vdthnIovwdnY/fz
yYgAoLVPd474e+sBZSxEypfwzP3BDUGL
=H8FF
-----END PGP SIGNATURE-----

--Signature=_Fri__31_Oct_2008_10_38_20_+1100_kSE83CpICyBylQ=Q--


--===============7331043301695645367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============7331043301695645367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7331043301695645367==--

