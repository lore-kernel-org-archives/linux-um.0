Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1a2Go2-0005GI-Lf
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Nov 2015 11:03:10 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a2Go1-0003cX-CB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Nov 2015 11:03:10 +0000
Message-ID: <56583865.8010208@kot-begemot.co.uk>
Date: Fri, 27 Nov 2015 11:03:01 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <5656D596.4060906@kot-begemot.co.uk> <56582997.50407@nod.at>
In-Reply-To: <56582997.50407@nod.at>
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
Subject: Re: [uml-devel] Old process in D state bug
To: Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 27/11/15 09:59, Richard Weinberger wrote:
> Hi!
>
> Am 26.11.2015 um 10:49 schrieb Anton Ivanov:
>> Hi List, hi Richard,
>>
>> While working on the EPOLL I managed to consistently reproduce and get down to the bottom of the process in D state bug which you occasionally see with UML. I recall asking
>> Richard's help on this for the first time nearly 5 years ago ;-).
> O_o
>
>> It is extremely rare with the POLL based controller, timers and the stock UBD drivers. As you make things go faster (anywhere in UML) it rares its ugly head. So improving the IRQs,
>> improving UBD itself, etc - all make it easier to trigger.
>>
>> It looks like it is possible to end up in a state where the restart list is not empty (an earlier transaction to the disk io thread failed with EAGAIN), but with no pending IO on
>> the UBD IPC thread fd. So the restart list is never re-triggered and the UBD device ends up with a non-empty queue. The process that requested the IO ends up in D state. Any other
>> processes trying IO to the same disk join it. As the requests to the same UBD queue up, ultimately, UML goes belly up.
>>
>> Pinging the UML process with SIGIO does not help as there is no IO pending on the fd. So it is not a lost interrupt. It somehow manages to race forming the restart queue.
>>
>> If, however, you have more than one UBD device IO to the other one unstucks it by re-running the restart queue out of the ubd interrupt handler.
>>
>> Once again - this is extremely rare at present, but possible (I have seen it a few times over the last 5 years).
>>
>> So it needs a viable fix or a workaround. I will have to get this one out of the door first as it constantly gets in the way in debugging both the Epoll and the signals stuff.
> Okay, let's collect some facts first.
> Is a guest or a host process in state D?
Guest

> If it is a guest process, you can use "/proc/<pid>/stack" to find out where in the UML kernel it is blocking.

Done that already using the uml_mconsole functionality :)

Based on that it looks like block IO. It has issued a read request, that 
has gone through the guts of ext3fs and has gotten as far as the block 
layer. It is not inside UBD, it is reported as a couple of layers up. I 
can roll back my tree to a state where I can replicate that reliably and 
re-take the trace (sorry, did not keep it).

> 5 years ago UML didn't have this feature.

I already did some experiments and did some re-reading of the source:

1. You can have a failed atomic allocation. This is rare, but it 
happens. This is why it is atomic - it does not wait.
2. If you fail the atomic allocation in the ubd submit routine you have 
the request bounced up and the device scheduled for a restart (it is 
added for a restart list).
3. The restarts themselves will happen only if you have IO - they are 
done in the bottom of the IRQ routine. There is no other place to 
restart the IO.

So what happens if you have no IO pending from the disk IO thread and 
have a failed allocation so a device is scheduled for a restart?

That however may not be the only way you get in this state - I stuck a 
few debug printks and they are extremely difficult to trigger and it is 
possible to trigger this in a different way.

I have yet to figure out what triggers it in "the different way" use case.

I am also trying a couple of potential solutions:

1. Start a timer on IO submission and update it on last IO so we have an 
efficient timeout mechanism. Rerun the event loop and the restart queue 
if the timer expires. This is much closer to how a real disk operates - 
we can even recover from a failed IO thread this way.

I tried that already. It works 100%, but looks a bit expensive. I do not 
like it. I also need to do a few experiments to ensure that the effect 
is real and not a Heisenbug from triggering more timer interrupts.

2. Replace blocking IO in the disk IO thread with non-blocking, do a 
timeouted poll and throw a NULL or pointer to a static "keepalive" 
transaction when timeouts expire. This retriggers the IO interrupt and 
reruns both IO and the restart queue. This is much better aligned with 
what is needed to make the disk IO faster by bulking transactions as you 
can now read N disk io requests at a time in the io thread.

I will try that over the weekend and report back with traces.

A.

>
> Thanks,
> //richard
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

