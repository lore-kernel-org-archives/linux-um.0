Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFTqG-000515-Af for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 01:09:24 -0700
Received: from smtp-out4.xs4all.nl ([194.109.24.5])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BFTqF-0004Oz-LK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 01:09:23 -0700
Received: from umlsmtp.wagland.net (kungfucoder.org [80.126.186.202])
	by smtp-out4.xs4all.nl (8.12.10/8.12.10) with ESMTP id i3J89JCY083598
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Apr 2004 10:09:20 +0200 (CEST)
Received: from [10.4.20.117] (unknown [62.58.46.99])
	by umlsmtp.wagland.net (Postfix) with ESMTP id 242F129
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Apr 2004 10:09:15 +0200 (CEST)
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <8D87591F-91D6-11D8-8B4A-000A95CD704C@kungfoocoder.org>
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-20-974754101"
From: Paul Wagland <paul@kungfoocoder.org>
Subject: [uml-devel] Thoughts on HUMFS and metadata
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
Date: Mon, 19 Apr 2004 09:52:49 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Apple-Mail-20-974754101
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hi all,

Just a bit of brain dumping here... i hope that it is all coherent, if  
not, please let me know and I will try to clarify :-)

I have read through  
<http://marc.theaimsgroup.com/?l=user-mode-linux- 
devel&m=108139168611257&w=4> jdikes "A quick humfs HOWTO", but I still  
have a few questions and/or suggestions.

1. Do files really need to exist in data if they are block, character  
or sockets? Surely it is enough to just look at the metadata for these  
files and create the appropriate dir entry in the UML. Unless it is  
being used for for the host systems inode number? If so, is this only  
for NFS?

2. When COW humfs "partitions" are made, will it be possible to  
separately copy metadata and data? For instance, if I change only the  
uid, gid and/or permissions, do I need to also create a new copy of the  
data, or can I only update my local metadata and use the data from the  
parent?

3. When COW humfs "partitions" are made, how will files be deleted in  
the second humfs? I would assume (but could easily be wrong ;-) ) that  
the easiest way to do COW is for every file access, first check your  
humfs, if it does not exist, then check your parent humfs. If this is  
done, then how do you delete a file? I can see that one easy option is  
to introduce a "deleted" metadata node, that only contains the word  
deleted, and would signify that this file does not exist in this COWed  
copy.

4. Since metadata is basically a copy of "permission data" does it also  
make sense for humfs metadata to include things like capabilities and  
ACL's? (Obviously I think it does, or I would not of raise the question  
;-) )

So, what do you think, insightful thoughts or meandering ravings of a  
crazed mind?

Cheers,
Paul

--Apple-Mail-20-974754101
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAg4Vctch0EvEFvxURAuaDAKCVoPqXr/Pip7aqoUNGaApTCOCGxACgkxvm
mhr07RdgZzWU/acO58vqdmk=
=C5qY
-----END PGP SIGNATURE-----

--Apple-Mail-20-974754101--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
