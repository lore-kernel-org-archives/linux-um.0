Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3KRh-0000O7-Mq
 for linux-um@lists.infradead.org; Thu, 29 Aug 2019 13:26:39 +0000
Received: by mail-wr1-x441.google.com with SMTP id g7so3456818wrx.2
 for <linux-um@lists.infradead.org>; Thu, 29 Aug 2019 06:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190828204609.02a7ff70@TheDarkness>
In-Reply-To: <20190828204609.02a7ff70@TheDarkness>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 29 Aug 2019 15:26:24 +0200
Message-ID: <CAFLxGvyiviQxr_Bj57ibTU4DQ1H5wQC4DE5DNFBtAFoohcgbsg@mail.gmail.com>
Subject: Re: [PATCH] um: Rewrite host RNG driver.
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
To: Alexander Neville <dark@volatile.bz>
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, Aug 29, 2019 at 3:45 AM Alexander Neville <dark@volatile.bz> wrote:
>
> The old driver had a bug that would cause it to outright stop working if
> the host's /dev/random were to block. Instead of trying to track down
> the cause of said bug, rewriting it from scratch turned out to be a much
> better option as it came with a few benefits:
>
>  - The new driver properly registers itself as an hardware RNG.
>
>  - The code is simpler and therefore easier to maintain.
>
>  - It serves as a minimal example of writing a hardware RNG driver.
>
> I also edited the Kconfig symbol to bring it up to more modern
> standards.

So, you removed -EAGAIN handling, made everything synchronous,
and changed the interface.
I'm not sure if this really a much better option.

Rewriting the driver in a modern manner is a good thing, but throwing the
old one way with a little hand weaving just because of a unspecified issue
is a little harsh.
Can you at lest provide more infos what problem you're facing with the
old driver?

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

