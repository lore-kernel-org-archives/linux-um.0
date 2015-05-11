Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Yrtb7-0000o7-9v
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 19:42:41 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Yrtb5-0000Y2-3l
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 May 2015 19:42:41 +0000
Message-ID: <5551061E.9080006@kot-begemot.co.uk>
Date: Mon, 11 May 2015 20:42:22 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <8cb3239b-c06a-494b-b765-ee9c5edd5c8f@email.android.com>
In-Reply-To: <8cb3239b-c06a-494b-b765-ee9c5edd5c8f@email.android.com>
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
Subject: Re: [uml-devel] [PATCH v6] um: Add a high resolution timer subsystem
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 11/05/15 18:41, Thomas Meyer wrote:
> Am 11.05.2015 7:31 nachm. schrieb Anton Ivanov <anton.ivanov@kot-begemot.co.uk>:
>> On 11/05/15 18:20, Anton Ivanov wrote:
>>> On 11/05/15 18:00, Thomas Meyer wrote:
>>>> Hi,
>>>>
>>>> maybe there is a bug in how the timers are created for all user space processes.
>>>> In the latest patch I use os__timer_remain for the initial interval.
>>>> The idea was to launch all timers at the same time. But I now think this can never work using relative times, especially when os__timer_remain returns 0, then the new timer is never launched.
>>> That is not a bad idea, just requires a more complex check in setting up
>>> interval so it is reset to default when a zero value or value > HZ is
>>> passed.
>>>
>>>
>>>> That may explain the hangs you see.
>>>>      You could try to replace os__timer_remain with the current HZ value in nanoseconds.
>>> I am going to adjust time.c instead as above.
>> Both approaches fail - the check (that is expected actually, I did not
>> think properly here - it does not cover the stub in kernel/skas) and the
>> setting of data to the correct initial values.
>>
>> Also, if it was just not starting timers it would have been possible to
>> beat the process with USR2 on the head until its morale improves. Well,
>> "while true; do kill -USR2 PID ; done" does not change the behavior, it
>> still hangs and is still possible to terminate the errant process by
>> sending SIGSEGV to the UML thread which is shown as 100% CPU and in R state.
> Yes, sending USR2 should do the same. Correct.
>
>> Problem is somewhere else. I am surprised it worked correctly in the
>> original one as there for 100% flat CPU usage it should have converged
>> to a behavior which is similar to what we have now.
> Mhh. Strange. Any hints how I can reproduce this?
>
> I need to see the same behaviour, i.e. the hang on my machine to begin to understand what is going on here.

Start off with a Debian image of let's say wheezy and hit it with a 
dist-upgrade to the next release. This produces enough IO+CPU at the 
same time to trigger it. I get it 100% reproducible every time it tries 
to unpack the first couple of packages.

I tried to trigger backtraces but could not get anything informative. 
The old trick of hitting the kernel with SIGILL which worked very nicely 
in older kernel versions no longer works :(

>
> Thanks for testing Anton.

I wish I had more time at the moment to debug it and fix it :( We are 
nearly there and it is worth it.

A.

>
>
>> A.
>>
>>> A.
>>>
>>>> Kind regards
>>>> Thomad
>>>>
>>>> A
>>> [snip]
>>>
>>> A.
>>>
>>> ------------------------------------------------------------------------------
>>> One dashboard for servers and applications across Physical-Virtual-Cloud
>>> Widest out-of-the-box monitoring support with 50+ applications
>>> Performance metrics, stats and reports that give you Actionable Insights
>>> Deep dive visibility with transaction tracing using APM Insight.
>>> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
>>> _______________________________________________
>>> User-mode-linux-devel mailing list
>>> User-mode-linux-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>>>
>>
>> ------------------------------------------------------------------------------
>> One dashboard for servers and applications across Physical-Virtual-Cloud
>> Widest out-of-the-box monitoring support with 50+ applications
>> Performance metrics, stats and reports that give you Actionable Insights
>> Deep dive visibility with transaction tracing using APM Insight.
>> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
>> _______________________________________________
>> User-mode-linux-devel mailing list
>> User-mode-linux-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

