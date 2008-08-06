Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQhru-0000zA-7A for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 05:11:54 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KQhrs-0007TO-G3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 05:11:54 -0700
Message-ID: <489994DF.1050400@meduna.org>
Date: Wed, 06 Aug 2008 14:11:11 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <48996A21.90603@meduna.org>
	<1218021113.3146.164.camel@vespa.frost.loc>
In-Reply-To: <1218021113.3146.164.camel@vespa.frost.loc>
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

Tomas Mraz wrote:

> errno has garbage value - this should be fixed by initializing errno to
> 0 before the poll/select calls.

Actually after it returns with timeout - a successfull
syscall is free to set errno to whatever value it wants,
it is only after an error the value has to be meaningful
(I did have this problem a few times).

 > The problem is not in the RAND_poll() timeouting - this is fully
 > intentional, the function should timeout after 10ms if the random device
 > blocks read.

Ah, ok..

So what should the applications calling openssl actually
do if this happens? Now the ssh/apache/... simply exit,
which is bad (it left me without an access to a remote
box...).

I assume they are not calling the method directly, instead
they are using some of the openssl's methods. In the current
situation anyone who actually wants to block until the entropy
is available is simply out of luck :(

> try /dev/urandom, /dev/random, /dev/srandom in this order. So if you for
> example do not have /dev/urandom and have just the blocking /dev/random,
> it is perfectly possible that the RAND_poll returns error.

Both UML guest and host have /dev/urandom. I straced
a ssh, it opens /dev/urandom first, so this should
be OK too.

> The other possibility is that the /dev/urandom is broken
 > in UML and blocks if not enough entropy is available.

Good.. let's try it:

===
#include <unistd.h>
#include <fcntl.h>
#include <poll.h>
#include <stdio.h>


main()
{
   int fd = open("/dev/urandom", O_RDONLY|O_NONBLOCK|O_NOCTTY);
   int i;
   int errpoll=0, blocked=0, rdbytes=0,errread=0, nullread=0;

   for (i=0; i < 1000000; ++i)
   {
     struct pollfd pset;
     int r;
     char tmp[32];

     pset.fd = fd;
     pset.events = POLLIN;
     pset.revents = 0;

     r = poll(&pset, 1, 10);
     if (r > 0)
     {
       if ((pset.revents & POLLIN) != 0)
       {
         r = read(fd, tmp, sizeof(tmp));
         if (r < 0)
           errread++;
         else if (r==0)
           nullread++;
         else
           rdbytes += r;
       }
       else
       {
         printf("poll returned %d, but POLLIN is false (%x)\n", r, pset.revents);
       }
     }
     else if (r == 0)
       blocked++;
     else
       errpoll++;
   }

   printf("got %d bytes of entropy, poll err %d, blocked %d times, err read: %d, null 
read: %d\n", rdbytes, errpoll, blocked, errread, nullread);
}
===

got 3200000 bytes of entropy, poll err 0, blocked 0 times, err read: 0, null read: 0


Tried many many times, even two running at the same time
or poll timeout set to zero, not one instance of blocking
even with
   od -x /dev/urandom
and
   od -x /dev/random
running simultaneously (the second one blocks, of course).


Hmmmm.. what the #$%# is happening here.. more ideas?

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
