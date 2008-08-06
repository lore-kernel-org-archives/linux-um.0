Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQgvz-0002n9-OF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 04:12:03 -0700
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQgvy-00014Y-Th
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 04:12:03 -0700
From: Tomas Mraz <tmraz@redhat.com>
In-Reply-To: <48996A21.90603@meduna.org>
References: <48996A21.90603@meduna.org>
Date: Wed, 06 Aug 2008 13:11:53 +0200
Message-Id: <1218021113.3146.164.camel@vespa.frost.loc>
Mime-Version: 1.0
Subject: Re: [uml-devel] Couldn't obtain random bytes in sshd - problem in
	RAND_poll?
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

On Wed, 2008-08-06 at 11:08 +0200, Stanislav Meduna wrote:
> Hi,
> 
> I and a few other users are seeing sshd failing with
>    Couldn't obtain random bytes (error 604389476)
> and other ssl-related application failing randomly
> in user mode linux guests and I suspect a problem
> in openssl that got triggered by some change in UML.
> 
> I reviewed the RAND_poll function in rand_unix.c
> (statically, no time for building a debug version now)
> and have following suspicions:
> 
> ===
> For Linux:
> 
> int r;   ... this has random bytes from stack
> ...
> 
> if (poll(&pset, 1, usec / 1000) < 0)
>    usec = 0;
> else
>    try_read = (pset.revents & POLLIN) != 0;
> 
> ... Let's say that the poll timed out (i.e. returned 0)
>      try_read remains 0, r still has garbage

The r is set to -1 in the else of if(try_read) statement.

> while ((r > 0 || (errno == EINTR || errno == EAGAIN)) &&
> 
> ... Let's say that the garbage was negative. We are out of
>      the loop and errno has bogus data (successfull/timed out
>      poll did not set anything)

errno has garbage value - this should be fixed by initializing errno to
0 before the poll/select calls. But in the worst case it means the code
will wait until it will be able to read some data from the random device
(which was not the intent).

> 
> === For other Unices there's additional problem:
> 
> If the select select's successfully and immediately, it can
> leave the time not slept unchanged in the time argument
> (which is IMHO fully legal, if it finds the bytes immediately).
> If the read then does not get all the needed bytes, the code
>    if (usec == 10*1000)
>      usec = 0;
> kicks in and we are out of the loop again.

The problem is not in the RAND_poll() timeouting - this is fully
intentional, the function should timeout after 10ms if the random device
blocks read. The default is to
try /dev/urandom, /dev/random, /dev/srandom in this order. So if you for
example do not have /dev/urandom and have just the blocking /dev/random,
it is perfectly possible that the RAND_poll returns error. The other
possibility is that the /dev/urandom is broken in UML and blocks if not
enough entropy is available.

-- 
Tomas Mraz
No matter how far down the wrong road you've gone, turn back.
                                              Turkish proverb


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
