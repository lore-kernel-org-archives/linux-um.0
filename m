Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF0DEB64DD
	for <linux-um@archiver.kernel.org>; Sun, 16 Jul 2023 20:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w+BKTvNJ3sEN13j9ZuLmg5iadG05bCiCHk3iPmclOH0=; b=fceYvIwVMIZVUG
	awygMUK705xpVMk3Z68G1lMQSEuTqqEw2IbM2kFtO3qRnNZRbXIJk0UJsUEGqgvHgroLDZlzrdQJ+
	ZfZji7Ew/sNT1lqAsnl6u/xaWyEcyvFRbr9CgEMyau8Xvrj/VKurbKz53MxAmHiiH0PG+sr0v11h/
	WVC1AGXKD7VwJzmgdXu28aD2/0ZwEc3IPbnwBGOFckzePDJdgp0z9okm+ki9reTM4D94sshLOzay4
	1M/pKKvDb7ndlTJ09ktGOfjtD8hPyDbzANBRghb7xOUJCoUWuhCDwaMfUjlPQ/Lq92rvOkfMeKf3Z
	9xWLwotY99GmYHEjkEyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qL8Kz-00F519-1r;
	Sun, 16 Jul 2023 20:27:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qL8Kv-00F4yJ-2H
	for linux-um@lists.infradead.org;
	Sun, 16 Jul 2023 20:27:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3606160EBC;
	Sun, 16 Jul 2023 20:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D94C433C7;
	Sun, 16 Jul 2023 20:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689539240;
	bh=PZb9GWddQADOiJrKrzADKUB01skpQR8H/5gD991yoPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdoXA4ztK0OcJMpCtq01eB7FqN9ogsCrL/1yYR4YkX5CrpswxA46UtsViWU8XkVqI
	 qq1vWUEGO4Sbq0b6RdpfsnuOSHehlceFjyik6hEkOBUun0bcl8uOta3FMZ3bxA0PJU
	 6m+XGSXvFbZSBGRswXCEiLGeKcFI/ZuuYHnhELso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-um@lists.infradead.org,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.4 738/800] um: Use HOST_DIR for mrproper
Date: Sun, 16 Jul 2023 21:49:51 +0200
Message-ID: <20230716195006.258998624@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230716_132721_810669_89F0916E 
X-CRM114-Status: GOOD (  10.93  )
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

From: Kees Cook <keescook@chromium.org>

commit a5a319ec2c2236bb96d147c16196d2f1f3799301 upstream.

When HEADER_ARCH was introduced, the MRPROPER_FILES (then MRPROPER_DIRS)
list wasn't adjusted, leaving SUBARCH as part of the path argument.
This resulted in the "mrproper" target not cleaning up arch/x86/... when
SUBARCH was specified. Since HOST_DIR is arch/$(HEADER_ARCH), use it
instead to get the correct path.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-um@lists.infradead.org
Fixes: 7bbe7204e937 ("um: merge Makefile-{i386,x86_64}")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230606222442.never.807-kees@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -149,7 +149,7 @@ export CFLAGS_vmlinux := $(LINK-y) $(LIN
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_FILES += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += $(HOST_DIR)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
