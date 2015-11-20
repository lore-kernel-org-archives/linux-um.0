Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zzl8z-0007R3-5h
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:50:25 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zzl8x-0002Mw-2h
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:50:25 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zzl8q-0008LW-Vv
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:50:17 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zzl8q-0000fY-Pd
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:50:16 +0000
Message-ID: <564F1708.20608@kot-begemot.co.uk>
Date: Fri, 20 Nov 2015 12:50:16 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <564F0C6D.8000806@kot-begemot.co.uk>	<CAFLxGvwaaWgp1AGh+yRn5QqXvLM-EdPXBD3qSnyPpxDePnZ5zQ@mail.gmail.com>
	<1a2b6b675f22380fc7e91e5e16278cb0@nixia.no>
In-Reply-To: <1a2b6b675f22380fc7e91e5e16278cb0@nixia.no>
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

On 20/11/15 12:26, stian@nixia.no wrote:
>>> 4. While I can propose a brutal patch for signal.c which sets guards
>>> against reentrancy which works fine, I suggest we actually get to
>>> the
>>> bottom of this. Why the code in unblock_signals() does not guard
>>> correctly against that?
>> Thanks for hunting this issue.
>> I fear I'll have to grab my speleologist's hat to figure out why UML
>> works this way.
>> Cc'ing Al, do you have an idea?
> In the few stack-traces that I have seen posted here, I could see
> multiple calls to unlocking of signals (with a signal occurred directly
> after). That probably should not happen. Do we count the number of
> timers of time we try to block/unblock signals and only actual perform
> the action when the counter reaches/leaves 0?
>
> if this series of calls happens:
>    block()
>     foo()
>      block()
>      bar()
>      unblock()  <- this should be a no-op
>     foobar()
>    unblock() <- first here the signals should be unblocked again

Block/unblock are not counting the number of enable/disable at present. 
It is either on or off.

Any unblock will immediately re-trigger all pending interrupts.

Some of the errata patches I have out of investigating this do exactly 
that - change:

block to flags = set_signals(0); bar() ; set_signal(flags);

This, if nested should  be a NOP.

However, even after fixing all of them (and their corresponding kernel 
side counterparts), I still get reentrancy, so there is something else 
at play too.

In any case, the errata should be fixed, I will sort it out, organize it 
into a patch set and send it out by Monday.

A.

>
>
>
> Stian
>
> ------------------------------------------------------------------------------
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

