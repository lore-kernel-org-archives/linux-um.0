Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Stefano Melchior <stefano.melchior@openlabs.it>
Subject: Re: [uml-devel] "Configuring network interfaces...execvp of 'uml_net'
	failed - errno = 2" error msg
Message-ID: <20060217134755.GA17720@SteX>
Reply-To: stefano.melchior@openlabs.it
References: <20060217115152.GA17278@SteX>
	<200602171307.51262.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <200602171307.51262.blaisorblade@yahoo.it>
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
Date: Fri, 17 Feb 2006 14:47:55 +0100
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2006 at 01:07:50PM +0100, Blaisorblade wrote:
Hi Paolo,
> > If you use the 2.4.x uml kernel the UML image work fine with network, b=
ut
> > if you use an available 2.6.x uml image or a 2.6.x image of mine the uml
> > bootstrap phase hangs with the following error message:
>=20
> Indeed on the same machine and with same config? It's strange, I never sa=
w=20

yes, first I tried my own configuration, then I downloaded a prebuild uml
kernel from http://uml.nagafix.co.uk/ and I tried with this one. Same
error again.
Then I extracted the configuration from that image and I rebuild with that
config, same error for the same problem.
> this incompatibility, and I can't find bugs in the code able to produce t=
his=20
> (with a quick look). Could you check on your part?
>=20
> > Setting up networking...done.
> > * /etc/network/options is deprecated.
> > Setting up IP spoofing protection...done (rp_filter).
> > Configuring network interfaces...execvp of 'uml_net' failed - errno =3D=
 2
>=20
> > From previous messages I read that this concerns uml_net and its
> > permissions.
>=20
> Which are them? It should be setuid root and executable...

ste@etinarcadiaego{~}$ ll /usr/lib/uml/uml_net
-rwsr-x---  1 root uml-net 19836 2004-04-15 03:03 /usr/lib/uml/uml_net

my user, ste, is in the uml-net group.
>=20
> However, since:
>=20
> # perror 2
> OS error code   2:  No such file or directory

it sounds strange, isn't it?
>=20
> Uml is saying it didn't find uml_net, or some of its libraries, not that=
=20
> there's a permission problem.
>=20
> Possibly it's lying and printing the wrong code, dunno. But from current =
code:
>=20
> arch/um/os-Linux/helper.c:helper_child
>         execvp(argv[0], argv);
>         errval =3D errno;
>         printk("execvp of '%s' failed - errno =3D %d\n", argv[0], errno);
>=20
> it seems not (that source file was somewhere else, guess in arch/um/kerne=
l,=20
> until 2.6.14, but I think the content was the same).
>=20
It was displayed in case of my test on 2.6.15, but it occurred even with
other kernels, such as 2.6.12 and 2.6.14.
Indeed with all 2.6.x kernels, it is the strangest thing. With 2.4.x it
works perfectly.
Another info: I used either the kernel.org sources and the debian's
linux-source(s).

I am going to investigate futher more

SteX

--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ/XUC4lnkxrVLfgpAQIhagP/YeZQiXFUO/J81xlosBEASNhA27sTywtz
5qUGbj739yJ9zEmBJNPac3gI+35M/dDvDAjylktHgBVQejYoKKzVbtSOuljoOzR/
/JxNnWYBisU0F2/7LKYk7L4DAFcm2E2m2G+48Av6//OoaX848Wnd9OANUQ7iXteH
P1ZRLyxGRtg=
=9dIs
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
