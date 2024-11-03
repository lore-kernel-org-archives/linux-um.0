Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371DAD11185
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9p0reM9p0SezwLsolQoifRjlLUkYoxUMbsAieDIIaFY=; b=1bkoQWdujYMWTs1rPiUceSyj2F
	rKKzkJrEXRol57UHANU3qk7NfF8KQYVnOoKGZSClHGt6upy9zHRW/+8j2+3HQdbFZLA8VEaexVsG1
	8GW0Rvh8O5HOTpXpuYBCkmesbbTAkh9WjlatvxhuulmaPx2VFz8Y9bm53s5FzV5gUaGQFMp5M+0jJ
	dRNEh4lm611kwaaQSU6j7fDyRBxDn4i0DDkAUOubl599m2O4f33gHeN0IripQAckO0hAAKbwS6mv9
	urdxbdzFEVoJ6Qz5FAhzpiyvDrWPCnAMJNSzvxFTweNC9LoCFKKweDnhSFr1j5rfioq26mRLkMSIR
	zemwuvpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7dFz-0000000BgFg-3rjK;
	Sun, 03 Nov 2024 16:15:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7c7Y-0000000Batq-2aYQ
	for linux-um@bombadil.infradead.org;
	Sun, 03 Nov 2024 15:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9p0reM9p0SezwLsolQoifRjlLUkYoxUMbsAieDIIaFY=; b=OPV9w7QiE9Yqsn+4QLhdnPdwuk
	32f0NO+cPOyrWIb0+WceYBtjkaTwIQJ1ZebnUKA8vhZQArF5AxNXom3VDrpgdjnQx06Y1R3f3qh5+
	hnC+K7HLT2ygUF69GUCoXdefSZTfhWTlsrIrKWfA3arv+S6BAkHv02c4ZDOv9eggehLtlmy6t8TR6
	ZtAWaFOTsJI79BL1Oes4B7bX/ETJq3lSsAiu0lGF4a7GbrkdUJszvAvn2BmRgAx9FvnFNBkO5jerA
	9eSKlmJmBsTtMoQCezH86yHJZL3JS4K+vyB2RveU0GEl8SwpgJn4Q3QZUT1lt2sx/bB3djApxghQz
	Nt3hJzCA==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7c7T-0000000B8Nc-2jse
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 15:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9p0reM9p0SezwLsolQoifRjlLUkYoxUMbsAieDIIaFY=;
	t=1730646142; x=1731855742; b=jeCUhza8XL+d5uSbNJPuGMjQpsjRczTO4jsS/jDSnt88Ql0
	TA2J4DDoW3pxm+5E6OzVBASYwrKyD5FR2HCzromDsOz2F/X7usmQqcehwFnkKMggJfWnqzYH0zWw7
	OuFGkb/pAoOCHbzQUaobKfH3XAFXqjYT7iNqRhAQYacdQUy9mpf+emX1+GWWbfcs//6zQ09v/6g1S
	f/Fu4EamaF4C+6+tlp3io5dY3dL+sDc3m6KOzP6Y8XaoYZfGcVTV7Yz93wbVVqXJA6H20kw+0/WZ5
	CmzfUO+YSwPOpUhYK+8A8tVUB8ugAcrv16inEUQttG0tJAEZhY8DNJtsr2Lpppmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7c7P-0000000D5Ia-1qv5;
	Sun, 03 Nov 2024 16:02:19 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/5] um: remove file sync for stub data
Date: Sun,  3 Nov 2024 16:02:09 +0100
Message-ID: <20241103150211.1366452-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103150211.1366452-1-benjamin@sipsolutions.net>
References: <20241103150211.1366452-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_150224_034472_0FBDAB97 
X-CRM114-Status: UNSURE (   8.47  )
X-CRM114-Notice: Please train this message.
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

There is no need to sync the stub code to "disk" for the other process
to see the correct memory. Drop the fsync there and remove the helper
function.
---
 arch/um/include/shared/os.h | 1 -
 arch/um/kernel/physmem.c    | 1 -
 arch/um/os-Linux/file.c     | 6 ------
 3 files changed, 8 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index d709a24dc6fc..6c656ef096c9 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -145,7 +145,6 @@ extern int os_ioctl_generic(int fd, unsigned int cmd, unsigned long arg);
 extern int os_get_ifname(int fd, char *namebuf);
 extern int os_set_slip(int fd);
 extern int os_mode_fd(int fd, int mode);
-extern int os_fsync_file(int fd);
 
 extern int os_seek_file(int fd, unsigned long long offset);
 extern int os_open_file(const char *file, struct openflags flags, int mode);
diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index d60df3626727..a74f17b033c4 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -101,7 +101,6 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	 */
 	os_seek_file(physmem_fd, __pa(__syscall_stub_start));
 	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
-	os_fsync_file(physmem_fd);
 
 	memblock_add(__pa(start), len);
 	memblock_reserve(__pa(start), reserve);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index f1d03cf3957f..a0d01c68ce3e 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -255,12 +255,6 @@ void os_close_file(int fd)
 {
 	close(fd);
 }
-int os_fsync_file(int fd)
-{
-	if (fsync(fd) < 0)
-	    return -errno;
-	return 0;
-}
 
 int os_seek_file(int fd, unsigned long long offset)
 {
-- 
2.47.0


