Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Cameron Patrick <cameron@patrick.wattle.id.au>
Subject: Re: [uml-devel] UML "Distro" ?
Message-ID: <20041021065935.GB4900@patrick.wattle.id.au>
References: <053e01c4b6f4$93f48e90$2000000a@schlepptopp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline
In-Reply-To: <053e01c4b6f4$93f48e90$2000000a@schlepptopp>
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
Date: Thu, 21 Oct 2004 14:59:35 +0800
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

roland wrote:

> I would like to hear your opinion if it`s worth thinking about a
> "UML Linux Distribution".

Sounds like an eminently sensible idea to me :-)

> It could be based on another distro (debian? fedora?) and contain:

My personal bias would be to base it on Debian, as it is generally
quite readily hackable, and has a lot of the infrastructure to support
UML already there.  Dunno, I don't think it really matters that much.

> - A setup for installation of a minimalistic, UML-"ready" base
> system - call it a "UML runtime environment". That means: Recent and
> skas/sysemu-patched kernel(2.6), modules, X, uml-utilities, screen,
> scripts, bridge-utils......

Is having X installed really desirable most of the time?  Most of the
uses for this distro would be on servers, and having X on the host
makes maintaining the distro harder for relatively little benefit.

> - Pre-configured environment (bridge setup,tmpfs,mountpoints...)

Scripts to make it easy to add and remove UML guest instances would
also be quite useful -- especially if it could take care of having
UMLs running as their own user id (for security reasons) and setting
up a root filesystem.

> - basic root-filesystems "ready to run"

Or alternatively, including tools like rootstrap to make generating
root fs'es easy?

Cameron.


--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBd15Xl1rlvh2uVnMRAscRAJ0TJWvKb7gS5yEMrvGfxcmPEdL9DwCgpdpg
f5goQRLnJ0Oh1Pl+8AdZcug=
=Mo9e
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
