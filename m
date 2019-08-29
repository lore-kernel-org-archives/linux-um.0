Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx1.volatile.bz ([185.163.46.97])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3LXX-0007sR-Cs
 for linux-um@lists.infradead.org; Thu, 29 Aug 2019 14:36:44 +0000
Date: Thu, 29 Aug 2019 10:36:28 -0400
From: Dark <dark@volatile.bz>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
Message-ID: <20190829103628.61953f50@thedarkness.local>
In-Reply-To: <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com>
References: <20190828204609.02a7ff70@TheDarkness>
 <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard.weinberger@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, 29 Aug 2019 15:26:24 +0200, Richard Weinberger <richard.weinberger@gmail.com> wrote: 
> So, you removed -EAGAIN handling, made everything synchronous,
> and changed the interface.t
> I'm not sure if this really a much better option.

I should have been more clear here that I'm using the interfaces 
provided by `drivers/char/hw_random/core.c` for consistency with the
other hardware RNG drivers and to avoid reimplementing stuff that's 
already there. 

It might be a bit hard to see in the diff, but I pass the file 
descriptor to `os_set_fd_async()` to prevent it from blocking.

For the -EAGAIN handling, I'm passing it onto the caller. Since you 
mentioned it, It would be better to handle it in the driver itself 
so I'll update the patch to address that.

> Rewriting the driver in a modern manner is a good thing, but throwing the
> old one way with a little hand weaving just because of a unspecified issue
> is a little harsh.
> Can you at lest provide more infos what problem you're facing with the
> old driver?

Most of it boiled down to it silently breaking if /dev/random on the 
host were to block for any reason, and there was the userspace tool
requirement to properly make use of it. With that said, the interface 
was also inconsistent with the other hardware RNG drivers which would 
require a rewrite to address anyway.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

