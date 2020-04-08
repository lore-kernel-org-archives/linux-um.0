Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM8Vx-0007XE-0G
 for linux-um@lists.infradead.org; Wed, 08 Apr 2020 11:05:02 +0000
Received: by mail-oi1-x242.google.com with SMTP id r21so4289725oij.11
 for <linux-um@lists.infradead.org>; Wed, 08 Apr 2020 04:04:57 -0700 (PDT)
Message-ID: <ac5e36bea0200b8613849ef529d84de54b3afe70.camel@researchut.com>
Subject: Re: Documentation for UML Vector network
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Wed, 08 Apr 2020 16:28:41 +0530
In-Reply-To: <f64a6f99-8e20-9825-75eb-358054935807@kot-begemot.co.uk>
References: <7c37a3f7310c0be2202ada464e31c2d4d424c502.camel@researchut.com>
 <32d50bed-cfdb-288a-181c-e186143c8169@kot-begemot.co.uk>
 <44b7a3a49731dfabe9cdfbeb281ad9470e71b625.camel@researchut.com>
 <c6774e9e-7811-cbbb-eea5-83e5045b59e9@kot-begemot.co.uk>
 <41e0199cf2ad126bca3047d18e14493ab903bbe6.camel@researchut.com>
 <f64a6f99-8e20-9825-75eb-358054935807@kot-begemot.co.uk>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: rrs@researchut.com
Content-Type: multipart/mixed; boundary="===============8449422858286707650=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org


--===============8449422858286707650==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-JL+Rn6kqvrQxq5UgDRhJ"


--=-JL+Rn6kqvrQxq5UgDRhJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-04-07 at 17:36 +0100, Anton Ivanov wrote:
>=20
> I am happy to handle proposed changes as pull requests.

Thank you for following up on this one. There's one item I felt could
be expanded. I created a PR for it on the Github repo.

I felt this was worth documenting because UML's prime selling point is
that it can run as a normal user.

https://github.com/kot-begemot-uk/uml-howto-v2/pull/1


Thanks,
Ritesh

--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

--=-JL+Rn6kqvrQxq5UgDRhJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl6NrmEACgkQpjpYo/Lh
dWn3vQ/+L7kRhk4JMshq8LkBv6/TnhSE56l8FqFJRNl43L4LpoL665f8x7MCysiy
UIge5n/FTbTa9D55mj9WlDpT1JEzBIgGWmt2Ly79v4HofaJggdX4gA2Tdvl2ipld
0dZ0U7GafLtcw1tfD5ReCF83TcLQu7wU+2r99NgJQbbqSLY2UJ8vVtaIzy95vCeL
H3ll7UUDq0ooHyWSNPFcxzM2li0uBNss/+yGEoGyQbAoaiStlaqN6jV50nFuYsJa
nynqy2UsYGpxH84syTV5ZZwaERUXiQHCFCvZcQLQidHOosKKUKw/43UK6OQ/FvmR
IMOBsKjro3gqK435AWX+ilbS9jOzmciX02aW809q5Mk1qL1I53o5UpDf/oUP3NxM
6EHV09dNaxcT6Kn8zfSDI8ynGnaSnsy0mv6IwiBncbuJvub+ekRP9UR+9msqPu3h
GCmqo9FXuaoFUvABVz/r27kkrWkL/4eA37XDVDO7wzq+cZgYJjcc9X5zh3k0Voyd
cTxTonavf0SMI8OYAMPFoVOaec8NgYDormsBoVkTN4E2UJ4UEKgCMqt2mDkv9eKs
3vwtApzl+GuOw/UGHYbA10E2G5+CVJbyWQ9Y4w4XC3odH7QuAmh4EEAkxDKEzKBu
dxe/hKt6fWHIqyp5byDa5H7ZuQVlTJN6EBeGG0MoEf7K8HBjSYM=
=vrlW
-----END PGP SIGNATURE-----

--=-JL+Rn6kqvrQxq5UgDRhJ--



--===============8449422858286707650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============8449422858286707650==--



