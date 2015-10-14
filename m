Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZmIHA-0008Br-8w
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Oct 2015 09:23:12 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZmIH8-00067f-Np
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Oct 2015 09:23:12 +0000
Message-ID: <561E1EF7.1060505@kot-begemot.co.uk>
Date: Wed, 14 Oct 2015 10:23:03 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <4cc8976a-1a23-4a53-a685-cfc9074c65a0@email.android.com>
In-Reply-To: <4cc8976a-1a23-4a53-a685-cfc9074c65a0@email.android.com>
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

On 14/10/15 09:25, Thomas Meyer wrote:
> Hello everyone,
>
> I would like to finish this patch, but I'm currently very busy. Sorry!

No worries :) I am barely keeping my head above water too :)

Is the most up-to-date revision the one you last posted to the list? If 
you have a more up-to-date one, please post it even if it does not patch 
cleanly and needs work. I will work on it.

A.

>
> Anton: it would be great if you could finish this patch! Much appreciated!
>
> With kind regards
> Thomas
>
> Am 14.10.2015 8:12 vorm. schrieb Anton Ivanov <anton.ivanov@kot-begemot.co.uk>:
>> Thomas, I need to know if you have the time-slices for this or I should
>> take over and finish it.
>>
>> In addition to what Richard said I have the epoll based IRQ controller
>> and high-performance network pipeline which depend on it in the queue.
>>
>> Brgds,
>>
>> A.
>>
>> On 13/10/15 22:45, Richard Weinberger wrote:
>>> On Tue, Aug 18, 2015 at 6:04 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>>>> Am 15.08.2015 10:15 vorm. schrieb Richard Weinberger <richard@nod.at>:
>>>>> Am 09.08.2015 um 19:53 schrieb Thomas Meyer:
>>>>>> Switch the UML clocksource from interval timers to posix interval timers and
>>>>>> move to a monotonic timer.
>>>>>>
>>>>>> This fixes suspend&resume related timer issues and improves network performance
>>>>>> as TCP state machines are now fed with the correct time; also correct QoS and
>>>>>> traffic shaping.
>>>>> The patch is rather big. Please describe in your commit message how exactly
>>>>> it works and why.
>>>>> It changes many internals.
>>>> Will do so!
>>> Can I get an updated version of that patch?
>>> I really want to merge it in the next merge window.
>>>
>>
>> ------------------------------------------------------------------------------
>> _______________________________________________
>> User-mode-linux-devel mailing list
>> User-mode-linux-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

