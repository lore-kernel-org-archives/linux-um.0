Return-Path: <anton.ivanov@cambridgegreys.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
References: <20190411094944.12245-1-brgl@bgdev.pl>
 <20190411094944.12245-5-brgl@bgdev.pl>
 <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com>
Date: Wed, 8 May 2019 08:09:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Richard Weinberger <richard.weinberger@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On 07/05/2019 22:26, Richard Weinberger wrote:
> On Thu, Apr 11, 2019 at 11:50 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Setting a chip for an interrupt marks it as allocated. Since UM doesn't
>> support dynamic interrupt numbers (yet), it means we cannot simply
>> increase NR_IRQS and then use the free irqs between LAST_IRQ and NR_IRQS
>> with gpio-mockup or iio testing drivers as irq_alloc_descs() will fail
>> after not being able to neither find an unallocated range of interrupts
>> nor expand the range.
>>
>> Only call irq_set_chip_and_handler() for irqs until LAST_IRQ.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Just noticed that this triggers the following errors while bootup:
> Trying to reregister IRQ 11 FD 8 TYPE 0 ID           (null)
> write_sigio_irq : um_request_irq failed, err = -16
> Trying to reregister IRQ 11 FD 8 TYPE 0 ID           (null)
> write_sigio_irq : um_request_irq failed, err = -16
> VFS: Mounted root (hostfs filesystem) readonly on
> 
> Can you please check?
> This patch is already queued in -next. So we need to decide whether to
> revert or fix it now.
> 
I am looking at it. It passed tests in my case (I did the usual round).

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

