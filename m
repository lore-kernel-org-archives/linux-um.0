Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jan.kiszka@web.de>) id 1O3XSk-0000eX-3G
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Apr 2010 16:35:14 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O3XSi-0002NG-E0 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Apr 2010 16:35:13 +0000
Message-ID: <4BCB34B0.4040209@web.de>
Date: Sun, 18 Apr 2010 18:34:56 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <1271406939-26394-1-git-send-email-tiger.yang@oracle.com>
In-Reply-To: <1271406939-26394-1-git-send-email-tiger.yang@oracle.com>
Subject: Re: [uml-devel] [PATCH 1/1] uml: replace kmalloc() in line.c
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8406520978373136839=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Tiger Yang <tiger.yang@oracle.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8406520978373136839==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig70B31A2683DE186AA7C2EEA7"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig70B31A2683DE186AA7C2EEA7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tiger Yang wrote:
> This patch replace kmalloc() with uml_kmalloc() in line.c and
> remove an unused variable.

This driver does not require the wrapping. I'll post a patch to unbreak
uml build in a minute.

Jan

>=20
> Signed-off-by: Tiger Yang <tiger.yang@oracle.com>
> ---
>  arch/um/drivers/line.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index 64cda95..616a1f3 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -11,6 +11,7 @@
>  #include "irq_user.h"
>  #include "kern_util.h"
>  #include "os.h"
> +#include "um_malloc.h"
> =20
>  #define LINE_BUFSIZE 4096
> =20
> @@ -18,7 +19,6 @@ static irqreturn_t line_interrupt(int irq, void *data=
)
>  {
>  	struct chan *chan =3D data;
>  	struct line *line =3D chan->line;
> -	struct tty_struct *tty;
> =20
>  	if (line)
>  		chan_interrupt(&line->chan_list, &line->task, line->tty, irq);
> @@ -95,7 +95,7 @@ static int buffer_data(struct line *line, const char =
*buf, int len)
>  	int end, room;
> =20
>  	if (line->buffer =3D=3D NULL) {
> -		line->buffer =3D kmalloc(LINE_BUFSIZE, GFP_ATOMIC);
> +		line->buffer =3D uml_kmalloc(LINE_BUFSIZE, UM_GFP_ATOMIC);
>  		if (line->buffer =3D=3D NULL) {
>  			printk(KERN_ERR "buffer_data - atomic allocation "
>  			       "failed\n");
> @@ -782,7 +782,7 @@ void register_winch_irq(int fd, int tty_fd, int pid=
, struct tty_struct *tty,
>  {
>  	struct winch *winch;
> =20
> -	winch =3D kmalloc(sizeof(*winch), GFP_KERNEL);
> +	winch =3D uml_kmalloc(sizeof(*winch), UM_GFP_KERNEL);
>  	if (winch =3D=3D NULL) {
>  		printk(KERN_ERR "register_winch_irq - kmalloc failed\n");
>  		goto cleanup;
> @@ -861,7 +861,7 @@ char *add_xterm_umid(char *base)
>  		return base;
> =20
>  	len =3D strlen(base) + strlen(" ()") + strlen(umid) + 1;
> -	title =3D kmalloc(len, GFP_KERNEL);
> +	title =3D uml_kmalloc(len, UM_GFP_KERNEL);
>  	if (title =3D=3D NULL) {
>  		printk(KERN_ERR "Failed to allocate buffer for xterm title\n");
>  		return base;



--------------enig70B31A2683DE186AA7C2EEA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvLNLkACgkQitSsb3rl5xQdNACgtOBx5yQnTEJOJ44wPoB9Nl1k
UToAoKc5xe+l69fWKQv7QTFJY2dLgCeV
=zet8
-----END PGP SIGNATURE-----

--------------enig70B31A2683DE186AA7C2EEA7--


--===============8406520978373136839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============8406520978373136839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============8406520978373136839==--


