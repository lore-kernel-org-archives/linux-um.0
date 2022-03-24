Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXQDL-00HCCH-G7
 for linux-um@lists.infradead.org; Thu, 24 Mar 2022 16:21:33 +0000
Message-ID: <4c862a5829c7fbc408738e0c0d4d6e206802e78e.camel@collabora.com>
Subject: Re: [PATCH 1/2] um: xterm: make default terminal emulator configurable
From: Ritesh Raj Sarraf <ritesh.sarraf@collabora.com>
Date: Thu, 24 Mar 2022 21:51:21 +0530
In-Reply-To: <20220324131344.b7608507865f.I4f78dca5973127790f8dc5757ff5f021078b2c62@changeid>
References: <20220324131344.b7608507865f.I4f78dca5973127790f8dc5757ff5f021078b2c62@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: ritesh.sarraf@collabora.com
Content-Type: multipart/mixed; boundary="===============4994875677494374172=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>


--===============4994875677494374172==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-3FOFQsCyblwVwcpVhKX+"


--=-3FOFQsCyblwVwcpVhKX+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-03-24 at 13:13 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> Make the default terminal emulator configurable so e.g.
> Debian can set it to x-terminal-emulator instead of the
> current default of xterm.
>=20
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> =C2=A0arch/um/drivers/Kconfig=C2=A0 | 7 +++++++
> =C2=A0arch/um/drivers/Makefile | 2 ++
> =C2=A0arch/um/drivers/xterm.c=C2=A0 | 7 ++++---
> =C2=A03 files changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
> index f145842c40b9..521ae0d46076 100644
> --- a/arch/um/drivers/Kconfig
> +++ b/arch/um/drivers/Kconfig
> @@ -64,6 +64,13 @@ config XTERM_CHAN
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its own xterm.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It is safe to say =
'Y' here.
> =C2=A0
> +config XTERM_CHAN_DEFAULT_EMULATOR
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0string "xterm channel default =
terminal emulator"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on XTERM_CHAN
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default "xterm"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This option allows chan=
ging the default terminal emulator.
> +
> =C2=A0config NOCONFIG_CHAN
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default !(XTERM_CHAN && T=
TY_CHAN && PTY_CHAN && PORT_CHAN &&
> NULL_CHAN)
> diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
> index 803666e85414..e1dc4292bd22 100644
> --- a/arch/um/drivers/Makefile
> +++ b/arch/um/drivers/Makefile
> @@ -70,4 +70,6 @@ obj-$(CONFIG_UML_PCI_OVER_VIRTIO) +=3D virt-pci.o
> =C2=A0USER_OBJS :=3D fd.o null.o pty.o tty.o xterm.o slip_common.o
> pcap_user.o vde_user.o vector_user.o
> =C2=A0CFLAGS_null.o =3D -DDEV_NULL=3D$(DEV_NULL_PATH)
> =C2=A0
> +CFLAGS_xterm.o +=3D '-
> DCONFIG_XTERM_CHAN_DEFAULT_EMULATOR=3D"$(CONFIG_XTERM_CHAN_DEFAULT_EMUL
> ATOR)"'
> +
> =C2=A0include arch/um/scripts/Makefile.rules
> diff --git a/arch/um/drivers/xterm.c b/arch/um/drivers/xterm.c
> index 87ca4a47cd66..6918de5e2956 100644
> --- a/arch/um/drivers/xterm.c
> +++ b/arch/um/drivers/xterm.c
> @@ -42,7 +42,7 @@ static void *xterm_init(char *str, int device,
> const struct chan_opts *opts)
> =C2=A0}
> =C2=A0
> =C2=A0/* Only changed by xterm_setup, which is a setup */
> -static char *terminal_emulator =3D "xterm";
> +static char *terminal_emulator =3D CONFIG_XTERM_CHAN_DEFAULT_EMULATOR;
> =C2=A0static char *title_switch =3D "-T";
> =C2=A0static char *exec_switch =3D "-e";
> =C2=A0
> @@ -79,8 +79,9 @@ __uml_setup("xterm=3D", xterm_setup,
> =C2=A0"=C2=A0=C2=A0=C2=A0 respectively.=C2=A0 The title switch must have =
the form '<switch>
> title',\n"
> =C2=A0"=C2=A0=C2=A0=C2=A0 not '<switch>=3Dtitle'.=C2=A0 Similarly, the ex=
ec switch must have the
> form\n"
> =C2=A0"=C2=A0=C2=A0=C2=A0 '<switch> command arg1 arg2 ...'.\n"
> -"=C2=A0=C2=A0=C2=A0 The default values are 'xterm=3Dxterm,-T,-e'.=C2=A0 =
Values for gnome-
> terminal\n"
> -"=C2=A0=C2=A0=C2=A0 are 'xterm=3Dgnome-terminal,-t,-x'.\n\n"
> +"=C2=A0=C2=A0=C2=A0 The default values are 'xterm=3D"
> CONFIG_XTERM_CHAN_DEFAULT_EMULATOR
> +=C2=A0=C2=A0=C2=A0=C2=A0 ",-T,-e'.\n"
> +"=C2=A0=C2=A0=C2=A0 Values for gnome-terminal are 'xterm=3Dgnome-termina=
l,-t,-
> x'.\n\n"
> =C2=A0);
> =C2=A0
> =C2=A0static int xterm_open(int input, int output, int primary, void *d,

Thank you for the quick fixes.

Tested-by: Ritesh Raj Sarraf <ritesh@collabora.com>

--=20
Ritesh Raj Sarraf
Collabora

--=-3FOFQsCyblwVwcpVhKX+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmI8moEACgkQpjpYo/Lh
dWmr+g//RdaOZjFfw/FNNLTofitG4jl3NolfY1nVQdmc/IBqZs6HxV//YWqf15sb
2N67TXpn4uBFMQINQq0a0ZDcyAgQIfj4son8yz0Ue2y2u44eGSY8rTh9SzjinjvK
DjKo6Kx6FjMfuazYaSZIwODbt15ZOeVbOV88W6THVXF9wB4wsViNfUH4RJBEhqXr
a8sST9Gj7jcZgb3ZdF0TQO0xhtdzzEe0BHElkYV2lJPFADtW6JIQB+65Vl4VU49w
jNn1xMlVp1A9kgJcNXQ5nPZJUVisB9J24LA+8vepNKHhatpbqDNYXvX5pomnp0Vn
l7h3cylXDKCq5NjCSagvzQmB+9RvvxIMIqfsQxadsFHXTQ426wSFru+LoQ5z3rBp
FcDWXif6Tt675L3TF2JSdtuu4hnLRKibLsk6XUKX66AClBg6X4kz9Nk6e04MJQMf
xY1ZFE+k7QFBpZvJYuP4RGzqSOPfJFkYo/GCISPP8cXEHqkIkUWea/+R/TZSdCTD
nZLRIQmVLjCLIBRsCiDKOreNBXadYuaRpMdq5Cp51YEYNj2GfoVvmtfvIC9CsU6K
95v3jY2LQj7CA51X8vF4A6IDojHGCLKUayO5WqaKe2XJjlQj4D2ocLrJHwAu/008
pGSr6kElvoxcMssvAQ/JT0desvyD2Io0H4H/Cfj0cIx2EAcJ8vU=
=Z20y
-----END PGP SIGNATURE-----

--=-3FOFQsCyblwVwcpVhKX+--


--===============4994875677494374172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4994875677494374172==--


