Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1ewf-0007P0-6G for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Mar 2004 21:10:53 -0800
Received: from i-195-137-100-222.freedom2surf.net ([195.137.100.222]
	helo=greenrd.org) by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B1eed-0002GZ-HR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Mar 2004 20:52:15 -0800
From: Robin Green <greenrd@greenrd.org>
Message-ID: <20040312045211.GH2083@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline
Subject: [uml-devel] Securing the kernel against exploits
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
Date: Fri, 12 Mar 2004 04:52:11 +0000
To: user-mode-linux-devel@lists.sourceforge.net



--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Apologies in advance for any misconceptions in this post, for I am but
a kernel newbie.

I have been designing what I believe is a very effective system to render
even root exploits on a host relatively powerless. But obviously at some
level you need a "trusted level" that "cannot" be exploited - or, at least,
is very difficult to exploit.

I was wondering to what extent the UML kernel can be secured against
exploits, by special measures on the host - and to what extent, if any,
such ideas have been implemented so far.

Let's assume for these purposes that the host is secured and for all
practical purposes "unexploitable". Then, would these ideas be possible?
And would they actually decrease risk?

1. Make all executable code in the UML kernel read-only.

2. Prevent the UML kernel from making itself writeable again.
(This is something that cannot be done with the kernel running directly
on a real x86 architecture, AFAIK, but can be done with UML. Hence a
UML selling point for the ultra-paranoid?)

3. Restrict the executable segment for the UML kernel so that kernel
data and stack(s) are not executable, using something like exec-shield.

Given these measures, my plan essentially involves introducing an
"archangel" security layer in the kernel, which follows constraints
set by a "God process" running on another machine (perhaps a different
UML). The archangel and the God process communicate via a socket. The
archangel must obviously prevent any process running on the UML from
interfering with or spoofing that communication channel.

The default constraints prohibit modifying system files and
modifying firewall rules; when a sysadmin needs to do some work, they
instruct the God process to temporarily relax certain constraints -
but only for the files etc. they need to access, only from a particular
process tree, and only until they have finished working with them.
(The archangel could also do an unspoofable md5sum of files, to verify
that no rogue code has taken the opportunity left by relaxed
constraints to perform some unauthorised modifications. Rogue code in
that scenario is most likely to be run as a result of the sysadmin
running code from an untrusted source.)

It might seem like an overcomplicated or byzantine system, but I
believe it offers a good balance between security, performance and
system maintainability. Move too much logic into the God process
and you lose performance (and simplicity); move too much logic
into the read-only space (i.e. in my model, the kernel, but it
doesn't have to be the kernel) and you lose maintainability;
move the God process onto the same UML as the archangel and you
lose security, because then rogue code can pretend to be the
sysadmin. (The idea is that the machine hosting the God process
has less services running, and therefore is less likely to be
exploited. The truly paranoid could run it on a different OS
altogether, to reduce the chance of the God machine and the
original UML being cracked simultaneously - and cracking both
at the same time is the only way to gain unauthorised
privileged access to the original UML.)

All of this would benefit from a "host-hardened" kernel. Is this
possible?

--=20
Robin

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAUUH7tPCt67UksSYRAsgzAKDFGHRCx8tjwPsc/N5sgKxSICAR7wCfd4ah
20YxU5TWzJw7RQW2RUmsOD0=
=kPOU
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
