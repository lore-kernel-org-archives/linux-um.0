Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <995ff767-9220-f9c8-c052-2b717cc7e91d@virtuozzo.com>
References: <CAFLxGvzB=WGNEdNJVvPpQLpwCqT6oNcvEQnyT2xk0Jv2L3FBaA@mail.gmail.com>
 <1471446611-16250-1-git-send-email-aryabinin@virtuozzo.com>
 <CACT4Y+bEnGV0X1MeGvdZM1VWqr25f61GyVqRKvQO46UGpE0VhA@mail.gmail.com> <995ff767-9220-f9c8-c052-2b717cc7e91d@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 18 Aug 2016 17:14:34 -0700
Message-ID: <CACT4Y+bMvLrg_PBrGYPok3j8Y90m2FNzTY9-LuRNNGR_3FgifA@mail.gmail.com>
Subject: Re: [PATCH] UML: don't discard .text.exit section
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Stefan Traby <stefan@hello-penguin.com>, stable <stable@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Aug 18, 2016 at 3:08 AM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
>
>
> On 08/17/2016 08:11 PM, Dmitry Vyukov wrote:
>> On Wed, Aug 17, 2016 at 8:10 AM, Andrey Ryabinin
>> <aryabinin@virtuozzo.com> wrote:
>>> Commit e41f501d3912 ("vmlinux.lds: account for destructor sections")
>>> added '.text.exit' to EXIT_TEXT which is discarded at link time by default.
>>> This breaks compilation of UML:
>>>      `.text.exit' referenced in section `.fini_array' of
>>>      /usr/lib/gcc/x86_64-linux-gnu/6/../../../x86_64-linux-gnu/libc.a(sdlerror.o):
>>>      defined in discarded section `.text.exit' of
>>>      /usr/lib/gcc/x86_64-linux-gnu/6/../../../x86_64-linux-gnu/libc.a(sdlerror.o)
>>>
>>> Apparently UML doesn't want to discard exit text, so let's place all EXIT_TEXT
>>> sections in .exit.text.
>>>
>>> Fixes: e41f501d3912 ("vmlinux.lds: account for destructor sections")
>>> Reported-by: Stefan Traby <stefan@hello-penguin.com>
>>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>>> Cc: <stable@vger.kernel.org> # 4.0+
>>> ---
>>>  arch/um/include/asm/common.lds.S | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
>>> index 1dd5bd8..1330553 100644
>>> --- a/arch/um/include/asm/common.lds.S
>>> +++ b/arch/um/include/asm/common.lds.S
>>> @@ -81,7 +81,7 @@
>>>    .altinstr_replacement : { *(.altinstr_replacement) }
>>>    /* .exit.text is discard at runtime, not link time, to deal with references
>>>       from .altinstructions and .eh_frame */
>>> -  .exit.text : { *(.exit.text) }
>>> +  .exit.text : { EXIT_TEXT }
>>>    .exit.data : { *(.exit.data) }
>>>
>>>    .preinit_array : {
>>> --
>>> 2.7.3
>>>
>>
>>
>> Sorry for delays, I am travelling.
>> Do we need ".fini_array" section? It's also destructors that we don't
>> run. Or does UML use them? Does discarding ".fini_array" help?
>>
>
> libc has desctructors and use them for whatever purpose it needs.


Does UML actually gracefully exit running global destructors? That
would also require gracefully shutting down all threads/cpus. Doesn't
it just _exit (or syscall(SYS_exit_group))?

