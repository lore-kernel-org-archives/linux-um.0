Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQSMo-0001mG-5u for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 12:38:46 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KQSMm-0002AI-Od for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 12:38:46 -0700
Received: from [192.168.130.27] (lnxtleo01004.meduna.lan [192.168.130.27])
	by meduna.org (Postfix) with ESMTP id 515779C434
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  5 Aug 2008 21:46:37 +0200 (CEST)
Message-ID: <4898AC10.3010602@meduna.org>
Date: Tue, 05 Aug 2008 21:37:52 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <4896F8A1.6020203@meduna.org>
	<20080804164246.GA14805@c2.user-mode-linux.org>
In-Reply-To: <20080804164246.GA14805@c2.user-mode-linux.org>
Subject: Re: [uml-devel] /dev/random problems _not_ solved in 2.6.26
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

Jeff Dike wrote:

> If nothing else works, I suppose a nasty workaround might be to
> replace /dev/random with dev/urandom, but that has security
> implications.

I am aware of the implications, but unfortunately it did
not help either.

# ls -l /dev/*random*
crw-rw-rw- 1 root root 1, 8 2008-08-05 17:41 /dev/oldrandom
lrwxrwxrwx 1 root root    7 2008-08-05 17:41 /dev/random -> urandom
crw-rw-rw- 1 root root 1, 9 2008-08-05 17:42 /dev/urandom

# grep random /var/log/auth.log
Aug  5 19:53:50 dirk sshd[3117]: fatal: Couldn't obtain random bytes (error 604389476)

# cat /proc/sys/kernel/random/entropy_avail
335

I am now talking to the host owner - he is running quite
a few UML guests, each in chroot environment, and one of the
problems is that his entropy gets sucked out...

Now he has replaced random with urandom in my chroot jail,
so the UML's random is his urandom. Let's see what happens...

-- 
                                     Stano


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
