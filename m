Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFfp0-00039b-0d for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 13:56:54 -0700
Received: from smtp-out9.xs4all.nl ([194.109.24.10] helo=smtp-out3.xs4all.nl)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFfoz-0007Ni-Mz for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 13:56:53 -0700
In-Reply-To: <200404192015.i3JKFrsP025251@ccure.user-mode-linux.org>
References: <8D87591F-91D6-11D8-8B4A-000A95CD704C@kungfoocoder.org>
	<200404191858.i3JIwFsP024786@ccure.user-mode-linux.org>
	<46FEF20C-9231-11D8-8B4A-000A95CD704C@kungfoocoder.org>
	<200404192015.i3JKFrsP025251@ccure.user-mode-linux.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-30-1018155532"
Message-Id: <9ACD4310-923B-11D8-8B4A-000A95CD704C@kungfoocoder.org>
Content-Transfer-Encoding: 7bit
From: Paul Wagland <paul@kungfoocoder.org>
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
Date: Mon, 19 Apr 2004 21:56:10 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net



--Apple-Mail-30-1018155532
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Apr 19, 2004, at 22:15, Jeff Dike wrote:

> paul@kungfoocoder.org said:
>> Umm, is that actually valid? For example, a normal user cannot read a
>> file with "000" permissions, however root can. However, if the
>> permissions are stored on the file, then a "000" file cannot even be
>> read be root.
>
> Ummm, good point.  That needs fixing, as well as the fact that hard 
> links aren't
> supported correctly.

Hard links are a hard problem... pun intended ;-) So long as we can 
assume that only UML modifies the humfs

>> Surely it also makes sense if it is stored in a database? I am not
>> sure  how else this information can be stored otherwise?
>
> Are you talking about extending the normal unix permissions through 
> humfs,
> or supporting this stuff on filesystems that have it?

Unfortunately, as for permissions above, I don't think that we can 
store this stuff on the filesystem, even if the underlying filesystem 
does support it. Since all file accesses are done as the user running 
UML, you certainly cannot store any capability that the user does not 
have, which means, for example, that we cannot give the modprobe 
utility the "load module" capability. On some hardened systems this 
program is the only thing that can load a module, and then root is the 
only user that is allowed to run that program. Personally I think that 
then ACL's become analogous to the above situation for permissions, and 
they might as well be treated in the same way for simplicity sakes.

Note, that since not all FS's are required to support ACL/capabilities, 
they do not need to be in the first cut, so long as the metadata format 
allows for their existence then it can be added later on, indeed it 
sounds like a nice small chunk of work that I would even do for you :-)

Hope this helps some,
Paul

--Apple-Mail-30-1018155532
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAhC7btch0EvEFvxURAkzmAKC0jZIA3jgmZ9jfznf7gMI3M9L/vACfRx0E
LrBtLNOvI06ps4OtYfpDiGk=
=AeZ3
-----END PGP SIGNATURE-----

--Apple-Mail-30-1018155532--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
