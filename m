Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQf1E-0005Kp-SD for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 02:09:20 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KQf1E-0005MF-9s for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 02:09:20 -0700
Message-ID: <48996A21.90603@meduna.org>
Date: Wed, 06 Aug 2008 11:08:49 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
Subject: [uml-devel] Couldn't obtain random bytes in sshd - problem in
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

Hi,

I and a few other users are seeing sshd failing with
   Couldn't obtain random bytes (error 604389476)
and other ssl-related application failing randomly
in user mode linux guests and I suspect a problem
in openssl that got triggered by some change in UML.

I reviewed the RAND_poll function in rand_unix.c
(statically, no time for building a debug version now)
and have following suspicions:

===
For Linux:

int r;   ... this has random bytes from stack
...

if (poll(&pset, 1, usec / 1000) < 0)
   usec = 0;
else
   try_read = (pset.revents & POLLIN) != 0;

... Let's say that the poll timed out (i.e. returned 0)
     try_read remains 0, r still has garbage

while ((r > 0 || (errno == EINTR || errno == EAGAIN)) &&

... Let's say that the garbage was negative. We are out of
     the loop and errno has bogus data (successfull/timed out
     poll did not set anything)


=== For other Unices there's additional problem:

If the select select's successfully and immediately, it can
leave the time not slept unchanged in the time argument
(which is IMHO fully legal, if it finds the bytes immediately).
If the read then does not get all the needed bytes, the code
   if (usec == 10*1000)
     usec = 0;
kicks in and we are out of the loop again.


Suggested changes:

- add
     r = -1;
   inside the do loop after the int try_read = 0;

- change
     if (usec == 10*1000)
   into
     if (r < 0 && usec == 10*1000)


Regards
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
