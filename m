Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 29 Aug 2019 17:30:59 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1851013915.76434.1567092659763.JavaMail.zimbra@nod.at>
In-Reply-To: <20190829103628.61953f50@thedarkness.local>
References: <20190828204609.02a7ff70@TheDarkness> <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com> <20190829103628.61953f50@thedarkness.local>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Dark <dark@volatile.bz>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, anton ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

----- Ursprüngliche Mail -----
> Von: "Dark" <dark@volatile.bz>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>, "linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "linux-um"
> <linux-um@lists.infradead.org>
> Gesendet: Donnerstag, 29. August 2019 16:36:28
> Betreff: Re: [PATCH] um: Rewrite host RNG driver.

> On Thu, 29 Aug 2019 15:26:24 +0200, Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>> So, you removed -EAGAIN handling, made everything synchronous,
>> and changed the interface.t
>> I'm not sure if this really a much better option.
> 
> I should have been more clear here that I'm using the interfaces
> provided by `drivers/char/hw_random/core.c` for consistency with the
> other hardware RNG drivers and to avoid reimplementing stuff that's
> already there.

I got this, and this is a good thing!
 
> It might be a bit hard to see in the diff, but I pass the file
> descriptor to `os_set_fd_async()` to prevent it from blocking.

Well, it does not block but passing -EAGAIN directly back is not nice.
Or does the hw_random framework handle this?

> For the -EAGAIN handling, I'm passing it onto the caller. Since you
> mentioned it, It would be better to handle it in the driver itself
> so I'll update the patch to address that.
> 
>> Rewriting the driver in a modern manner is a good thing, but throwing the
>> old one way with a little hand weaving just because of a unspecified issue
>> is a little harsh.
>> Can you at lest provide more infos what problem you're facing with the
>> old driver?
> 
> Most of it boiled down to it silently breaking if /dev/random on the
> host were to block for any reason, and there was the userspace tool
> requirement to properly make use of it. With that said, the interface
> was also inconsistent with the other hardware RNG drivers which would
> require a rewrite to address anyway.

Maybe our -EAGAIN handling is buggy.
That said I'm all for changing the driver to use the right framework
but please make sure that we don't drop useful stuff like -EAGAIN handling.

Thanks,
//richard

