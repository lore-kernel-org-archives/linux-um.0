Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: include architecture Kconfig files from top-level Kconfig v4
Date: Tue, 31 Jul 2018 13:39:25 +0200
Message-Id: <20180731113935.6105-1-hch@lst.de>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org, Richard Weinberger <richard@nod.at>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Ley Foon Tan <lftan@altera.com>

Hi Masahiro,

what do you think about the series below, which moves the includes
of all the architecture independ Kconfig files to the top-level
Kconfig instead of duplicating the includes in all architectures?

Note that this only handles the low-hanging fruite, there are a lot
of other bits that should probably be cleaned up to be common,
but those will be not entirely trivial.

Changes since v3:
 - don't allow to select PREEMPT_COUNT for architectures that don't
   implement it
 - fix usage of SUBARCH=i386 and SUBARCH=x86_64 for um

Changes since v2:
 - fix the missing sh conversion
 - handle the lack of CONFIG_SWAP support in microblaze and nios2
   properly

Changes since v1:
 - add back a remove source statement from arch/arm/Kconfig
 - various fixes from Randy
 - various UML patches to be able to use the common Kconfig

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

