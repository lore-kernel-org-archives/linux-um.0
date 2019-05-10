Return-Path: <anton.ivanov@cambridgegreys.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
References: <20190411094944.12245-1-brgl@bgdev.pl>
 <20190411094944.12245-5-brgl@bgdev.pl>
 <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
 <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com>
 <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
 <CAMRc=MdsA7A1DdS1ZJ8NS8xtuCjgc_7WZD1797H3oZ=2w+fOBA@mail.gmail.com>
 <CAMRc=McCxvwHgk-3wYE0e+qxJNoHK0AmpJWjNsOZBmGF2yFT6Q@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <c5918fa9-ec37-9636-5230-57260f7e8427@cambridgegreys.com>
Date: Fri, 10 May 2019 17:22:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAMRc=McCxvwHgk-3wYE0e+qxJNoHK0AmpJWjNsOZBmGF2yFT6Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Richard Weinberger <richard@nod.at>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Jeff Dike <jdike@addtoit.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>


On 10/05/2019 17:20, Bartosz Golaszewski wrote:
> pt., 10 maj 2019 o 11:16 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
>> śr., 8 maj 2019 o 09:13 Richard Weinberger <richard@nod.at> napisał(a):
>>> ----- Ursprüngliche Mail -----
>>>>> Can you please check?
>>>>> This patch is already queued in -next. So we need to decide whether to
>>>>> revert or fix it now.
>>>>>
>>>> I am looking at it. It passed tests in my case (I did the usual round).
>>> It works here too. That's why I never noticed.
>>> Yesterday I noticed just because I looked for something else in the kernel logs.
>>>
>>> Thanks,
>>> //richard
>> Hi,
>>
>> sorry for the late reply - I just came back from vacation.
>>
>> I see it here too, I'll check if I can find the culprit and fix it today.
>>
>> Bart
> Hi Richard, Anton,
>
> I'm not sure yet what this is caused by. It doesn't seem to break
> anything for me but since it's a new error message I guess it's best
> to revert this patch (others are good) and revisit it for v5.3.

Can you send me your command line and .config so I can try to reproduce it.

Brgds,

>
> Bart
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


