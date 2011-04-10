Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <slyich@gmail.com>) id 1Q8oXO-0006eM-Q2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Apr 2011 06:54:22 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q8oXN-0000zT-SJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 10 Apr 2011 06:54:22 +0000
Received: by fxm19 with SMTP id 19so5059340fxm.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 09 Apr 2011 23:54:15 -0700 (PDT)
Date: Sun, 10 Apr 2011 09:56:15 +0300
From: Sergei Trofimovich <slyich@gmail.com>
Message-ID: <20110410095615.47eedc83@sf>
In-Reply-To: <BANLkTikjjWR2Ki0aNoTBhecodkGpW2cUzw@mail.gmail.com>
References: <20110409170454.73aada78@sf>
	<BANLkTikjjWR2Ki0aNoTBhecodkGpW2cUzw@mail.gmail.com>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2842175504381871814=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] btrfs failure and BUG_ON behaviour
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============2842175504381871814==
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/=mvalbznQX3caT_FpmvIk/s";
	protocol="application/pgp-signature"

--Sig_/=mvalbznQX3caT_FpmvIk/s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Apr 2011 23:33:14 +0200
richard -rw- weinberger <richard.weinberger@gmail.com> wrote:

> We have had some problems with the block layer in ~2.6.32 to 2.6.35.
> Commit 4752690 fixed the issues.
>=20
> Can you please re-test it with 2.6.38?

Same crash with 2.6.38, so it's either very sneaky btrfs bug or
some discrepancy in ubd.

> Does you script work with other file systems?

Tested on ext4, xfs, jfs and reiserfs3. All survive
the load of creating and deleting 1000 files.

By on-disk load reiserfs3 should be quite similar to btrfs,
so I expected it to show problems, but it didn't.

[n00bish speculation] btrfs also plays games with mm. Maybe
the problem sits somewhere there where block layer/page
cache and on-disk layout gets out-of-sync.

[sf] ~/linux-2.6/fs/btrfs:fgrep -R PageDirty .
./extent_io.c:                          if (!PageDirty(pages[i]) ||
./extent_io.c:          if (!PageDirty(page))
./extent_io.c:          if (!PageDirty(page)) {
./disk-io.c:    if (PageDirty(page))
./disk-io.c:    if (PageWriteback(page) || PageDirty(page))
./disk-io.c:                    if (PageDirty(page)) {
./transaction.c:                                if (PageDirty(page))
./transaction.c:                        if (PageDirty(page)) {
./ioctl.c:              if (PageDirty(page)) {
./inode.c:      if (!page->mapping || !PageDirty(page) || !PageChecked(page=
)) {
./inode.c:      if (PageWriteback(page) || PageDirty(page))

I'll try to send bug report to linux-btrfs mailing list first
and return if I'll have more details.

--=20

  Sergei

--Sig_/=mvalbznQX3caT_FpmvIk/s
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2hVJsACgkQcaHudmEf86o4ZgCfe8KO6KxFtaYYWmHZLE1x1jtO
SUwAn0zL9CSSpLI1CfyYnH/wipSF0TSu
=Tbop
-----END PGP SIGNATURE-----

--Sig_/=mvalbznQX3caT_FpmvIk/s--


--===============2842175504381871814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
--===============2842175504381871814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2842175504381871814==--


