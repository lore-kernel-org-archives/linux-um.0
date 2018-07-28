Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fjDSi-0000UB-0B
 for linux-um@lists.infradead.org; Sat, 28 Jul 2018 00:52:01 +0000
MIME-Version: 1.0
In-Reply-To: <20180727074854.GA21840@lst.de>
References: <20180724175646.3621-1-hch@lst.de>
 <CAK7LNARP2HZ8GdsAU8h_b04jLWbvFXTWqiVt2hpE0vJbjP82ZA@mail.gmail.com>
 <20180726172143.GA9836@lst.de>
 <CAK7LNASd0YCj4wwmT9-6GYiBz=wDoXkmQW2F_5XjbCzS9-weUw@mail.gmail.com>
 <20180727074854.GA21840@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 28 Jul 2018 09:50:45 +0900
Message-ID: <CAK7LNATnt9ryzMD7=6WNnoJq2B3wT_TJisJgpF=MPFwqF6yP=g@mail.gmail.com>
Subject: Re: include architecture Kconfig files from top-level Kconfig v3
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
To: Christoph Hellwig <hch@lst.de>
Cc: Michal Simek <monstr@monstr.eu>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@lists.infradead.org, Ley Foon Tan <lftan@altera.com>

2018-07-27 16:48 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> On Fri, Jul 27, 2018 at 10:32:19AM +0900, Masahiro Yamada wrote:
>> This will just add a new unmet dependency warning.
>> CONFIG_PREEMPT_COUNT will be still selected.
>
> True.  I guess we simply need to prohibit CONFIG_DEBUG_ATOMIC_SLEEP
> explicitly if PREEMPT_COUNT isn't supported.  E.g something like this:
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 26d3ff7e3cf4..373ce9fecd7e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1195,6 +1195,7 @@ config DEBUG_ATOMIC_SLEEP
>         bool "Sleep inside atomic section checking"
>         select PREEMPT_COUNT
>         depends on DEBUG_KERNEL
> +       depends on !ARCH_NO_PREEMPT
>         help
>           If you say Y here, various routines which may sleep will become very
>           noisy if they are called inside atomic sections: when a spinlock is


I will fold this into 07/10.


I see another 'select PREEMPT_COUNT' in
drivers/gpu/drm/i915/Kconfig.debug
but DRM_I915 depends on X86, so this is not
a real problem.



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

