Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1bahnQ-0001QW-45
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Aug 2016 11:17:08 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bahnN-0006IP-VK
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Aug 2016 11:17:08 +0000
References: <CAFLxGvzB=WGNEdNJVvPpQLpwCqT6oNcvEQnyT2xk0Jv2L3FBaA@mail.gmail.com>
	<1471446611-16250-1-git-send-email-aryabinin@virtuozzo.com>
	<CACT4Y+bEnGV0X1MeGvdZM1VWqr25f61GyVqRKvQO46UGpE0VhA@mail.gmail.com>
	<995ff767-9220-f9c8-c052-2b717cc7e91d@virtuozzo.com>
	<CACT4Y+bMvLrg_PBrGYPok3j8Y90m2FNzTY9-LuRNNGR_3FgifA@mail.gmail.com>
	<627a7126-87e6-0a89-19c5-612c5fb9d18f@virtuozzo.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <e9536af2-7e69-8a53-96d0-7a7a92dbea31@nod.at>
Date: Fri, 19 Aug 2016 13:16:53 +0200
MIME-Version: 1.0
In-Reply-To: <627a7126-87e6-0a89-19c5-612c5fb9d18f@virtuozzo.com>
Subject: Re: [uml-devel] [PATCH] UML: don't discard .text.exit section
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
To: Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>
Cc: stable <stable@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On 19.08.2016 12:48, Andrey Ryabinin wrote:
> On 08/19/2016 03:14 AM, Dmitry Vyukov wrote:
>> On Thu, Aug 18, 2016 at 3:08 AM, Andrey Ryabinin
>> <aryabinin@virtuozzo.com> wrote:
>>>
>>>>
>>>> Sorry for delays, I am travelling.
>>>> Do we need ".fini_array" section? It's also destructors that we don't
>>>> run. Or does UML use them? Does discarding ".fini_array" help?
>>>>
>>>
>>> libc has desctructors and use them for whatever purpose it needs.
>>
>>
>> Does UML actually gracefully exit running global destructors? That
>> would also require gracefully shutting down all threads/cpus. Doesn't
>> it just _exit (or syscall(SYS_exit_group))?
>>
> 
> Sigh, I dunno, I didn't look that far. My intention was to fix build and keep old behavior unaffected.
> If you want to wipe destructors, and think that this is ok, go ahead.

UML exits like any regular C program does.
The main() function is in arch/um/os-Linux/main.c, when the kernel terminates,
hence linux_main() returns back to main() it just returns the exit code.
At this point libc's destructors will run, right?

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

