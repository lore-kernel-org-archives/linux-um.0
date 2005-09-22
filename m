Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIWtE-0008D2-Ej	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 12:37:52 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EIWtA-0000cJ-Oa
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 12:37:52 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] hangup
References: <1127390899.7679.36.camel@localhost.localdomain>
In-Reply-To: <1127390899.7679.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200509222123.40489.blaisorblade@yahoo.it>
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
Date: Thu, 22 Sep 2005 21:23:40 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rickard =?iso-8859-1?q?Vikstr=F6m?= <rickard@azalea.se>

On Thursday 22 September 2005 14:08, Rickard Vikstr=F6m wrote:
> Hi uml-people
>
> I have problem with hostkernel 2.6.12-skas3-v8.2 to start a guest.
> This is the output:

> ./2.4.29  eth0=3Dtuntap,tap_bf,00:11:2F:87:09:02 ubd0=3Ddebian20gigg.iso
> mem=3D512M

> and the hangup is here:
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Mounted devfs on /dev

> (I get nothing after "mounted...")
That could be a console setup problem, but
> And in top I get 100% cpuusage for that guest-pid.
Ok, that's bad, yes. But please try 2.4.28-bs2 and say the *guest* version =

(including the patch version). There are some problems with 2.4.27-1um.

That said, UML 2.4 is more problematic in general, and more buggy, than=20
UML/2.6. Try to use the -bs patches for 2.6 too. And report any problem you=
=20
get with 2.6, we might be able to fix them.
> Can someone point me in the right direction.

> And I also have problem with jdk 1.{4,5} on 2.4.X-guestkernels Is there
> a known problem with 2.4.X + jdk 1.{4,5} ?
Try 2.4.28-bs2 - on other releases there are known problems, yes.
--=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

=09

=09
	=09
___________________________________=20
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB=20
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
