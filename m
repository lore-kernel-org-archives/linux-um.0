Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGD6q-0001eC-LW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2004 01:29:32 -0700
Received: from smtp-out4.xs4all.nl ([194.109.24.5])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BGD6q-0005sw-3X for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2004 01:29:32 -0700
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-7--997744996"
Message-Id: <F87C6818-936D-11D8-B5AA-000A95CD704C@kungfoocoder.org>
Content-Transfer-Encoding: 7bit
From: Paul Wagland <paul@kungfoocoder.org>
Subject: [uml-devel] A few comments on hostfs interface
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
Date: Wed, 21 Apr 2004 10:29:13 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Piotr Neuman <sikkh@wp.pl>, Jeff Dike <jdike@addtoit.com>



--Apple-Mail-7--997744996
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi all,

These comments are based on the development code as provided by sikkh, 
as such not everything might be relevant, but I believe that the 
primary code changed by sikkh is in the metadata interface.

Anyway, here goes:

hostfs.h:

   struct externfs_file_ops:
     Almost all of the functions have the naming form verb_noun, except 
for file_create(). I would suggest to reverse this for the sake of 
consistency.

     Most functions have "long names" that is open_file, link_file, 
access_file, etc. The exceptions to this are mkdir(), rmdir(), mknod(), 
readlink(), and statfs(). This cannot be done to "keep standard 
semantics" since open_dir() is not in it's standard form either. I 
would suggest to rename all of the "short form" functions into the 
standardised form.

Jeff, if you agree with the above, let me know, and you will receive a 
patch for it later today.

Cheers,
Paul

--Apple-Mail-7--997744996
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAhjDZtch0EvEFvxURAk+rAJ4tkUdYjjI7kYnmS+IZ83PdlwL3IgCgp7FR
y/0bsgmZIWS/OKDxjujiXQc=
=tXat
-----END PGP SIGNATURE-----

--Apple-Mail-7--997744996--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
