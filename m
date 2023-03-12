Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D2EC6FD19
	for <linux-um@archiver.kernel.org>; Sun, 12 Mar 2023 23:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=b/UuivyMs9LX3GeoBHa7U0lLEoRLRH31A5QUugHNE4c=; b=QvG+jUnd66Hhu6
	6Obx7peKgjQjls1aUAYXJN2LwtqxpvEUXkbbxDsbFjAa4nXUY3EojHyJKhrNjJXHCsPt04NOLRttG
	PQ6Dy6QQ2tHmkmdO7MtE6BV8SSfc01qD+t1zjhCmsISmzRnp1QGcpD8PmXa2ghKLGAwzM4gWy5B8J
	JfJp5YkIahlcu7U02brfdI6BbP7dI5U1v6gGpnajwM+Bo9IEjx5AUMRPUS7InZ1PMNAR+c6TeCw6E
	+Gu5bWGwQuR5E3bi/qMqWwW3e7mf7Nwdjbq1jF/iPCR12FOB+/pzfqI/7h+IqG5flXBU9gv9suTYm
	7ESxdDd4XnVDkcZ+ygJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbVXo-003qDx-09; Sun, 12 Mar 2023 23:56:04 +0000
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbVXg-003qDa-9l; Sun, 12 Mar 2023 23:55:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-ide@vger.kernel.org,
	linux-um@lists.infradead.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] UML: pata_cs5536: fix build for X86_32 UML with TRACEPOINTS
Date: Sun, 12 Mar 2023 16:55:53 -0700
Message-Id: <20230312235553.26298-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Current build of pata_cs5536 for i386 UML fails with:

ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!

Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-ide@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/x86/um/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/x86/um/Makefile b/arch/x86/um/Makefile
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -21,7 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
-subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
+subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o ../lib/msr.o
 subarch-y += ../kernel/sys_ia32.o
 
 else

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
