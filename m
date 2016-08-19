Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3bc79e3a-9604-3d61-fc68-443d8d8a70b6@virtuozzo.com>
References: <CAFLxGvzB=WGNEdNJVvPpQLpwCqT6oNcvEQnyT2xk0Jv2L3FBaA@mail.gmail.com>
 <1471446611-16250-1-git-send-email-aryabinin@virtuozzo.com>
 <CACT4Y+bEnGV0X1MeGvdZM1VWqr25f61GyVqRKvQO46UGpE0VhA@mail.gmail.com>
 <995ff767-9220-f9c8-c052-2b717cc7e91d@virtuozzo.com> <CACT4Y+bMvLrg_PBrGYPok3j8Y90m2FNzTY9-LuRNNGR_3FgifA@mail.gmail.com>
 <627a7126-87e6-0a89-19c5-612c5fb9d18f@virtuozzo.com> <e9536af2-7e69-8a53-96d0-7a7a92dbea31@nod.at>
 <3bc79e3a-9604-3d61-fc68-443d8d8a70b6@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 19 Aug 2016 08:24:05 -0700
Message-ID: <CACT4Y+a+MagkN-sWkiVjYdRrvfnYmB8ewYsDBU-PcAD0FzQtdA@mail.gmail.com>
Subject: Re: [PATCH] UML: don't discard .text.exit section
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Stefan Traby <stefan@hello-penguin.com>, stable <stable@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Aug 19, 2016 at 6:06 AM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
>
>
> On 08/19/2016 02:16 PM, Richard Weinberger wrote:
>> On 19.08.2016 12:48, Andrey Ryabinin wrote:
>>> On 08/19/2016 03:14 AM, Dmitry Vyukov wrote:
>>>> On Thu, Aug 18, 2016 at 3:08 AM, Andrey Ryabinin
>>>> <aryabinin@virtuozzo.com> wrote:
>>>>>
>>>>>>
>>>>>> Sorry for delays, I am travelling.
>>>>>> Do we need ".fini_array" section? It's also destructors that we don't
>>>>>> run. Or does UML use them? Does discarding ".fini_array" help?
>>>>>>
>>>>>
>>>>> libc has desctructors and use them for whatever purpose it needs.
>>>>
>>>>
>>>> Does UML actually gracefully exit running global destructors? That
>>>> would also require gracefully shutting down all threads/cpus. Doesn't
>>>> it just _exit (or syscall(SYS_exit_group))?
>>>>
>>>
>>> Sigh, I dunno, I didn't look that far. My intention was to fix build and keep old behavior unaffected.
>>> If you want to wipe destructors, and think that this is ok, go ahead.
>>
>> UML exits like any regular C program does.
>> The main() function is in arch/um/os-Linux/main.c, when the kernel terminates,
>> hence linux_main() returns back to main() it just returns the exit code.
>> At this point libc's destructors will run, right?
>>
> Sounds right to me.



If it exits then

Acked-by: Dmitry Vyukov <dvyukov@google.com>

Thanks for taking care of it.

