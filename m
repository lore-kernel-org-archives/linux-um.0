Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454B4C77B75
	for <linux-um@archiver.kernel.org>; Sat,  6 May 2023 06:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:From:Cc:To
	:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VEgqXA6rZ2AOg6lrYYcCPP466wm5r0OYH17bBT3L5Zg=; b=QjqqnwTUbQHV5e
	5Ueu8vsquKM3MCzVZX0YD+NalSTQdKT6zeTy/1Ya1EBdtx3nkC7arVmYnMQ/CVn3CkBr5xScw2AJf
	HLPfQ5nrwzHp1uOAGb1a2LQhOeq+j3qxQ87ZWfQH9f1PqyCB0dMhZ+aPwe5Ckd6CJIqKTbkT2zyw9
	aCuUuLK+C584i+VV5zAsmSOM7fIP9knCUzJJ8wXoiBUCJ3/RSt/7m9yfhZ59o+AHckn+x/lp9sG+1
	ioTg2QsmLk1m6ZhoEx68JCIQwKzBgakCdOKlkoO8mQgn00XkcMQULXida8AIRpVjK6Oj6ZR82M9iy
	4zA3L/RCsDy89vsng6WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvBQ3-00Cg32-21;
	Sat, 06 May 2023 06:29:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pvBQ0-00Cg1q-1F
	for linux-um@lists.infradead.org;
	Sat, 06 May 2023 06:29:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B7E8D615B0;
	Sat,  6 May 2023 06:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246C6C433EF;
	Sat,  6 May 2023 06:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1683354559;
	bh=n90nORhuy9Lg0Rj6CHFx2KACPE0f+hAYyjiVvRbQpis=;
	h=Subject:To:Cc:From:Date:From;
	b=Vq6uDUF3HeAXRV+VlV5NxG+ZkKVzn6Q/+jwTkJRs1DH8GcYPtKZAZYBak726KG/Fx
	 EpQzIebENQCz95MJjecdQcsIBlnnPK5nkcNyJhQdyOpE4NmFTRoqzsgbqjUENpyk9w
	 pncJmSW7em1nN7ByKi1xGzqK7ExOHx/+3IBUVQZk=
Subject: Patch "IMA: allow/fix UML builds" has been added to the 6.2-stable tree
To: anton.ivanov@cambridgegreys.com,festevam@gmail.com,gregkh@linuxfoundation.org,johannes@sipsolutions.net,linux-um@lists.infradead.org,rdunlap@infradead.org,richard@nod.at,zohar@linux.ibm.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 06 May 2023 11:18:28 +0900
Message-ID: <2023050627-tinwork-finer-3bff@gregkh>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_232920_509415_55942DFA 
X-CRM114-Status: GOOD (  15.67  )
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

    IMA: allow/fix UML builds

to the 6.2-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     ima-allow-fix-uml-builds.patch
and it can be found in the queue-6.2 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 644f17412f5acf01a19af9d04a921937a2bc86c6 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 23 Feb 2023 19:27:03 -0800
Subject: IMA: allow/fix UML builds

From: Randy Dunlap <rdunlap@infradead.org>

commit 644f17412f5acf01a19af9d04a921937a2bc86c6 upstream.

UML supports HAS_IOMEM since 0bbadafdc49d (um: allow disabling
NO_IOMEM).

Current IMA build on UML fails on allmodconfig (with TCG_TPM=m):

ld: security/integrity/ima/ima_queue.o: in function `ima_add_template_entry':
ima_queue.c:(.text+0x2d9): undefined reference to `tpm_pcr_extend'
ld: security/integrity/ima/ima_init.o: in function `ima_init':
ima_init.c:(.init.text+0x43f): undefined reference to `tpm_default_chip'
ld: security/integrity/ima/ima_crypto.o: in function `ima_calc_boot_aggregate_tfm':
ima_crypto.c:(.text+0x1044): undefined reference to `tpm_pcr_read'
ld: ima_crypto.c:(.text+0x10d8): undefined reference to `tpm_pcr_read'

Modify the IMA Kconfig entry so that it selects TCG_TPM if HAS_IOMEM
is set, regardless of the UML Kconfig setting.
This updates TCG_TPM from =m to =y and fixes the linker errors.

Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies")
Cc: Stable <stable@vger.kernel.org> # v5.14+
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/integrity/ima/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -8,7 +8,7 @@ config IMA
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select CRYPTO_HASH_INFO
-	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TPM if HAS_IOMEM
 	select TCG_TIS if TCG_TPM && X86
 	select TCG_CRB if TCG_TPM && ACPI
 	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES


Patches currently in stable-queue which might be from rdunlap@infradead.org are

queue-6.2/ima-allow-fix-uml-builds.patch

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
