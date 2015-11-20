Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1Zzkst-0006ox-Gs
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:33:47 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zzkss-0001M0-4T for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:33:47 +0000
Received: from mail.nlc.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id 9FFB11C8C26
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 20 Nov 2015 13:26:33 +0100 (CET)
MIME-Version: 1.0
Date: Fri, 20 Nov 2015 13:26:33 +0100
From: stian@nixia.no
In-Reply-To: <CAFLxGvwaaWgp1AGh+yRn5QqXvLM-EdPXBD3qSnyPpxDePnZ5zQ@mail.gmail.com>
References: <564F0C6D.8000806@kot-begemot.co.uk>
	<CAFLxGvwaaWgp1AGh+yRn5QqXvLM-EdPXBD3qSnyPpxDePnZ5zQ@mail.gmail.com>
Message-ID: <1a2b6b675f22380fc7e91e5e16278cb0@nixia.no>
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
Subject: Re: [uml-devel] IRQ handler reentrancy
To: user-mode-linux-devel@lists.sourceforge.net

>> 4. While I can propose a brutal patch for signal.c which sets guards
>> against reentrancy which works fine, I suggest we actually get to 
>> the
>> bottom of this. Why the code in unblock_signals() does not guard
>> correctly against that?
>
> Thanks for hunting this issue.
> I fear I'll have to grab my speleologist's hat to figure out why UML
> works this way.
> Cc'ing Al, do you have an idea?

In the few stack-traces that I have seen posted here, I could see 
multiple calls to unlocking of signals (with a signal occurred directly 
after). That probably should not happen. Do we count the number of 
timers of time we try to block/unblock signals and only actual perform 
the action when the counter reaches/leaves 0?

if this series of calls happens:
  block()
   foo()
    block()
    bar()
    unblock()  <- this should be a no-op
   foobar()
  unblock() <- first here the signals should be unblocked again



Stian

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

