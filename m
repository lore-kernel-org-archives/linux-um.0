Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYHQ0-0001X4-GH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 02:34:24 -0700
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KYHPy-0001Vj-PE
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 02:34:24 -0700
Date: Wed, 27 Aug 2008 12:34:08 +0300 (EEST)
From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
In-Reply-To: <20080826165222.GA18584@c2.user-mode-linux.org>
Message-ID: <Pine.LNX.4.64.0808262346370.1168@wrl-59.cs.helsinki.fi>
References: <Pine.LNX.4.64.0808190904200.4551@wrl-59.cs.helsinki.fi>
	<20080826165222.GA18584@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	boundary="-696208474-1464818064-1219784013=:1168"
Content-ID: <Pine.LNX.4.64.0808271229160.1034@wrl-59.cs.helsinki.fi>
Subject: Re: [uml-devel] [RFC PATCH] uml: fix double statement if missing
	braces
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696208474-1464818064-1219784013=:1168
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-ID: <Pine.LNX.4.64.0808271229161.1034@wrl-59.cs.helsinki.fi>

On Tue, 26 Aug 2008, Jeff Dike wrote:

> On Tue, Aug 19, 2008 at 09:09:16AM +0300, Ilpo J=E4rvinen wrote:
> > ...I'm not fully sure what's the intention here, ie., whether
> > the return belongs to a block with the assignment or not.
>=20
> Yes, this is confused, although it just happens to compile to
> something sane.

Yeah, I found ~20 similar brace vs reindent cases, for most of them (like=20
this), it's currently insignificant but definately is trap for 1) a reader =

of the code and 2) future modification.

> Your patch is fine, but I think the whole thing needs
> some more cleanup.  See the patch below.

Seems much better than my approach, this case was anyway among the most=20
complex within those ~20 case what comes to figuring out correctness,=20
after your cleanup the code flow much more obvious.

--=20
> The testing for the host's TLS support was somewhat confused - notably
> in the indentation of a return.
>=20
> This cleans it up:
> 	*supports_tls is only set to 0 once
> 	any error besides EINVAL causes an immediate return, with
> *supports_tls equal to 0.
>=20
> Index: linux-2.6.22/arch/um/os-Linux/sys-i386/tls.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22.orig/arch/um/os-Linux/sys-i386/tls.c	2007-07-08 19:32:17=
.000000000 -0400
> +++ linux-2.6.22/arch/um/os-Linux/sys-i386/tls.c	2008-08-26 08:19:37.0000=
00000 -0400
> @@ -15,6 +15,7 @@ void check_host_supports_tls(int *suppor
>  	int val[] =3D {GDT_ENTRY_TLS_MIN_I386, GDT_ENTRY_TLS_MIN_X86_64};
>  	int i;
> =20
> +	*supports_tls =3D 0;
>  	for (i =3D 0; i < ARRAY_SIZE(val); i++) {
>  		user_desc_t info;
>  		info.entry_number =3D val[i];
> @@ -23,14 +24,9 @@ void check_host_supports_tls(int *suppor
>  			*tls_min =3D val[i];
>  			*supports_tls =3D 1;
>  			return;
> -		} else {
> -			if (errno =3D=3D EINVAL)
> -				continue;
> -			else if (errno =3D=3D ENOSYS)
> -				*supports_tls =3D 0;
> -				return;
>  		}
> +		if (errno =3D=3D EINVAL)
> +			continue;
> +		else return;

They usually say that you might want to put the return on a different line =

unless you have something to hide :-).

>  	}
> -
> -	*supports_tls =3D 0;
>  }
>=20

--=20
 i.
---696208474-1464818064-1219784013=:1168
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
---696208474-1464818064-1219784013=:1168
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

---696208474-1464818064-1219784013=:1168--

