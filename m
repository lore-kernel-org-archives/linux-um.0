Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEVsB-0000Va-RD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2004 09:07:23 -0700
Received: from smtp-out13.xs4all.nl ([194.109.24.14] helo=smtp-out6.xs4all.nl)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BEVsB-0000Fx-AH for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Apr 2004 09:07:23 -0700
In-Reply-To: <200404151417.i3FEHr623628@duna48.eth.ericsson.se>
References: <200404151417.i3FEHr623628@duna48.eth.ericsson.se>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-16-744178880"
Message-Id: <B406564A-8FBD-11D8-8B4A-000A95CD704C@wagland.net>
Content-Transfer-Encoding: 7bit
From: Paul Wagland <paul@wagland.net>
Subject: Re: [uml-devel] Kernel panic: fix_range fixing wrong address space
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
Date: Fri, 16 Apr 2004 17:49:53 +0200
To: Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>
Cc: user-mode-linux-devel@lists.sourceforge.net



--Apple-Mail-16-744178880
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed


On Apr 15, 2004, at 16:17, Miklos Szeredi wrote:

> I get this error on 2.6.4 + latest uml patch.  The cause seems to be
> when call_usermodehelper() function is called twice in quick
> succession.  Timing seems to play the major role here, doing
> schedule() between them doesn't help.  I've tried under 2.4 and 2.6
> hosts, and the problem appears in both cases.  The same module runs
> perfectly under native linux, so it seems to be a UML bug.
>

to quote from the linux-kernel mailing list:

> The fix is in Andrew Morton's tree. The solution was to add a
> call_usermodehelper_async, which can be called with semaphores held.
> Grab the following patches:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/ 
> 2.6.5-mm6/broken-out/call_usermodehelper_async.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/ 
> 2.6.5-mm6/broken-out/call_usermodehelper_async-always.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/ 
> 2.6.5-mm6/broken-out/kstrdup-and-friends.patch
>
> You will get a compile error since the mm tree has another patch in it.
> Change the offending (system_state != SYSTEM_RUNNING) to  
> (!system_running)



Cheers,
Paul

--Apple-Mail-16-744178880
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAgACltch0EvEFvxURAiq0AJ4gZjxWoqH8EdaxVtGarAYIChoBCQCfXrnu
nMURLz8xNyd7AqY12jUxi/s=
=Mf4c
-----END PGP SIGNATURE-----

--Apple-Mail-16-744178880--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
