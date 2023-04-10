Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C891C77B61
	for <linux-um@archiver.kernel.org>; Mon, 10 Apr 2023 01:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CkMIYWogapPHsQnmsM1cc+2qbai80saRWNg8PDcBGlE=; b=jyCEFaSPPVqbUe
	7IsJioR4F4rcAG7/kVha2ObDx8mkfwjfY8J+I9/9qLEn3rK7Blh+wsRWp2CYOnp/t9Ivxee9XyK/P
	dozK9ksRydcgLV0sEQT9t+JODTJzQkJWe7Vb72Epc4xbhVRC+HP3/gvb/IsMgfL50xTIDBR81mUcN
	QmczKIbM1xuknqq4EChnjAz/aZ9HwkTUbjvIfmItpPJx2UazNgP4FKWjMkpo96cWn0eNwhdLNlDP8
	NlnRBj3gz484wlkq6FlrMy1dvqRdd0lIq1ZIcMHrr6F+smk0ehrr9p4+RiLRwf3hx9zhhHOt74GB/
	xb6BHVgGI0M2UterlrIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plg64-00EPdU-1Y;
	Mon, 10 Apr 2023 01:13:28 +0000
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1plg61-00EPd9-31;
	Mon, 10 Apr 2023 01:13:26 +0000
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
Subject: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with TRACEPOINTS
Date: Sun,  9 Apr 2023 18:13:25 -0700
Message-Id: <20230410011325.26850-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
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
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
v2: change from not building on UML to fixing the build on UML
v3: add Rev-by: Damien Le Moal

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
