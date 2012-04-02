Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rrs@researchut.com>) id 1SEgH9-00011P-Al
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 12:22:23 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SEgH3-0003us-Ux
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Apr 2012 12:22:23 +0000
Received: by dadz9 with SMTP id z9so2775100dad.33
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 02 Apr 2012 05:22:12 -0700 (PDT)
Message-ID: <4F7999EE.6030003@debian.org>
Date: Mon, 02 Apr 2012 17:52:06 +0530
From: Ritesh Raj Sarraf <rrs@debian.org>
MIME-Version: 1.0
References: <0uvj49xgsm.ln2@news.researchut.com>
	<CAFLxGvx2fDWexwA1wmLZ4T0EDaUcaMiROrP-_diQi6bGTNEkyw@mail.gmail.com>
	<4F795309.7030206@debian.org>
	<CAFLxGvxiCjYUkjYye8QW_6MRt7VgGrqrJrwN_M375VTGYaUEsg@mail.gmail.com>
In-Reply-To: <CAFLxGvxiCjYUkjYye8QW_6MRt7VgGrqrJrwN_M375VTGYaUEsg@mail.gmail.com>
Reply-To: rrs@debian.org
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5674591044150846778=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] uml build failure on arch i386
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============5674591044150846778==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="------------enigBC060933681E7C7C4ABF331B"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBC060933681E7C7C4ABF331B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Monday 02 April 2012 01:20 PM, richard -rw- weinberger wrote:
>> Config file available at:
>> > http://people.debian.org/~rrs/tmp/config.i386
> Please give the attached patch a try!
>=20

Thank you Richard. The patch fixes the build failure on i386.


> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index 8fb5840..f322503 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -19,7 +19,8 @@ ifeq ($(CONFIG_X86_32),y)
>  obj-y +=3D checksum_32.o
>  obj-$(CONFIG_BINFMT_ELF) +=3D elfcore.o
> =20
> -subarch-y =3D ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_=
cx8_32.o
> +subarch-y =3D ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_=
cx8_32.o \
> +	../lib/atomic64_386_32.o ../lib/cmpxchg8b_emu.o
>  subarch-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=3D ../lib/rwsem.o
>  subarch-$(CONFIG_HIGHMEM) +=3D ../mm/highmem_32.o
> =20


--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System


--------------enigBC060933681E7C7C4ABF331B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCgAGBQJPeZnuAAoJEKY6WKPy4XVp4YIP/R9yYbWDVa+xk3h5WapJj5/7
Dc/fzNSjAfoM4pVdXbg6p7YXsLq9kdweyKRzgJt6TxJoAl+d+7EhyXFwXGOJvqXY
NdXDHr8D8kWLDv48U9RdtpmVMoHEk8vXzY+XPeADvWPUFwMP4exXmS/MGVfix5zd
5Kwu2V7WRLnrPMK5zZ7gNWwy+aAL2rUHe3WfTZq5hW3sXC88kcD+33B+Z0HUF+hb
c2NU2vWETOx8iehiMsaH2FjcfT5URc61H4zFTE3keqVAEgvNWD5C0nsd/Yfomb0S
7S/ABODBZHGiQSvgyA03lr/a4GXvDlq1/Wt4uoPnZEwVPAVAoerIKM7h9ZZkZkrJ
ujF+Ro5yRY5ILvX94iuz4OHVe0XRvi0bUiT2Ij1PMClcX8tigPkk3qkyj8Z3RXzn
LhBsMS6Pi3jg0D6gTmInkR86kfFXzQxhWzwtxxAY/Jf+Nh1iZm745LoZpLXbu0rz
W1EZK6OJO/kZeqGEprdCS5pXrrgcwmJQRoeq9iZCJFdxQll75lKLn9cN9yjRVy4z
S4KoPdc4oz0KEgTAAOxfWdTtFcLOSXKLwReolxqlKhpDXgdM3nPADnZ7z0a35hs8
cIiSpxGhoh88zLx362OYkOTKjhWVdBXjBppUL5+y94JfnCdNG47JAkaTq/9vMokC
kYhVV57qiZ7tq+A70rxO
=NO10
-----END PGP SIGNATURE-----

--------------enigBC060933681E7C7C4ABF331B--


--===============5674591044150846778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============5674591044150846778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5674591044150846778==--


