Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ju2xw-0007ol-ES for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 May 2008 03:03:08 -0700
Received: from smtp-1.orange.nl ([193.252.22.241])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ju2xu-0007Gg-Ld
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 May 2008 03:03:08 -0700
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6002.orange.nl (SMTP Server) with ESMTP id 16FD570000B4
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  8 May 2008 12:02:58 +0200 (CEST)
Received: from [127.0.0.1] (c529de59c.cable.wanadoo.nl [82.157.229.156])
	by mwinf6002.orange.nl (SMTP Server) with ESMTP id ECBCF70000AD
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  8 May 2008 12:02:57 +0200 (CEST)
Message-ID: <4822CFBF.8060803@vulnscan.org>
Date: Thu, 08 May 2008 12:02:39 +0200
From: "Bram Matthys (Syzop)" <syzop@vulnscan.org>
MIME-Version: 1.0
References: <4821B5FC.40307@vulnscan.org> <87hcd97ti9.fsf@hades.wkstn.nix>
In-Reply-To: <87hcd97ti9.fsf@hades.wkstn.nix>
Subject: [SPAM] Re: [uml-devel] umls unresponsive & consuming 100% cpu time
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Nix wrote:
| On 7 May 2008, Bram Matthys said:
|> Or any help on how to get additional / useful info?
|
| Set
|
| CONFIG_DEBUG_INFO=y
| CONFIG_FRAME_POINTER=y
|
| in your kernel, and recompile. `bt' will then show heaps more info.

Thanks, I'll get back with the results once it hangs again.

I just noticed something odd at one of the uml's that didn't hang. That uml
is still running the .25 kernel (without the debugging info): it says login
timeout all the time, this might be why...
When I type 'date' every second I get this:
root@vsrv:~# date
Fri Sep  5 15:49:31 UTC 2008
root@vsrv:~# date
Thu Sep  4 03:51:46 UTC 2008
root@vsrv:~# date
Tue Sep  9 01:27:15 UTC 2008
root@vsrv:~# date
Fri Sep  5 02:27:58 UTC 2008
root@vsrv:~# date
Tue Sep  2 06:22:48 UTC 2008
root@vsrv:~# date
Tue Sep  9 03:21:44 UTC 2008
root@vsrv:~# date
Tue Sep  2 22:51:05 UTC 2008
root@vsrv:~# date
Sun Sep  7 09:18:25 UTC 2008
root@vsrv:~# date
Thu Sep 11 03:24:52 UTC 2008
root@vsrv:~# date
Thu Sep 11 20:24:11 UTC 2008

So it seems to hop both forward and backward.. heavily..

There's no ntp stuff running on the UML btw.

Date/Time on the main server is correct.

I did do this on the main server a few days ago:
/etc/init.d/ntp stop
hwclock --systohc
/etc/init.d/ntp start
due to these kernel messages (on the main):
'set_rtc_mmss: can't update from 90 to 21'
..which went away after that.
but could that really be related ?
(the hw clock was off by 1 hour or so, but linux time was ok)

	Bram.

- --
Bram Matthys
Software developer/IT consultant        syzop@vulnscan.org
PGP key:                       www.vulnscan.org/pubkey.asc
PGP fp: 8DD4 437E 9BA8 09AA 0A8D  1811 E1C3 D65F E6ED 2AA2
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)

iD8DBQFIIs+/46ioc5305a8RAttsAKCwIWDpGjbH7PEaX37e7BE/sIfX8gCgkaC8
frzs6nPC35fMoJ+p78AA4h0=
=3e1T
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
