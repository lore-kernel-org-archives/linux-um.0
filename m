Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f0499858-1c3c-5a51-27c6-d3f5e82d1173@nod.at>
References: <20170403195458.112185-1-mka@chromium.org> <20170417203738.GQ28657@google.com>
 <f0499858-1c3c-5a51-27c6-d3f5e82d1173@nod.at>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 18 Apr 2017 17:17:16 +0900
Message-ID: <CAK7LNAR_i3UW2TH1QB7Wq62cp+O7WRSgUk3Syc7M8oG6J++HzA@mail.gmail.com>
Subject: Re: [PATCH] um: Include kbuild.h instead of duplicating its macros
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Matthias Kaehlcke <mka@chromium.org>, Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2017-04-18 16:44 GMT+09:00 Richard Weinberger <richard@nod.at>:
> Matthias,
>
> Am 17.04.2017 um 22:37 schrieb Matthias Kaehlcke:
>> El Mon, Apr 03, 2017 at 12:54:58PM -0700 Matthias Kaehlcke ha dit:
>>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>  arch/x86/um/shared/sysdep/kernel-offsets.h | 9 +--------
>>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>>
>>> diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/sysdep/kernel-offsets.h
>>> index 46a9df99f3c5..7e1d35b6ad5c 100644
>>> --- a/arch/x86/um/shared/sysdep/kernel-offsets.h
>>> +++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
>>> @@ -2,16 +2,9 @@
>>>  #include <linux/sched.h>
>>>  #include <linux/elf.h>
>>>  #include <linux/crypto.h>
>>> +#include <linux/kbuild.h>
>>>  #include <asm/mman.h>
>>>
>>> -#define DEFINE(sym, val) \
>>> -    asm volatile("\n->" #sym " %0 " #val : : "i" (val))
>>> -
>>> -#define BLANK() asm volatile("\n->" : : )
>>> -
>>> -#define OFFSET(sym, str, mem) \
>>> -    DEFINE(sym, offsetof(struct str, mem));
>>> -
>>>  void foo(void)
>>>  {
>>>  #include <common-offsets.h>
>>> --
>>
>> Ping, any comment on this patch?
>
> Looks good, nothing exploded while a quick test.
> I'll queue it for the next merge window. :-)
>
> Thanks,
> //richard


If not too late, please feel free to add my

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada

