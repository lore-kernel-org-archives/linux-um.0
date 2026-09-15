Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C895CC88E75
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dR2AT7slAh5QiQGKBciNLhR24TAk5bJ3ys4Ah5Rt7mE=; b=HIdp8qg586zsGKC2iVXHTQHLya
	DeXk205qXDBULnB2sc4+qQhiosInaJtxYroYSk/Sjme7VKDnaXCXtmNzY3J4jJTYz1J5LPtEfLl0r
	XF1hQJmBVD3aGp2qJ7d7k/QbLnWE65xd0YP0XnbcqHUfTHo2Em1oYXZkh6MGfpUq0J4r1ClsWPnlu
	yYG0XaYgRBk4OPm+Qf8pt8uMhT2RgWRI8lPiQSKion8KHrP5qcWt0EXTcgLWkuriMe+GY3yDNed/G
	5qqC3hCMhTpnMT4q4CgboeXm/M1RuwKOke7oGyYSJUqjG859Qv9BQMnoB6QsvUCfUa0Llu2wOwMIQ
	xQwh7fBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RTS-00000006E9D-3HsS;
	Tue, 15 Sep 2026 11:37:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RSo-00000006D8K-3sk6;
	Tue, 15 Sep 2026 11:36:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 459BC602D0;
	Tue, 15 Sep 2026 11:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948881F00893;
	Tue, 15 Sep 2026 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472198;
	bh=dR2AT7slAh5QiQGKBciNLhR24TAk5bJ3ys4Ah5Rt7mE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=keM2MELZ8tMeEj63s6rILS1a6ikUND0cm/hSBjQN5i9zsMHRwumL2LpgndOJca1Aa
	 97kIpfNmItf2JE76ybod5HhCCbaR3uSYEM810jrmgilIii5FRWRh1O86tNdM0FYWJl
	 38f1UHzSPEd+hj/T0Nlt8QEoyRs4wb5r4JVdV9i/rSIOmEYhsfaqAD31KqLx/f0h3O
	 ACHfbLbzGXb+++iV7WaxfM+tTIGP+WsUWGxYSjDxuYEbOqm0MVVuZjc4buiK4jUw7O
	 C9LHTBiZSEultvzvuQBhaDEJQMVPhyftCJPppnofTMl7IPUPEYHfgCv4gmlMrEOmjT
	 oPjncB8aAwY0Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:27 +0200
Subject: [PATCH RFC POC 41/50] KVM: guest_memfd: stop putting the
 descriptor back on failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-41-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KLCbLLJNzFhK9KnJoDv8kDUlKXi4pqPjbkN6aCwr8bo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk/tfzHImu/Gp6ZRSssN5fyinw4ruUhZCIkyWFT3
 bH7k9a5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8sWZk6GKcxbHPfdfrbYrn
 f0Zr1u290KLF8etT65HPSeyxa5JK9zH8jwg7xHPKv6v/9/8HHp3fHOUXznI3MuD7/nrNS8a/OUU
 arAA=
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
 virt/kvm/guest_memfd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 625e62e1a031..e0d1cb869342 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -526,17 +526,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	struct gmem_file *f;
 	struct inode *inode;
 	struct file *file;
-	int fd, err;
+	const struct fd_slot *fd;
+	int err;
 
-	fd = get_unused_fd_flags(0);
-	if (fd < 0)
-		return fd;
+	fd = fd_prepare(0);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	f = kzalloc_obj(*f);
-	if (!f) {
-		err = -ENOMEM;
-		goto err_fd;
-	}
+	if (!f)
+		return -ENOMEM;
 
 	/* __fput() will take care of fops_put(). */
 	if (!fops_get(&kvm_gmem_fops)) {
@@ -575,8 +574,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	xa_init(&f->bindings);
 	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
 
-	fd_install(fd, file);
-	return fd;
+	return fd_stage(fd, file);
 
 err_inode:
 	iput(inode);
@@ -584,8 +582,6 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	fops_put(&kvm_gmem_fops);
 err_gmem:
 	kfree(f);
-err_fd:
-	put_unused_fd(fd);
 	return err;
 }
 

-- 
2.53.0


