Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BddPJ-0006od-Lx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jun 2004 16:13:25 -0700
Received: from ctron-dnm.enterasys.com ([12.25.1.120] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BddPI-0001kc-06 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jun 2004 16:13:24 -0700
Received: (from uucp@localhost)
	by ctron-dnm.enterasys.com (8.8.7/8.8.7) id TAA12816
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 24 Jun 2004 19:16:36 -0400 (EDT)
From: "D. Bahi" <dbahi@enterasys.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-dO7r5l64i74or+Zkn6w8"
Message-Id: <1088118748.31490.48.camel@etrs-pc02.ets.enterasys.com>
Mime-Version: 1.0
Subject: [uml-devel] highmem support in 2.4 (2.4.26-1)
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
Date: Thu, 24 Jun 2004 19:12:28 -0400
To: user-mode-linux-devel@lists.sourceforge.net



--=-dO7r5l64i74or+Zkn6w8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hello UMLers

i uml launch a guest with "mem=3D1024M"=20
and i see "CONFIG_HIGHMEM not enabled".
so i "make ARCH=3Dum xconfig" to enable it
and rebuild.

i no longer see "CONFIG_HIGHMEM not enabled"
but i still see "Memory: 460188k available"
which makes me think i'm missing something.

clues or outright help appreciated?

db

w/o CONFIG_HIGHMEM:

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
CONFIG_HIGHMEM not enabled - physical memory shrunk to 499122176 bytes
Kernel virtual memory size shrunk to 32505856 bytes
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
Linux version 2.4.26-1um (user@host) (gcc version 3.3.1) #1 Mon Jun 14
16:07:12 EDT 2004
On node 0 totalpages: 121856
zone(0): 121856 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: umid=3Duml
ubd0=3D/local/target0/cowthis,/misc/cctools/target0/images/root_fs_mv31
hostfs=3D/local/target0/s1/hostfs/chassis[box].cm[cm1] mem=3D1024M
root=3D/dev/ubd0
Calibrating delay loop... 3355.44 BogoMIPS
Memory: 474328k available

w/ CONFIG_HIGHMEM:

Checking for the skas3 patch in the host...found
Checking for /proc/mm...found
Kernel virtual memory size shrunk to 32505856 bytes
Checking for /dev/anon on the host...Not available (open failed with
errno 2)
Linux version 2.4.226-1um (user@host) (gcc version 3.3.1) #3 Thu Jun 24
18:58:57 EDT 2004
On node 0 totalpages: 262144
zone(0): 121856 pages.
zone(1): 0 pages.
zone(2): 140288 pages.
Kernel command line: umid=3Duml
ubd0=3D/local/target0/cowthis,/misc/cctools/target0/images/root_fs_mv31
hostfs=3D/local/target0/s1/hostfs/chassis[box].cm[cm1] mem=3D1024M
root=3D/dev/ubd0
Calibrating delay loop... 3656.90 BogoMIPS
Memory: 460188k available


--=-dO7r5l64i74or+Zkn6w8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBA21/c3XQ4zakZ3z4RAhOZAJ9IflKd0yO37EiOZKjrKX4zeMls9QCeOoh8
cYIdctWnCDHW2iG8cqwMfyA=
=/8ql
-----END PGP SIGNATURE-----

--=-dO7r5l64i74or+Zkn6w8--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
