Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFg5e-0007A5-9h for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 14:14:06 -0700
Received: from smtp-out8.xs4all.nl ([194.109.24.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BFg5d-000165-L1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 14:14:05 -0700
In-Reply-To: <9ACD4310-923B-11D8-8B4A-000A95CD704C@kungfoocoder.org>
References: <8D87591F-91D6-11D8-8B4A-000A95CD704C@kungfoocoder.org>
	<200404191858.i3JIwFsP024786@ccure.user-mode-linux.org>
	<46FEF20C-9231-11D8-8B4A-000A95CD704C@kungfoocoder.org>
	<200404192015.i3JKFrsP025251@ccure.user-mode-linux.org>
	<9ACD4310-923B-11D8-8B4A-000A95CD704C@kungfoocoder.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-34-1022821005"
Message-Id: <779EC3D7-9246-11D8-8B4A-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
From: Paul Wagland <paul@wagland.net>
Subject: Re: [uml-devel] Thoughts on HUMFS and metadata 
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
Date: Mon, 19 Apr 2004 23:13:55 +0200
To: Paul Wagland <paul@kungfoocoder.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>



--Apple-Mail-34-1022821005
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Apr 19, 2004, at 21:56, Paul Wagland wrote:
> On Apr 19, 2004, at 22:15, Jeff Dike wrote:
>> paul@kungfoocoder.org said:
>>> Umm, is that actually valid? For example, a normal user cannot read a
>>> file with "000" permissions, however root can. However, if the
>>> permissions are stored on the file, then a "000" file cannot even be
>>> read be root.
>>
>> Ummm, good point.  That needs fixing, as well as the fact that hard 
>> links aren't
>> supported correctly.
>
> Hard links are a hard problem... pun intended ;-) So long as we can 
> assume that only UML modifies the humfs

Heh? One day I will learn to talk in complete sentences :-)

I meant to delete the bit above, and ask why aren't hard links 
supported correctly? I am not sure what the file permissions have to do 
with hard links?

Cheers,
Paul

--Apple-Mail-34-1022821005
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAhEEVtch0EvEFvxURAiDUAJ9V7POogn5rDcC2kCWYB9naoiPWWACghbDT
2eDh75Gq2nyrMwTG7YNAYTc=
=chJM
-----END PGP SIGNATURE-----

--Apple-Mail-34-1022821005--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
