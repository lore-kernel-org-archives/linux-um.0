Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfaxV-0006aG-O5 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Jun 2004 02:00:49 -0700
Received: from smtp-out4.xs4all.nl ([194.109.24.5])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BfaxU-0007SK-MX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Jun 2004 02:00:49 -0700
In-Reply-To: <40E20187.1050803@nks.net>
References: <20040629182711.GM5243@alcor.net> <40E20187.1050803@nks.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-3-753330730"
Message-Id: <02F391BE-CA6B-11D8-A5A1-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
From: Paul Wagland <paul@wagland.net>
Subject: Re: [uml-devel] [mgedmin@b4net.lt: Bug#256873: user-mode-linux: fails
	to start (kernel panic)]
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
Date: Wed, 30 Jun 2004 09:56:36 +0200
To: James Neal <jneal@nks.net>
Cc: Matt Zimmerman <mdz@debian.org>, user-mode-linux-devel@lists.sourceforge.net, 256873-forwarded@bugs.debian.org, Marius Gedminas <mgedmin@b4net.lt>



--Apple-Mail-3-753330730
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Jun 30, 2004, at 1:55, James Neal wrote:

> Matt Zimmerman wrote:
>
>> I am receiving many reports from my users that 2.4.26-1um is less 
>> functional
>> than past versions, especially (but not exclusively) where hostfs is
>> concerned.  Are others experiencing problems as well?  I am 
>> considering
>> reverting the Debian packages to 2.4.24-1um, which was the last 
>> version
>> which was stable for me (it had only one frustrating hostfs bug, where
>> readdir() would read forever).
>>
> Yeah, I upgraded about a hundred (non-critical) UMLs to a straight 
> 2.4.26-1um kernel about a two weeks ago, and immediately started 
> getting 2-3 crashes (like the one below) per hour.   When backups 
> kicked off, they pretty much all went down at the same time.  
> (Unfortunately, I hadn't added automatic backtracing to the UMLazi 
> codebase yet, so I didn't get backtraces.)

I normally hate doing this... but me too!

Even worse, it would appear that UML and reiserfs don't play nice... 
when the UML does crash I tend to end up with some pretty massive 
filesystem corruptions, to the point where my UML will not boot 
anymore, and I spent over an hour just now trying to coax it back to 
life by copying in and replacing all of the corrupted binaries.

This is using UBD, and not hostfs.

Cheers,
Paul

--Apple-Mail-3-753330730
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFA4nI1tch0EvEFvxURAo25AJ9rOphj6B3VU8/bCd7UQvb0SNhB9gCgnFCy
uWpYlGwwzdi2DexOn7Ozu8U=
=M7Jm
-----END PGP SIGNATURE-----

--Apple-Mail-3-753330730--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
