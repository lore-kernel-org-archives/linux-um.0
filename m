Return-Path: <anton.ivanov@cambridgegreys.com>
Subject: Re: [RESEND PATCH 0/4] um: build and irq fixes
References: <20190403083902.3975-1-brgl@bgdev.pl>
 <CAMRc=MdBVwYiHLPRAJFVaS2OKx-006+P8R8VEfe+x6W_3uq37w@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <0d83eba7-f71c-53e0-57ef-29aacbef64f1@cambridgegreys.com>
Date: Wed, 3 Apr 2019 14:20:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdBVwYiHLPRAJFVaS2OKx-006+P8R8VEfe+x6W_3uq37w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>



On 03/04/2019 09:39, Bartosz Golaszewski wrote:
> śr., 3 kwi 2019 o 10:39 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> I've previously sent these patches separately. I still don't see them
>> in next and I don't know what the policy is for picking up uml patches
>> but I thought I'd resend them rebased together on top of v5.1-rc3.
>>
> 


I test and ack stuff to the extent I can (especially the areas which I 
have worked on recently). Richard has the final say for what goes in on 
the next merge and he does it based on his own and my testing and/or 
markings in patchwork.


> And of course I forgot to pick up acks from Anton...

Indeed - I have acked some of these :)

> 
>> Bartosz Golaszewski (4):
>>    um: remove unused variable
>>    um: remove uses of variable length arrays
>>    um: define set_pte_at() as a static inline function, not a macro
>>    um: irq: don't set the chip for all irqs
>>
>>   arch/um/include/asm/pgtable.h |  7 ++++++-
>>   arch/um/kernel/irq.c          |  2 +-
>>   arch/um/kernel/skas/uaccess.c |  1 -
>>   arch/um/os-Linux/umid.c       | 36 ++++++++++++++++++++++++++---------
>>   4 files changed, 34 insertions(+), 12 deletions(-)
>>
>> --
>> 2.21.0
>>
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

