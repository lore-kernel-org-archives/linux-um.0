Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165A1D11183
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=svsyuaTKyvR+W/8DDQhOIcYYtszPpS3SYRLyAKypdfs=; b=yd74u4Obu7z77muqo41ZZTUc4h
	dSRG5kC8mF4bKRSPCFU0Mi8UjajbpjFiKIiVgL1I8r7drKH22pIh2aShNRNW7kk5sjDPINed5g+cA
	84ArznzLzdxT2UtnhrDX1/MIWvnF/h4FNIiuUVUY+Q2yVxVbgJfUQ8xg2iOuFyzI3gbUYH2P1Wy9Z
	ONoFBdhEk1m3qK9ZlhLuVmoX1lMogLsaSzuZHRQFwJ3PLdCv/IBAq1rY217n2ZV+Zy8fNEcCN39Vh
	gtVp6TreOIPDTCI5BvcXQEh9S7cCTzsSFEGV1cMB7FEoQ/DbrhE0HLiwAAzi55pVGhGhKAzKNE7YW
	/cvaIH9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7dG1-0000000BgH7-37NG;
	Sun, 03 Nov 2024 16:15:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAP-0000000BbT1-1aY7
	for linux-um@bombadil.infradead.org;
	Sun, 03 Nov 2024 15:05:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=svsyuaTKyvR+W/8DDQhOIcYYtszPpS3SYRLyAKypdfs=; b=iLPvWt+rjXFNPz0bqGQTOlGQ4Z
	tEWaX5+s1wNbpMoh2t6RBV0EH6ERugi5QcN062ZTa2QwQUUGaorlE+U6LstjEgu8CPxsbA40Htlcu
	wV72t1qxgEHb3J7nMcanfy1kw2zk5OEcFHIh6D5XehlsSV8MfNmHCJW4Nn9TZrwMLga24mkKtCH5X
	HnY5+3xxexx1HDEfdh9ht5JEtMN/1OhHcIPwlOxcJ6gt6H2AWrDWJ3dVtNFc2zMrW7g1F7gU3Y4ln
	mFTftDXeaBEVE4DfLIIScdbARNi3oQcF15vqyYI8ZFKO4IkPzlwNLyk61H6xgi/LsZdKo82QehL+b
	KOl6f3/g==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7cAL-0000000B8fd-46cM
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 15:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=svsyuaTKyvR+W/8DDQhOIcYYtszPpS3SYRLyAKypdfs=;
	t=1730646321; x=1731855921; b=iSjTqSUAUhC8jodYrXzgB9aeiFbys9vwowoKhWdg7GXFDFb
	6enkYoTK9nUk8NHII1C08UwbgvP4HjtFuV+37GBAlJ0qEYeslRM4Vj1U2xoFtOjQ/6IA8JFYSST8I
	+JPflgEYKW/BBRDOEpY4Iil7W6ra1+PfsVnwnx/YsCYiePsHBiQSOrm8l+RqILXjylAMbXmI5EB87
	ALszYB5VXGYEXxvougOxHAF6727sXj46ryb5jb1WeVuvXT8Eq6bcIsOS4Ujl6SQ2/r0RJeCUeaZyG
	Vi/K5ZMzg5zX3OVt2ZuhzkIoNgPmC4yeMhJRTu3dCIekts5CigDo9iOM4Ic+o9wQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7cAK-0000000D5NG-308d;
	Sun, 03 Nov 2024 16:05:21 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 3/5] um: remove file sync for stub data
Date: Sun,  3 Nov 2024 16:05:04 +0100
Message-ID: <20241103150506.1367695-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103150506.1367695-1-benjamin@sipsolutions.net>
References: <20241103150506.1367695-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_150522_425485_079B734A 
X-CRM114-Status: UNSURE (   8.69  )
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

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
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


