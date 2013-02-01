Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <1359705069.32509.67.camel@sauron.fi.intel.com>
From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Fri, 01 Feb 2013 09:51:09 +0200
In-Reply-To: <1359476623-10544-19-git-send-email-dave.kleikamp@oracle.com>
References: <1359476623-10544-1-git-send-email-dave.kleikamp@oracle.com>
	<1359476623-10544-19-git-send-email-dave.kleikamp@oracle.com>
Mime-Version: 1.0
Reply-To: dedekind1@gmail.com
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3490741307488342291=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH V6 18/30] fs: add read_iter and write_iter
 to several file systems
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>, Richard, Bob Copeland <me@bobcopeland.com>, linux-mtd@lists.infradead.org, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Joern, linux-nilfs@vger.kernel.org, Zach, Weinberger <richard@nod.at>, Christoph Hellwig <hch@infradead.org>, v9fs-developer@lists.sourceforge.net, linux-ext4@vger.kernel.org, Prasad Joshi <prasadjoshi.linux@gmail.com>, "Maxim V."	Patlasov" <mpatlasov@parallels.com>, Evgeniy Dushistov <dushistov@mail.ru>,"	user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, reiserfs-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Engel <joern@logfs.org>, "Tigran A. Aivazian" <tigran@aivazian.fsnet.co.uk>, linux-kernel@vger.kernel.org, logfs@logfs.org, Benny Halevy <bhalevy@tonian.com>, linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, Andrew Morton <akpm@linux-foundation.org>, Brown <zab@zabbo.net>, David Woodhouse <dwmw2@infradead.org>, linux-karma-devel@lists.sourceforge.net, osd-dev@open-osd.org


--===============3490741307488342291==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature"; 
	boundary="=-5GSqoZs9d0FHihhNTP/P"


--=-5GSqoZs9d0FHihhNTP/P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2013-01-29 at 10:23 -0600, Dave Kleikamp wrote:
> -       .aio_read =3D generic_file_aio_read,
> -       .aio_write =3D generic_file_aio_write,
> +       .read_iter =3D generic_file_read_iter,
> +       .write_iter =3D generic_file_write_iter,=20

The new names a lot less self-documenting than the old ones - I read
them as "read iteration", because "iter" is often used for "iteration",
and this gives me no clue that they are related to AIO...

I apologize if this was already discussed, but why did you choose
"iter"?

--=20
Best Regards,
Artem Bityutskiy

--=-5GSqoZs9d0FHihhNTP/P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAABAgAGBQJRC3PtAAoJECmIfjd9wqK0wRMQALvjuIWMlqGKDjYZ+Oc05zpM
umuYU9hx82FV8OzKkb0EBd2OZyhC5Eujwa2YO+oZUNrhabUexK1D7sTE8PY/mFKs
jPXtfieaMxyxZr38lM+bFVpbVg/3AHuXd4kUAodYWBR+6UwZt8WQ5MLn1RS1nUYl
Pki/4MO63nfikAL1va/Ruu3jgw4jZ3Bhr5K9Oa5rpE4YTHAtfwMFMP0DTNyt7r+s
PlgQtdVPvFTCiGcvdMtXAsKbAb0/3d7cQJdUPtoughEvfpdgkSDRTjaT4iGzx9iC
cBAYTK/jqSPg2jX0YmHv9NNjNZaPv6yXOq5DW/PpDDzVJyvKRLMfsGxcYgjqej0Q
0Ph5HjXyhHf+7emKFd9svAzfYapyVoX0AIna5FedSpab4lHTtB4ecydJMG9KgWi5
zebZ/ZVMmkg+mIs4VNBGIwKpgPebhUUJa1yaK/T2KbGj32y1QnRXdzLjYnMmx83L
QW+1su+bI4xQQVqsu4WkkfavCsk57nPsiOjSVzHl21RHlz2MkXCtumoHbbQCcrbO
w3EMCDfXFpjEUX4LpcRiyGHChs5gOZfQuPzP8OwmNUbhHNHX5wginXRnUN4+WFdy
SlryvuodGFXxHOlGJRb3WDZjE5ucOVc3FsKmdcbyrzcJ/QXtObvk89chzWD5fyrz
MijqIe/1hjIksBnGPx7F
=ay3H
-----END PGP SIGNATURE-----

--=-5GSqoZs9d0FHihhNTP/P--



--===============3490741307488342291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
--===============3490741307488342291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============3490741307488342291==--



