Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQU9M-0004tj-VN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 14:33:00 -0700
Received: from smtp7.oregonstate.edu ([128.193.15.47])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQU9L-0005f1-LJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 14:33:00 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 5 Aug 2008 14:32:29 -0700
Message-ID: <7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
In-Reply-To: <4898AC10.3010602@meduna.org>
References: <4896F8A1.6020203@meduna.org><20080804164246.GA14805@c2.user-mode-linux.org>
	<4898AC10.3010602@meduna.org>
From: "Brock, Anthony - NET" <Anthony.Brock@oregonstate.edu>
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
To: Stanislav Meduna <stano@meduna.org>, user-mode-linux-devel@lists.sourceforge.net

> -----Original Message-----
> I am aware of the implications, but unfortunately it did
> not help either.
> 
> # ls -l /dev/*random*
> crw-rw-rw- 1 root root 1, 8 2008-08-05 17:41 /dev/oldrandom
> lrwxrwxrwx 1 root root    7 2008-08-05 17:41 /dev/random -> urandom
> crw-rw-rw- 1 root root 1, 9 2008-08-05 17:42 /dev/urandom
> 
> # grep random /var/log/auth.log
> Aug  5 19:53:50 dirk sshd[3117]: fatal: Couldn't obtain random bytes
> (error 604389476)
> 
> # cat /proc/sys/kernel/random/entropy_avail
> 335
> 
> I am now talking to the host owner - he is running quite
> a few UML guests, each in chroot environment, and one of the
> problems is that his entropy gets sucked out...
> 
> Now he has replaced random with urandom in my chroot jail,
> so the UML's random is his urandom. Let's see what happens...

Please keep me appraised of what you find. Our servers never had this
problem until upgrading to a 2.6.2x version of the kernel. SSHD, Apache
and several other software packages worked fine under previous versions
(and still do when we downgrade them). Its also worth noting that this
behavior has never been exhibited on the host system. We've only seen it
on our virtual systems.

I keep meaning to go back and search for exactly which version
introduced the changed behavior, but I don't have time. Instead we now
have scripts that automatically restart processes that use OpenSSL when
they die. We tried shifting to urandom earlier to see if it would
resolve the issue, but didn't see a change in behavior. I'm interested
in knowing if your approach will function better.

Tony


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
