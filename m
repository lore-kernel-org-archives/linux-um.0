Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Yz8d0-0006CG-GM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 19:10:34 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Yz8cz-0000UM-0m
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 19:10:34 +0000
Message-ID: <556B5CA0.9010200@kot-begemot.co.uk>
Date: Sun, 31 May 2015 20:10:24 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <bbdd39b2-dcac-41c8-bfb4-73645e73c7b7@email.android.com>	<556AED66.3030706@nod.at>
	<1433098827.8871.13.camel@m3y3r.de>
In-Reply-To: <1433098827.8871.13.camel@m3y3r.de>
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
Subject: Re: [uml-devel] [PATCH] um: Switch clocksource to hrtimers
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 31/05/15 20:00, Thomas Meyer wrote:
> Am Sonntag, den 31.05.2015, 13:15 +0200 schrieb Richard Weinberger:
>> Am 20.05.2015 um 07:26 schrieb Thomas Meyer:
>>> Am 20.05.2015 12:12 vorm. schrieb Richard Weinberger <
>>> richard.weinberger@gmail.com>:
>>>> On Sun, May 17, 2015 at 11:25 AM, Thomas Meyer <thomas@m3y3r.de> 
>>>> wrote: 
>>>>> Switch the UML clocksource from interval timers to posix 
>>>>> interval timers 
>>>>> and move to a monotonic timer. 
>>>>>
>>>>> This fixes suspend&resume related timer issues and improves 
>>>>> network 
>>>>> performance as TCP state machines are now fed with the correct 
>>>>> time; 
>>>>> also correct QoS and traffic shaping. 
>>>>>
>>>>> Signed-off-by: Thomas Meyer <thomas@m3y3r.de> 
>>>> What tree is this patch against? 
>>>> It does not clearly apply to Linus' tree. 
>>>>
>>> Hi,
>>>
>>> I did tested the patch against 4.1-rc3-something; will update the 
>>> patch against the latest commit!
> Hi,
>
>> Ping.
>> Would be nice to have this patch for the 4.2 merge window.
> I can provide you the current version of the patch, but I'm not sure if
> it's ready for inclusion yet.

Agree.

> For example:
> - With this patch I see new zombie processes of UML userspace
> processes. I'm not sure what's going on here.

+1

> - Anton reported some hang he sees with this patch

I did not have a chance to work on it last week, will try to find some
time this week. 

> - A person from cicso is worried about the potential idle CPU usage
> after the patch, because of the many timers started, i.e. a host with
> hundreds of UMLs.
This is less then the old CPU usage - checking time and rearming
nanosleeps and itimers is expensive.

>
> Also meanwhile I think is not the correct thing to start a new timer
> for each UML userspace process, because the timer will also trigger the
> userspace process, even the corresponding process isn't scheduled by
> the kernel currently. I think the previous behaviour with the itimer
> was okay, because the virtual timer only did execute when the process
> was executing which is the correct thing to do for the currently active
> task in the UML kernel.
> I see two solutions for above problem: cascade the kernel timer into
> the current active task; there is actually no need to start a timer in
> each userspace process.
> Start/stop each timer when a userspace process becomes active resp.
> becomes inactive again.
> I hope above logic makes some sense at all! What do you think about
> this?

Cascading the kernel timer looks like the correct solution.

A.

>
> with kind regards
> thomas
>
>
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

