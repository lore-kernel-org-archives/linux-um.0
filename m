Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1644FC982C3
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 11:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fPUeEhZalZFbuqvBU8/iDG2tqjgIH/ueKLGrOGx0E/Q=; b=mnJMJtJv0NyCeI9yVSuyDCvKF/
	KOFGBoUo/OgDpsvgzMIrMHvrGJGEMwpBMitWzOQhWrJpF9x+GQxNVsC9XZ/1SxBuS/yx+MIh/xbq4
	WI8w8+BmbdwTJKmmGewrQHA9sOYrZ4nsIRyp3DOAgnSmW3zVM2a7UD6iSUdhDYJU3HK3yI/JSx4fU
	qElcFxIxf3SXQAh+sl7FscZb9TSzb6+Vc8sb3wUiuovZ45KMif9p5OxLhiZKbTX7curBWTfJ4JSf1
	5SfxbqxzIxKWBeEgGKtyITTaSQT3c4MoNya21zKx85sN38vmnvCqxp255ZjNlM9F/YelmhMkmE0gA
	Jpni/Fig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RQE-00000006A32-2oaN;
	Tue, 15 Sep 2026 11:33:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RQ2-000000069lJ-3Uqb;
	Tue, 15 Sep 2026 11:33:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 88ED742A92;
	Tue, 15 Sep 2026 11:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EB01F00898;
	Tue, 15 Sep 2026 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472026;
	bh=fPUeEhZalZFbuqvBU8/iDG2tqjgIH/ueKLGrOGx0E/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Nmpj4NaFXMtUCUBJkK324vi22fpzvX6uomFULBZJOjhgDQCroZWI/8lb8hRAJVCHh
	 9EhYq/igSRVSJd0Z69cCAreFakLrT8v7g5ED2rGJFufV7eihjNzGDapElAJqkyWjpl
	 lBXB4AtsKeIiuD1UD4coI3pcXNoLmTr78UlIqOkuglt9Hw0oChJkwnEGg4w0f6UJ0f
	 E3lrRN0G+U0+0MXEDUccPLURv/tGCWrEtzl5wBa6tk79GG6qHRxEjmf3jJK1LMmPo3
	 /VFHB2tZrT068p2qgHGbLHusKwE8Tye3wqbBTFb6QOLjp++ERuzcM9sRPxtZnWLn1E
	 KgqcMBfnsrMfA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:05 +0200
Subject: [PATCH RFC POC 19/50] file: require the syscall exit hook from
 every architecture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-19-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kO5/kQT0XZnIdRnIvngddyYIzT4ZNU9mDakuELDqlrQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kmt7K/PWBxqv33Jx9xZ93feiJvYXvn0wyGRJfor4
 xvDgz5O7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjImo8M/0t6Hp5cOHfxxr5q
 5ZTEWby+CmuzN2gtu/o25VNw3Kl5VQ8Z/ns2bzkbtn3/k1lfb3I0OE2bn/HePMr9P8+ZRZUPSuV
 nr+YCAA==
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

Every architecture now either uses the generic entry code or provides
TIF_FD_SLOTS. The fallback that deferred without ever committing
can go. Make it a build error instead. A new architecture can't grow
fd_prepare() callers without the syscall exit hook.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 6fa481d63dcf..2b041b45f225 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -652,9 +652,7 @@ static void fd_release(unsigned int fd)
 #define fd_slots_set_work()	set_thread_flag(TIF_FD_SLOTS)
 #define fd_slots_clear_work()	clear_thread_flag(TIF_FD_SLOTS)
 #else
-/* Nothing commits until the architecture provides the flag. */
-#define fd_slots_set_work()	do { } while (0)
-#define fd_slots_clear_work()	do { } while (0)
+#error "the syscall exit path must commit prepared file descriptors"
 #endif
 
 static struct fd_slot *fd_slot(struct fd_slots *slots, unsigned int idx)

-- 
2.53.0


