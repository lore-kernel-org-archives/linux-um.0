Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB77E7717F
	for <linux-um@archiver.kernel.org>; Tue, 17 Dec 2024 20:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/v364bvrO8lfqCXGMi7TqSOwSVU8ULaOAM7RRdJHOaE=; b=lxDhZfQ3QiRLdyDWU7y6l0bhYT
	+ty8AcHZ+vpmHsWfwvALAq+sjb5H51XgffPWd5UaWvM5Tt3NHWwi+oCDLmHsFqIHSTPyN9yVx+fdS
	NyosgxP9XsqNyJ6C0lvs2dC5dPsP0GESF75ebz9iQ4gzz5uRnk0+lxDYpM7AkMLCJzt/KNQbFq68p
	lzfaow8r9lwN/sSUtWg3fK1+glTRm4+pBNVBsqDcI+qb6UqjvCOu/slY0zDAytFOPUytLVcLwFS0H
	o6cSYYuED2HBjqhRwGLIRxVFqqmyAosRSB2r43hh5WwJxCWDDH8LDR/u+d5sBTEd4qxT8Ojy0izaM
	jr3AYAoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeCm-0000000Ekh6-3B4s;
	Tue, 17 Dec 2024 20:30:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeCk-0000000EkfK-1wc8
	for linux-um@lists.infradead.org;
	Tue, 17 Dec 2024 20:30:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=/v364bvrO8lfqCXGMi7TqSOwSVU8ULaOAM7RRdJHOaE=; t=1734467404; x=1735677004; 
	b=VUTr8j35vAk2oRVtHQoucE7Oo8rtiLLcOxgOrdKokCSA8PuYxgKtiv3yktlwSbrqzVgvWNLk7fA
	e2S4dScNfOELJSliMVlZ0FqIOCrylRXlZeQJ7j/hs+GL2bJd7C8IUTeptvYegLdgMZGB7EOgC9My0
	vZwSyJhiIFEm+Snd5h7ME1vrbWNZaZAvkQznn87UJd9h5yN4KctEMzy/w0ZXL9dK6MHzGb1z3XUYJ
	ykEXpth4wrvKtkO7kLQEglnxj/1hI7mtZuLoFq/B6jEX8J2ApMj+G6GzBysmwIDTN7TbiwUooRmYA
	RErPDdHQbdkrth8PnpxnclvZKMDD0QQR2AyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tNeCd-00000002NwX-26Tm;
	Tue, 17 Dec 2024 21:29:59 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-arch@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	briannorris@chromium.org
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/3] KASAN fix for arch_dup_task_struct (x86, um)
Date: Tue, 17 Dec 2024 21:27:42 +0100
Message-ID: <20241217202745.1402932-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_123006_539915_A687014D 
X-CRM114-Status: UNSURE (   8.24  )
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

On the x86 and um architectures struct task_struct is dynamically
sized depending on the size required to store the floating point
registers. After adding this feature to UML it sometimes triggered
KASAN errors as the memcpy in arch_dup_task_struct read past
init_task.

In my own testing, the reported KASAN error was for a read into the
redzone of the next global variable (init_sighand). Due to padding,
the reported area was already far past the size of init_task.

Note that on x86 the dynamically allocated area of struct task_struct
is quite a bit smaller and may not even exist. This might explain why
this error has not been noticed before.

This problem was reported by Brian Norris <briannorris@chromium.org>.

Benjamin

Benjamin Berg (3):
  vmlinux.lds.h: remove entry to place init_task onto init_stack
  um: avoid copying FP state from init_task
  x86: avoid copying dynamic FP state from init_task

 arch/um/kernel/process.c          | 10 +++++++++-
 arch/x86/kernel/process.c         | 10 +++++++++-
 include/asm-generic/vmlinux.lds.h |  1 -
 3 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.47.1


