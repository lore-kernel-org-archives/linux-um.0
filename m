Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1d7kDy-0003XQ-8S
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2017 15:05:22 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d7kDw-0001e5-3Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2017 15:05:22 +0000
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
	<20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
Date: Mon, 8 May 2017 17:05:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
Subject: Re: [uml-devel] [uml-user] UML on WSL
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Thomas,

Am 08.05.2017 um 17:02 schrieb Thomas Meyer:
> Sadly, UML executable bails out very early. it Looks like WSL is missing some PTRACE stuff:
> 
> thomas@DESKTOP-DQBDJ0U:/mnt/c/Users/thomas/Downloads$ ./linux
> Core dump limits :
>         soft - NONE
>         hard - NONE
> Checking that ptrace can change system call numbers...check_ptrace: PTRACE_OLDSETOPTIONS failed: Invalid Argument

We could figure how to report issues to WSL, create self-hosting unit tests and ask them to add/fix
these features.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

