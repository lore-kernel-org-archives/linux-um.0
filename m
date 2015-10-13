Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Zm7OP-00040C-A6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Oct 2015 21:45:57 +0000
Received: from mail-oi0-f50.google.com ([209.85.218.50])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Zm7OO-0000Nt-6O
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Oct 2015 21:45:57 +0000
Received: by oiar126 with SMTP id r126so17735163oia.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 13 Oct 2015 14:45:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4cf7d197-2f4c-4a6f-ae27-44612cc6d8e5@email.android.com>
References: <55CEF513.90604@nod.at>
	<4cf7d197-2f4c-4a6f-ae27-44612cc6d8e5@email.android.com>
Date: Tue, 13 Oct 2015 23:45:50 +0200
Message-ID: <CAFLxGvwQ4QarNsBGU=Ue7AZZ_QsL7TiWz8Bfkr8ENf9SFpcm7g@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Cc: Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Aug 18, 2015 at 6:04 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Am 15.08.2015 10:15 vorm. schrieb Richard Weinberger <richard@nod.at>:
>>
>> Am 09.08.2015 um 19:53 schrieb Thomas Meyer:
>> > Switch the UML clocksource from interval timers to posix interval timers and
>> > move to a monotonic timer.
>> >
>> > This fixes suspend&resume related timer issues and improves network performance
>> > as TCP state machines are now fed with the correct time; also correct QoS and
>> > traffic shaping.
>>
>> The patch is rather big. Please describe in your commit message how exactly
>> it works and why.
>> It changes many internals.
>
> Will do so!

Can I get an updated version of that patch?
I really want to merge it in the next merge window.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

