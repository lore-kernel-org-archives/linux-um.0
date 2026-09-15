Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0E3C88E7F
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6e1PB4CQNzedeHCycAL44Td/hQEl2CX/iFm1Iur71xE=; b=NDzrwG6mlTjlO6YdfwLMlfVvM/
	AsGHijjlk78yi0o4RP1m5yZePFKmybIryoYDnfhGCW05uqAtXpJrzhs+tYeJX6H5kjmdXQngbhQtE
	N4ZOMHAb1MwroLCUBXtqtM3qnX6VuN+WdmzregFFNETHvOJrGFdcYp+5he5jVzwrJfSse+tJ6PGZD
	loCycxADbGubY1dxHjeWcHIXnkoWjhsb8F0cIyXVgmYATNSKCTBNJ8aEA0VpE9WuDDOcJ9cl4/Nf2
	CaSEqX1YZp2MBCjCmFXeqLv2XQRuTbpYAK3nQ+zZYFeq/7NPe0ozlFenXyKViet+BUHsasZqZXxye
	YsC2BuVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTY-00000006EMz-0CUC;
	Tue, 15 Sep 2026 11:37:24 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RT4-00000006DQ0-3PYB;
	Tue, 15 Sep 2026 11:36:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F3098602C4;
	Tue, 15 Sep 2026 11:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730581F000FF;
	Tue, 15 Sep 2026 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472213;
	bh=6e1PB4CQNzedeHCycAL44Td/hQEl2CX/iFm1Iur71xE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EXI8vF2Mi2qQql8uoPNVMR9Vjgp88ee0ybxkHsj+i1EcfZwKRf7jQAqrx5XocwZ5u
	 bXuB/2sL89kC6PNZZE/dhnoh6Kr65fNehf5/WE+WzUeV5/pclzQoq/bonRzBcg9E7+
	 NfoFoguGthxJQGC332DYQsb5ljWYLD+kEUw/Pee+5M/7Dg2ZiE3sQd1cKKv890ucDD
	 /r0vRvig6oqwgwA6dJ/z5P48MPdRVZFrQKEwVGkp3Sgwz1v5wVDwGFDqx3GUFssAgt
	 DN89k/PZlDz7rh5/WFfNs5IypEAhalKV3Vwaa2jbU2stx2+1M+fSysP8b+juFLIlZq
	 jL2puXhM2BB9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:29 +0200
Subject: [PATCH RFC POC 43/50] drm/amdgpu: stop unwinding the fence
 descriptor by hand
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-43-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ufNESbgGG96SdhrvZQNvdMYhyiyG0BhLW+Tl/xqdcT0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk/up3zrbpgwjWhoti6iGnTuBPttKJTrrTH/TR99
 na/1fRNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRM2D4n28sFLhN/8+GKPvC
 voCqx/oLuw/JH2VIEPq49KPjCV75pwz/41f1ZW/e/L95zZs5+aVvD0z0YZjxyGRy0d0flus809L
 W8wMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 03b41f803520..e5c0f7201cea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1581,7 +1581,8 @@ int amdgpu_cs_fence_to_handle_ioctl(struct drm_device *dev, void *data,
 	struct dma_fence *fence;
 	struct drm_syncobj *syncobj;
 	struct sync_file *sync_file;
-	int fd, r;
+	const struct fd_slot *fd;
+	int r;
 
 	fence = amdgpu_cs_get_fence(adev, filp, &info->in.fence);
 	if (IS_ERR(fence))
@@ -1610,21 +1611,18 @@ int amdgpu_cs_fence_to_handle_ioctl(struct drm_device *dev, void *data,
 		return r;
 
 	case AMDGPU_FENCE_TO_HANDLE_GET_SYNC_FILE_FD:
-		fd = get_unused_fd_flags(O_CLOEXEC);
-		if (fd < 0) {
+		fd = fd_prepare(O_CLOEXEC);
+		if (IS_ERR(fd)) {
 			dma_fence_put(fence);
-			return fd;
+			return PTR_ERR(fd);
 		}
 
 		sync_file = sync_file_create(fence);
 		dma_fence_put(fence);
-		if (!sync_file) {
-			put_unused_fd(fd);
+		if (!sync_file)
 			return -ENOMEM;
-		}
 
-		fd_install(fd, sync_file->file);
-		info->out.handle = fd;
+		info->out.handle = fd_stage(fd, sync_file->file);
 		return 0;
 
 	default:

-- 
2.53.0


