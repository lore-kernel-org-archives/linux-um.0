Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] um: Avoid longjmp/setjmp symbol clashes with
 libpthread.a
References: <20170524003232.14319-1-f.fainelli@gmail.com>
 <cda59c31-1487-4c9d-8a6f-152caf93e1d3@gmail.com>
 <dbebd37c-bcae-14d9-445c-9f624008f9fb@nod.at>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6ca6b4d6-29e2-19bb-64ef-963d88e89bed@gmail.com>
Date: Wed, 28 Jun 2017 15:40:03 -0700
MIME-Version: 1.0
In-Reply-To: <dbebd37c-bcae-14d9-445c-9f624008f9fb@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/05/2017 12:34 PM, Richard Weinberger wrote:
> Florian,
> 
> Am 05.06.2017 um 21:32 schrieb Florian Fainelli:
>> On 05/23/2017 05:32 PM, Florian Fainelli wrote:
>>> Building a statically linked UML kernel on a Centos 6.9 host resulted in
>>> the following linking failure (GCC 4.4, glibc-2.12):
>>>
>>> /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../lib64/libpthread.a(libpthread.o):
>>> In function `siglongjmp':
>>> (.text+0x8490): multiple definition of `longjmp'
>>> arch/x86/um/built-in.o:/local/users/fainelli/openwrt/trunk/build_dir/target-x86_64_musl/linux-uml/linux-4.4.69/arch/x86/um/setjmp_64.S:44:
>>> first defined here
>>> /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../lib64/libpthread.a(libpthread.o):
>>> In function `sem_open':
>>> (.text+0x77cd): warning: the use of `mktemp' is dangerous, better use
>>> `mkstemp'
>>> collect2: ld returned 1 exit status
>>> make[4]: *** [vmlinux] Error 1
>>>
>>> Adopt a solution similar to the one done for vmap where we define
>>> longjmp/setjmp to be kernel_longjmp/setjmp. In the process, make sure we
>>> do rename the functions in arch/x86/um/setjmp_*.S accordingly.
>>>
>>> Fixes: a7df4716d195 ("um: link with -lpthread")
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>
>> Richard, we are kind of hijacking this thread now that was originally
>> about statically linking UML, is this particular patch okay?
> 
> Hehe, yes.
> This patch is good, I like it. :)
> It will part of the next pull request.

Humm okay, did you apply the patch in one of your kernel trees on
git.kernel.org or somewhere else?
-- 
Florian

