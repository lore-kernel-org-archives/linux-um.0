Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPZKX-0000OD-7h for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 20:34:37 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CPZKV-000662-Qy for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 20:34:37 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [patch 09/20] uml: use SIG_IGN for empty
	sighandler
References: <20041103231735.8C1E955C79@zion.localdomain>
	<200411040451.iA44pJ5G012816@ccure.user-mode-linux.org>
In-Reply-To: <200411040451.iA44pJ5G012816@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1788379.LSYE4EkmTH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411040511.54892.blaisorblade_spam@yahoo.it>
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
Date: Thu, 4 Nov 2004 05:11:44 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org, cw@f00f.org

--nextPart1788379.LSYE4EkmTH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 05:51, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > Avoid creating a dummy no-op procedure instead of using SIG_IGN.
>
> Andrew, can you hold off on this one?

> I did that on purpose, and as soon=20
> as I remember why, I'll know whether this patch is good :-)
I had a doubt on this, but I was not getting much feedback from you...
Also, if you reject this, I'd require a comment-only patch for it:
"as soon as I remember why" makes me think back to my yesterday's class, wh=
en=20
the teacher said "put comments in your code or you'll soon forget what it=20
does!" 8-O (yes, 1st year University student :-( ).

> The other patches are OK by me.  Consider them acked.
Very fine.

=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart1788379.LSYE4EkmTH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBiawKqH9OHC+5NscRAmv5AJ9q2IMw9okRybgdmnCid2RrJY62owCgo4Ep
tiTalD+CqvTay6DvZsxJ5D0=
=dSwE
-----END PGP SIGNATURE-----

--nextPart1788379.LSYE4EkmTH--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
