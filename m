Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2238C88E75
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vNAyMtfXPrvlDMBwu/W4OdplmCeF+Bx8YXtsYm6LQAM=; b=uyf91bDLM42xlhP5GrGOfoH9Kr
	KyT7A95mcKx/QX6VFD1bbGuOB70n0evF83Kxzrbi9HJy01TEucgGL2XsbTB6OHesFlSa0urY9CkrQ
	PQVNO4dvUYUtV3wui3+wfm1XB6Gefdm2AMKTcjKxxfDxGK+tTL+sRmD9b7zfDKie0s2ijLzs+m4bd
	Hm3nT+MLz4Ihb1nH51KkyQso/w7SPbMuLcjlVU7sTOrRGHhIAkgnvkSjwoJ2S+LFYzKOVq7ydFu7k
	64K9oMQo8hVb1edVUsdT87yUtVd32N+76Z7YkezgI3QPsgiJoV/nqmK8mEpc+tFQNvRbUmnW+7w9C
	b51JO5pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTf-00000006Ea5-20Rz;
	Tue, 15 Sep 2026 11:37:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTC-00000006DZu-2AcD;
	Tue, 15 Sep 2026 11:37:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EE8EE600D1;
	Tue, 15 Sep 2026 11:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C811F00893;
	Tue, 15 Sep 2026 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472221;
	bh=vNAyMtfXPrvlDMBwu/W4OdplmCeF+Bx8YXtsYm6LQAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hJcbb+ve+d0nQ+lyOtzlz+UYbr/gC7seiGRVtM9hr3qhRy0SP4rtTxf+61fJV6HZZ
	 LW8RS1sK7opxRgNB4vdONobXBpXD+8GA3HqD2ByRAw16fqkTwu9j8tnAJddGmb7PLP
	 uAm06SirtIHb9CCSMDYGUJRVhcFsQ8v4/IdM2Y5J83ZMffAgWUfRu60wVT+I3rLxob
	 Mi3XVumaSCaqqvXwhpB/3c9gXctwqH2urcLOWEF/YPHWIZ1DoeXtnc71XLjr6mUjdh
	 GfPZGsugN7/T7eQDGipHgpsCZ2aT0QgMaxK1TaXJWBPrJ+seh1rFblIFb7+Y//Ecs/
	 SAX3DixdA32jQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:30 +0200
Subject: [PATCH RFC POC 44/50] drm/etnaviv: install the out-fence
 descriptor when the ioctl returns
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-44-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WG8U461FL48WyesDf7+OQN8njA3nXiC/HvwYW8sZuPs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Km/q3LcYfWGcx8fpJwoLZDaNd0oa+00ldguK1cb6
 asTWTUPdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEn5Hhf8CmHl/lhwWpt/aY
 /5Pr3xCoq1J+5FT33kNKDsks7ZtPZjMy7JT6oyr93P+B4L/VWRcU9j8zmrNg9ut3r3TNptlZWIi
 5MgAA
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
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 1a77a09b3377..174f1d66d9ad 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -420,7 +420,7 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct etnaviv_gpu *gpu;
 	struct sync_file *sync_file = NULL;
 	struct ww_acquire_ctx ticket;
-	int out_fence_fd = -1;
+	const struct fd_slot *out_fence_fd = NULL;
 	struct pid *pid = get_pid(task_pid(current));
 	void *stream;
 	int ret;
@@ -504,9 +504,9 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	}
 
 	if (args->flags & ETNA_SUBMIT_FENCE_FD_OUT) {
-		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
-		if (out_fence_fd < 0) {
-			ret = out_fence_fd;
+		out_fence_fd = fd_prepare(O_CLOEXEC);
+		if (IS_ERR(out_fence_fd)) {
+			ret = PTR_ERR(out_fence_fd);
 			goto err_submit_cmds;
 		}
 	}
@@ -607,10 +607,10 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 			 */
 			goto err_submit_put;
 		}
-		fd_install(out_fence_fd, sync_file->file);
+		fd_stage(out_fence_fd, sync_file->file);
 	}
 
-	args->fence_fd = out_fence_fd;
+	args->fence_fd = out_fence_fd ? fd_prepare_fd(out_fence_fd) : -1;
 	args->fence = submit->out_fence_id;
 
 err_submit_job:
@@ -623,8 +623,6 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, void *data,
 	ww_acquire_fini(&ticket);
 
 err_submit_cmds:
-	if (ret && (out_fence_fd >= 0))
-		put_unused_fd(out_fence_fd);
 	kvfree(stream);
 	kvfree(bos);
 	kvfree(relocs);

-- 
2.53.0


