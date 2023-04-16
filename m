Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6C2C77B61
	for <linux-um@archiver.kernel.org>; Sun, 16 Apr 2023 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rVe327aHtuReozMXxJNbxwwQ3H5WXP8VdmJzodncqAM=; b=b87kQmKcV0LQbD
	Z6908Ee4LbXVrWL+Y2ZRA+0U9ZJKETEOYyW8ULqBUhd+ZLOccVpjzcZBYMrce9TArr9QzRqAX4rfM
	QdHVUOtyzLaUouc1MfzKHp5aRGMpEl5lsIc+O+pYoBhJwXEHnsfpVZU8nWpA7+iGT0+7K4ecewmTe
	Z/wdO96umc6TAuN34YXO65MGbwM5nwQWFd/mF2enm7xXCv7iYuxEl4veTw0hZEaiGrkl7mC9Tnzsf
	i1aomSLQIqnW8l6FBy1KUB5bwRyfmYVXA90stkiwutNfzfAaRvVEPI1/l0ADl713R99a7adnbz4vc
	AEjIQlGCJrlx9TkjC1lQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnvkP-00DDgb-2t;
	Sun, 16 Apr 2023 06:20:25 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pnvkI-00DDfz-2z;
	Sun, 16 Apr 2023 06:20:18 +0000
Date: Sat, 15 Apr 2023 23:20:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	linux-ide@vger.kernel.org, linux-um@lists.infradead.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with
 TRACEPOINTS
Message-ID: <ZDuTotxqsrysNaYu@infradead.org>
References: <20230410011325.26850-1-rdunlap@infradead.org>
 <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
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

On Fri, Apr 14, 2023 at 03:55:07PM +0200, Johannes Berg wrote:
> On Sun, 2023-04-09 at 18:13 -0700, Randy Dunlap wrote:
> > Current build of pata_cs5536 for i386 UML fails with:
> > 
> > ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > 
> > Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.
> > 
> 
> Hm. Does this make sense? I can't see it'd work on UML to configure an
> IDE device through MSRs? Surely that can't work? IOW, that entire driver
> can't really work anyway can it?
> 
> OTOH, maybe theoretically it could work in PCI, just not with MSRs, and
> then this patch makes some sense?

I think it is is integrated into actual Geode SOCs.  That being
said something like the patch below seems as simple as it gets and
at least gives build coverage on uml

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index ab47aeb5587f55..4f5d9afd51c9d8 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -27,7 +27,7 @@
 #include <scsi/scsi_host.h>
 #include <linux/dmi.h>
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
 #include <asm/msr.h>
 static int use_msr;
 module_param_named(msr, use_msr, int, 0644);

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
