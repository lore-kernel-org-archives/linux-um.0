Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1ZzmA8-0005Yp-L9
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 13:55:40 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZzmA7-0004Hf-6R for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 13:55:40 +0000
Received: from mail.nlc.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id 67ECA1C8CF0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 20 Nov 2015 14:48:26 +0100 (CET)
MIME-Version: 1.0
Date: Fri, 20 Nov 2015 14:48:26 +0100
From: stian@nixia.no
In-Reply-To: <564F1708.20608@kot-begemot.co.uk>
References: " <564F0C6D.8000806@kot-begemot.co.uk>"
	<CAFLxGvwaaWgp1AGh+yRn5QqXvLM-EdPXBD3qSnyPpxDePnZ5zQ@mail.gmail.com>
	<1a2b6b675f22380fc7e91e5e16278cb0@nixia.no>
	<564F1708.20608@kot-begemot.co.uk>
Message-ID: <78c7c1942ac6dcd3e2bef1b916623a2b@nixia.no>
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

Den 2015-11-20 13:50, skrev Anton Ivanov:
> On 20/11/15 12:26, stian@nixia.no wrote:
>>>> 4. While I can propose a brutal patch for signal.c which sets 
>>>> guards
>>>> against reentrancy which works fine, I suggest we actually get to
>>>> the
>>>> bottom of this. Why the code in unblock_signals() does not guard
>>>> correctly against that?
>>> Thanks for hunting this issue.
>>> I fear I'll have to grab my speleologist's hat to figure out why 
>>> UML
>>> works this way.
>>> Cc'ing Al, do you have an idea?
>> In the few stack-traces that I have seen posted here, I could see
>> multiple calls to unlocking of signals (with a signal occurred 
>> directly
>> after). That probably should not happen. Do we count the number of
>> timers of time we try to block/unblock signals and only actual 
>> perform
>> the action when the counter reaches/leaves 0?
>>
>> if this series of calls happens:
>>    block()
>>     foo()
>>      block()
>>      bar()
>>      unblock()  <- this should be a no-op
>>     foobar()
>>    unblock() <- first here the signals should be unblocked again
>
> Block/unblock are not counting the number of enable/disable at 
> present.
> It is either on or off.
>
> Any unblock will immediately re-trigger all pending interrupts.
>
> Some of the errata patches I have out of investigating this do 
> exactly
> that - change:
>
> block to flags = set_signals(0); bar() ; set_signal(flags);
>
> This, if nested should  be a NOP.
>
> However, even after fixing all of them (and their corresponding 
> kernel
> side counterparts), I still get reentrancy, so there is something 
> else
> at play too.

Please, share a stack-trace if possible.



As a side-note:
The small issue with the code example above I can see is that what if 
flags should have change during bar(). And code inside bar can do 
set_signals() magic.

I am not linux kernel ABI expert.

To me, it seems to be a more safe to have a ABI that tracks each signal 
blocked mask individually, and have a ref-counted block-all/unblock-all 
call. This would be like how you normally program on a CPU. You have a 
interrupt controller that you setup (masks), and a master interrupt 
enable/disable flag.



--

Stian

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

