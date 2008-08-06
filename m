Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQe9a-0007YZ-Gz for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 01:13:54 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KQe9X-0002C1-OC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 01:13:54 -0700
Message-ID: <48995D1A.6030203@meduna.org>
Date: Wed, 06 Aug 2008 10:13:14 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <4896F8A1.6020203@meduna.org><20080804164246.GA14805@c2.user-mode-linux.org>
	<4898AC10.3010602@meduna.org>
	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
In-Reply-To: <7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
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

Brock, Anthony - NET wrote:

>> Now he has replaced random with urandom in my chroot jail,
>> so the UML's random is his urandom. Let's see what happens...
> 
> Please keep me appraised of what you find.

Look like this works - at least there were no problems over the night.

>                                                  Instead we now
> have scripts that automatically restart processes that use OpenSSL when
> they die.

Tried this too. Note that if you are checking the affected
ports it can actually make the situation worse - I tried this
using monit checking for ssh and https and as it creates
a SSL connection to do this, it needs the entropy, both
the client and the server.

> We tried shifting to urandom earlier to see if it would
> resolve the issue, but didn't see a change in behavior.

I looked into the openssl code (vanilla, dunno whether
there are OS-specific patches, I am using Debian testing).

It tries to use both /dev/urandom, /dev/random and
/dev/srandom, and it filters them according to major/minor -
so linking the /dev/* on the guest won't help, it picks one.
However, this one should be the urandom first...

It then select-s(!) for the device, 10 ms in each step.
If anything fails, it proceeds to the next device and
tries the same there too.

There is a suspicious code sequence:

  if (select(fd+1,&fset,NULL,NULL,&t) >= 0)
  ...
  usec = t.tv_usec;
  ...
  /* Some Unixen will update t in select(), some
     won't.  For those who won't, or if we
     didn't use select() in the first place,
     give up here, otherwise, we will do
     this once again for the remaining
     time. */
   if (usec == 10*1000)
     usec = 0;


 From the static code inspection it looks like one
of the following situations on urandom produces this:

- select returns -1 with errno other than EINTR/EAGAIN

- read on the device returns -1 or (!!!) 0 with errno
   other than EINTR/EAGAIN

- select select's successfully and immediately, leaves
   the time not slept unchanged in the time argument (which
   is IMHO fully legal, if it finds the bytes immediately)
   _and_ the read does not get all the needed bytes.

I don't have time now to exactly debug what is wrong,
but at least the last case looks as a bug in openssl,
triggered by some change in the select or read-behaviour.
I'll contact the openssl developers about it.


Linking the random to urandom on the host should make
the situation better, as it gives the guest a chance
for trying "another" device...

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
