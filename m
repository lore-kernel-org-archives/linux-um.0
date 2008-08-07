Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KR287-00046J-Jg for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 02:49:59 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KR286-000599-65 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Aug 2008 02:49:59 -0700
Message-ID: <489AC525.3060305@meduna.org>
Date: Thu, 07 Aug 2008 11:49:25 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <4896F8A1.6020203@meduna.org><20080804164246.GA14805@c2.user-mode-linux.org>	<4898AC10.3010602@meduna.org>	<7B4268E5ACB878429B58D4BE5B780E8301A303A5@NWS-EXCH2.nws.oregonstate.edu>
	<48995D1A.6030203@meduna.org>
In-Reply-To: <48995D1A.6030203@meduna.org>
Subject: Re: [uml-devel] /dev/random problems .. or FP registers corruption?!
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
Cc: openssl-dev@openssl.org

Hi,

Well, I am now puzzled quite a bit more. Another problem
on this UML box is that if I do tail -f on some file,
I ocassionally get an assertion:

tail: xnanosleep.c:67: xnanosleep: Assertion `0 <= seconds' failed.

This seems to happen more often (or at all) when I am
doing something using the openssl - tail -f on an apache
access log runs fine when I am doing http accesses
and fails quite repeatedly when I am doing https
or starting/terminating new SSL connection from/to the box.

I also have a few strace-s from the failing sshd,
where I can't really understand how the code got there.

These two have one thing in common - a double variable
that got initialized long ago and at the time of the
problem it looks like it mysteriously changed value:
"entropy" in the case of openssl and "sleep_interval"
in tail.

Am I seeing ghosts? Anyone got other mysterious
problems with current UML kernel? Could it be that
some state-saving method is corrupting fp registers
or something like that? Was there some change in the
UML / vanilla kernel recently?

To the openssl-ers: I am starting to think that openssl
is fine here and that the problem is indeed in the
UML kernel.


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
