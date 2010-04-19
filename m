Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jan.kiszka@web.de>) id 1O3z2p-00042g-0s
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 22:02:19 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O3z2n-0006QS-VJ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2010 22:02:19 +0000
Message-ID: <4BCCD2DC.7020508@web.de>
Date: Tue, 20 Apr 2010 00:02:04 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <1271700367-14127-1-git-send-email-lczerner@redhat.com>
In-Reply-To: <1271700367-14127-1-git-send-email-lczerner@redhat.com>
Subject: Re: [uml-devel] [PATCH] um: Fix compile errors for um architecture
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0353614914778241803=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Lukas Czerner <lczerner@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0353614914778241803==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE52981FF06A59FBB056C5FDB"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE52981FF06A59FBB056C5FDB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Lukas Czerner wrote:
> arch/um/drivers/line.c
>  - need to include linux/slab.h since the code uses kmalloc.
>  - fix warning message with unused variable tty
>=20
> arch/um/os-Linux/helper.c
>  - there is no need to include linux/slab.h since allocations are
>  done with uml_kmalloc

The build fixes are already queued in Tejun's percpu tree, the variable
removal is part of my just posted trivial series. But what an amazing
activity here! :)

Thanks,
Jan

>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  arch/um/drivers/line.c    |    2 +-
>  arch/um/os-Linux/helper.c |    1 -
>  2 files changed, 1 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
> index 64cda95..7f7338c 100644
> --- a/arch/um/drivers/line.c
> +++ b/arch/um/drivers/line.c
> @@ -6,6 +6,7 @@
>  #include "linux/irqreturn.h"
>  #include "linux/kd.h"
>  #include "linux/sched.h"
> +#include "linux/slab.h"
>  #include "chan_kern.h"
>  #include "irq_kern.h"
>  #include "irq_user.h"
> @@ -18,7 +19,6 @@ static irqreturn_t line_interrupt(int irq, void *data=
)
>  {
>  	struct chan *chan =3D data;
>  	struct line *line =3D chan->line;
> -	struct tty_struct *tty;
> =20
>  	if (line)
>  		chan_interrupt(&line->chan_list, &line->task, line->tty, irq);
> diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
> index 06d6ccf..b6b1096 100644
> --- a/arch/um/os-Linux/helper.c
> +++ b/arch/um/os-Linux/helper.c
> @@ -8,7 +8,6 @@
>  #include <errno.h>
>  #include <sched.h>
>  #include <linux/limits.h>
> -#include <linux/slab.h>
>  #include <sys/socket.h>
>  #include <sys/wait.h>
>  #include "kern_constants.h"



--------------enigE52981FF06A59FBB056C5FDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvM0uIACgkQitSsb3rl5xTRggCgxC9J/NiSSVOaRJMXxabBuDNB
8D4AnikUf97XLnEyH/gjiQsdgF5YV7hT
=9ilB
-----END PGP SIGNATURE-----

--------------enigE52981FF06A59FBB056C5FDB--


--===============0353614914778241803==
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
--===============0353614914778241803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0353614914778241803==--


