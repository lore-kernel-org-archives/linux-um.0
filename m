Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQiaZ-0006IW-CI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 05:58:03 -0700
Received: from mail1.webmaster.com ([216.152.64.169])
	by mail.sourceforge.net with esmtps (TLSv1:RC4-MD5:128) (Exim 4.44)
	id 1KQiaW-0006Fz-3m for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 05:58:03 -0700
Received: from however by webmaster.com (MDaemon.PRO.v8.1.3.R)
	with ESMTP id md50002307655.msg
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 06 Aug 2008 05:57:40 -0700
From: "David Schwartz" <davids@webmaster.com>
Date: Wed, 6 Aug 2008 05:55:35 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAECKOMAC.davids@webmaster.com>
MIME-Version: 1.0
In-Reply-To: <489994DF.1050400@meduna.org>
Subject: Re: [uml-devel] Couldn't obtain random bytes in sshd - problem in
	RAND_poll?
Reply-To: davids@webmaster.com
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
To: openssl-dev@openssl.org
Cc: user-mode-linux-devel@lists.sourceforge.net



> Tried many many times, even two running at the same time
> or poll timeout set to zero, not one instance of blocking
> even with
>    od -x /dev/urandom
> and
>    od -x /dev/random
> running simultaneously (the second one blocks, of course).
>
>
> Hmmmm.. what the #$%# is happening here.. more ideas?
>
> --
>                                     Stano

My bet is that '/dev/urandom' only blocks if it doesn't have enough entropy.
Early in the startup process, '/dev/urandom' doesn't have enough entropy,
and your application times out on it.

Later on, when the system has had lots of network activity, you log in and
test '/dev/urandom'. At this point, the system is well-seeded from the
network activity. So it works great for you.

Try launching your test program automatically on boot up at the saem time
you launch ssh or whatever application is failing. I bet '/dev/urandom' will
fail then.

If you have a network, one solution might be to do a few 'ping's or
'nslookup's to seed the entropy pool. You can also keep an entropy pool on
disk, saving it on shutdown and loading it on startup.

Or I could be completely wrong.

DS



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
