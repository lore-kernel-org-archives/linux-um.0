Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFdiy-0003ud-Vg for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 11:42:32 -0700
Received: from smtp-out8.xs4all.nl ([194.109.24.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BFdiy-00053y-Be for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 11:42:32 -0700
In-Reply-To: <200404191858.i3JIwFsP024786@ccure.user-mode-linux.org>
References: <8D87591F-91D6-11D8-8B4A-000A95CD704C@kungfoocoder.org>
	<200404191858.i3JIwFsP024786@ccure.user-mode-linux.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-28-1013719905"
Message-Id: <46FEF20C-9231-11D8-8B4A-000A95CD704C@kungfoocoder.org>
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
Date: Mon, 19 Apr 2004 20:42:14 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net



--Apple-Mail-28-1013719905
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Apr 19, 2004, at 20:58, Jeff Dike wrote:

> paul@kungfoocoder.org said:
>> 1. Do files really need to exist in data if they are block, character
>>  or sockets? Surely it is enough to just look at the metadata for
>> these   files and create the appropriate dir entry in the UML.
>
> Permissions are stored with the real file.  This makes "metadata" a 
> bit of a
> misnomer - I just moved the information that absolutely needed to move.

Umm, is that actually valid? For example, a normal user cannot read a 
file with "000" permissions, however root can. However, if the 
permissions are stored on the file, then a "000" file cannot even be 
read be root.

>> 2. When COW humfs "partitions" are made, will it be possible to
>> separately copy metadata and data? For instance, if I change only the
>>  uid, gid and/or permissions, do I need to also create a new copy of
>> the   data, or can I only update my local metadata and use the data
>> from the   parent?
>
> A suitable implementation could optimize the COWing of permissions and 
> other
> non-data.  I'm not sure how worth-while that would be.

Agreed that normally it would not be a large win, but I expect that it 
would be a small price in code for a potential win... though whether it 
is worth having code sitting around that is almost never used...

>> 3. When COW humfs "partitions" are made, how will files be deleted in
>>  the second humfs? [...] I can see that one easy
>> option is   to introduce a "deleted" metadata node, that only contains
>> the word   deleted, and would signify that this file does not exist in
>> this COWed   copy.
>
> That's the plan, more or less.

Cool.

>> 4. Since metadata is basically a copy of "permission data" does it
>> also   make sense for humfs metadata to include things like
>> capabilities and   ACL's?
>
> If they are stored in the filesystem, then it might make sense.

Surely it also makes sense if it is stored in a database? I am not sure 
how else this information can be stored otherwise? I am assuming that 
the various metadata backends will all store the same metadata, just 
with different complexities against different perceived needs.

Just a few more thoughts :-)

Cheers,
Paul

--Apple-Mail-28-1013719905
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAhB2Htch0EvEFvxURAmXwAJ439xyGdmnw749CAQ27R+zKziZGQQCgk/tn
0p+IuxWNLVdmD4Bc9r3ez7g=
=mMMD
-----END PGP SIGNATURE-----

--Apple-Mail-28-1013719905--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
