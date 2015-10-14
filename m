Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZmFwk-0008HN-3R
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Oct 2015 06:53:58 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZmFwi-0004z9-GQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Oct 2015 06:53:58 +0000
Message-ID: <561DF24C.1040702@kot-begemot.co.uk>
Date: Wed, 14 Oct 2015 07:12:28 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <55CEF513.90604@nod.at>	<4cf7d197-2f4c-4a6f-ae27-44612cc6d8e5@email.android.com>
	<CAFLxGvwQ4QarNsBGU=Ue7AZZ_QsL7TiWz8Bfkr8ENf9SFpcm7g@mail.gmail.com>
In-Reply-To: <CAFLxGvwQ4QarNsBGU=Ue7AZZ_QsL7TiWz8Bfkr8ENf9SFpcm7g@mail.gmail.com>
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

Thomas, I need to know if you have the time-slices for this or I should 
take over and finish it.

In addition to what Richard said I have the epoll based IRQ controller 
and high-performance network pipeline which depend on it in the queue.

Brgds,

A.

On 13/10/15 22:45, Richard Weinberger wrote:
> On Tue, Aug 18, 2015 at 6:04 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>> Am 15.08.2015 10:15 vorm. schrieb Richard Weinberger <richard@nod.at>:
>>> Am 09.08.2015 um 19:53 schrieb Thomas Meyer:
>>>> Switch the UML clocksource from interval timers to posix interval timers and
>>>> move to a monotonic timer.
>>>>
>>>> This fixes suspend&resume related timer issues and improves network performance
>>>> as TCP state machines are now fed with the correct time; also correct QoS and
>>>> traffic shaping.
>>> The patch is rather big. Please describe in your commit message how exactly
>>> it works and why.
>>> It changes many internals.
>> Will do so!
> Can I get an updated version of that patch?
> I really want to merge it in the next merge window.
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

