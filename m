Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB33EB64DD
	for <linux-um@archiver.kernel.org>; Sun, 16 Jul 2023 09:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:Cc:To
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=aVWFPUxtIyL3bdERXrZ8kdRNl5FCw6lnzAv2Hfu+mtU=; b=1XNix4VU0U1Uq4
	XKmVRLPkUoJdGqN6swa/o370hPNDoHaE/t3Q512rZElyqiY8r1yrB3z2/I+Y2XHU9urbB5AuDoQv+
	WFpdjojjxocbIpbZn++Vf0m4C4oaxjrQCNI0GOy4tV4hp9DRgp3sXRAIJdrP6jlPjvp/DkaG4CQkx
	ez8bpJAutgR0fHPtPZyF6UTlgXW1EpEzDRfsZvr5NKsgYEcJXqWipkv3hJHVUqhI6ia9nSyCoRXQs
	E2eSAcqb9q4mE9UjQ3JZdO1rGnoTu/YeX9bFqn/h0u9yHnGlf8dNYNJlXx5Hl2WrjXi83ywOGNDjq
	oQM6Clo7cNy2W83OMgvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qKy2J-00ARKp-00;
	Sun, 16 Jul 2023 09:27:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qKy2G-00ARKA-1m
	for linux-um@lists.infradead.org;
	Sun, 16 Jul 2023 09:27:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E85B960C78;
	Sun, 16 Jul 2023 09:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0325EC433C8;
	Sun, 16 Jul 2023 09:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689499642;
	bh=Tn5My/wPENlSiEVLc1DuBZeDkNCV+8c9oOPtUudIPkQ=;
	h=Subject:To:Cc:From:Date:From;
	b=qh8htDjGbBR6JJ/6ZJhFrI5eMThlbwADKjNmxgnINogVWRMuhzyhnazmLrxJcIZEu
	 9Jvr8sruqI31tJdaUqlXE/XpKh1uq8SrMRruX8xtJJvrjbl23ZwVH+lxigChhHN1RO
	 JXDH66RQ1DA+miIZh4aAaoV7sZuz4HEPs4UIYcyw=
Subject: Patch "um: Use HOST_DIR for mrproper" has been added to the 5.15-stable tree
To: anton.ivanov@cambridgegreys.com,azeemshaikh38@gmail.com,gregkh@linuxfoundation.org,johannes@sipsolutions.net,keescook@chromium.org,linux-um@lists.infradead.org,richard@nod.at
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Jul 2023 11:26:40 +0200
Message-ID: <2023071639-reanalyze-overcoat-4a23@gregkh>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230716_022724_704069_A90BB983 
X-CRM114-Status: GOOD (  14.74  )
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


This is a note to let you know that I've just added the patch titled

    um: Use HOST_DIR for mrproper

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     um-use-host_dir-for-mrproper.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From a5a319ec2c2236bb96d147c16196d2f1f3799301 Mon Sep 17 00:00:00 2001
From: Kees Cook <keescook@chromium.org>
Date: Tue, 6 Jun 2023 15:24:45 -0700
Subject: um: Use HOST_DIR for mrproper

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
@@ -148,7 +148,7 @@ export LDFLAGS_vmlinux := $(LDFLAGS_EXEC
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_FILES += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += $(HOST_DIR)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \


Patches currently in stable-queue which might be from keescook@chromium.org are

queue-5.15/um-use-host_dir-for-mrproper.patch
queue-5.15/crypto-marvell-cesa-fix-type-mismatch-warning.patch
queue-5.15/pstore-ram-add-check-for-kstrdup.patch
queue-5.15/locking-atomic-arm-fix-sync-ops.patch
queue-5.15/arm-9303-1-kprobes-avoid-missing-declaration-warning.patch
queue-5.15/kbuild-disable-gcov-for-.mod.o.patch
queue-5.15/autofs-use-flexible-array-in-ioctl-structure.patch
queue-5.15/test_firmware-return-enomem-instead-of-enospc-on-fai.patch

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
