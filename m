Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fijtx-0006R6-9L
 for linux-um@lists.infradead.org; Thu, 26 Jul 2018 17:18:21 +0000
Date: Thu, 26 Jul 2018 19:21:43 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: include architecture Kconfig files from top-level Kconfig v3
Message-ID: <20180726172143.GA9836@lst.de>
References: <20180724175646.3621-1-hch@lst.de>
 <CAK7LNARP2HZ8GdsAU8h_b04jLWbvFXTWqiVt2hpE0vJbjP82ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK7LNARP2HZ8GdsAU8h_b04jLWbvFXTWqiVt2hpE0vJbjP82ZA@mail.gmail.com>
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Simek <monstr@monstr.eu>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@lists.infradead.org, Ley Foon Tan <lftan@altera.com>, Christoph Hellwig <hch@lst.de>

On Wed, Jul 25, 2018 at 01:30:24PM +0900, Masahiro Yamada wrote:
> Could you check the difference of CONFIG_PREEMPT_COUNT, please?
> 
> 
> For alpha, hexagon, um,
> CONFIG_PREEMPT_COUNT was previously never enabled
> because kernel/Kconfig.preempt was not included.
> 
> Now, CONFIG_PREEMPT_COUNT can be enabled
> if it is select'ed by someone.
> 
> I guess this change will be OK, but
> I'd like you and Randy to double-check it just in case.

It might be fine, but with this little fix folded in we should be
safer:

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index cd1655122ec0..1321a4a7a677 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -57,4 +57,5 @@ config PREEMPT
 endchoice
 
 config PREEMPT_COUNT
-       bool
\ No newline at end of file
+	depends on !ARCH_NO_PREEMPT
+	bool

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

