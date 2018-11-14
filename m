Return-Path: <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH 3/4] um: Remove unsafe printks from the io thread
References: <20181114081017.10508-1-anton.ivanov@cambridgegreys.com>
 <20181114081017.10508-3-anton.ivanov@cambridgegreys.com>
 <CAMuHMdVOD2SpJeq-Choegn4+ODODo+o25fRR3BU60agF27Nf9A@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <6ea3bcd0-2f28-8fb9-6bc9-ee881c600078@cambridgegreys.com>
Date: Wed, 14 Nov 2018 09:53:23 +0000
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVOD2SpJeq-Choegn4+ODODo+o25fRR3BU60agF27Nf9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Christoph Hellwig <hch@lst.de>
List-ID: <linux-um.lists.infradead.org>

On 11/14/18 9:35 AM, Geert Uytterhoeven wrote:
> Hi Anton,
>
> On Wed, Nov 14, 2018 at 9:11 AM <anton.ivanov@cambridgegreys.com> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Printk out of the io thread has been proven to be unsafe. This
>> is not surprising as the thread is part of the UML hypervisor
>> code. It is not supposed to invoke any kernel code/resources.
> Thanks for your patch!
>
> Perhaps this can be made safer, so people don't shoot themselves in the foot?
> I was thinking about e.g. redefining printk() in kern.h to something
> that doesn't
> exist, to cause a link error, and preincluding kern.h in all *_kern.c files,
> like is currently done with user.h in arch/um/scripts/Makefile.rules.

Indeed.

I have that in my queue as the disk io thread is not the only place.

There is also the sigio thread and the winch thread which are likely to 
be subject to the same constraints.

I have had similar crashes dealing with one of them a few years back, 
but I never debugged it properly at the time.

They all need to go to files of their own and need to have relevant 
restrictions applied.

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


