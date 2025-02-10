Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B7FC0219B
	for <linux-um@archiver.kernel.org>; Mon, 10 Feb 2025 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NVz7Ol6ED584gOOhj940DsJIYL+Fv091Y0HN+r3hOp8=; b=sg+mJyCNcz0uf/lNJ3oTmSKa8c
	n8MRuSsbId6cvNw6V5grhA3DQQgBVpWxRO87h/ZhXe3Rdz80Xvz/G0FxsG78lZeVpRBKNXnGedYsC
	VTwCnuudQDtc4Q1Ek74KYcG+i+SzwPbZA0j+7APr7bs4fy/bc0SRk6qUpN7wkTizeM/u9BGa9AoJl
	310TdTmATou7Kw/m0sC7kRROq3emW9zjkJ1bX3ciFxpT4fSGmEj9rw2r2VFTh0rab+9iVc1on1Eka
	6T0LVsYqUWB0EMQuXsZAHAPhPqkZ1wqI+vBcDSmbGxiM/NlEovce/Ss63BFTrlm1DthJpUyhK28zw
	fdkSy9nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thWMe-00000000Ri0-2rbb;
	Mon, 10 Feb 2025 16:10:28 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thWLw-00000000RZz-1CBP
	for linux-um@lists.infradead.org;
	Mon, 10 Feb 2025 16:09:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=NVz7Ol6ED584gOOhj940DsJIYL+Fv091Y0HN+r3hOp8=; t=1739203782; x=1740413382; 
	b=dC9KXsIWsUlP+D+EDXMwYh848x11uBXHuaYXlPwnsOEWiEmTuF5vxkBKjfZOFaVxptawjmZ+Ovt
	pmGHXYYlyIrynR5KuO+5nPMKqxgRAmrVyQPnkYaJHxIeq2/tHl6iklm62uNpqEusZhB+JSspSmFyb
	AFAqT50UxOz51b5yqA+rRFTUT/VzpyZqV3EFfmP07p3ZPMdFY8EVbSB1IwbQb7nCuIj+3WOlMHEI2
	yz7M12asaYp+SXuY7HDEqQzD4w8N+PvijL9m9jYmssXe5BZzUwaJIOG0C7ZPusVGfREr9TDVuqQma
	RqTwu3Mm1U2UGPqGV3WSXjO7aG0LEEkB5Llw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1thWLq-00000009rY9-474K;
	Mon, 10 Feb 2025 17:09:39 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/2] Remove incorrect host mincore call and add rodata handling
Date: Mon, 10 Feb 2025 17:09:24 +0100
Message-ID: <20250210160926.420133-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_080944_326651_68A7DD31 
X-CRM114-Status: GOOD (  11.87  )
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

Hi,

using mincore() to check whether a page is owned by UML is not correct
as it returns whether the page is resident in memory and not whether
something has been mapped at the address. This means that UML could get
spurious failures in *_nofault functions like copy_from_kernel_nofault).

If this happens, it can create hard to debug issues. For us the problem
showed up because hostfs was randomly throwing ENOENT errors when
loading libraries (including ld.so). This can be traced back to
dentry_path_raw failing as it uses an optimization that requires the
use of copy_from_kernel_nofault internally (see the documentation of
prepend_name and prepend_copy).

Pull in the existing RODATA patch from Johannes (with light editing) and
then remove the call to mincore() as it is incorrect.

Benjamin

Benjamin Berg (1):
  um: remove copy_from_kernel_nofault_allowed

Johannes Berg (1):
  um: mark rodata read-only and implement _nofault accesses

 arch/um/Kconfig                          |  1 +
 arch/um/include/asm/processor-generic.h  |  2 +
 arch/um/include/asm/uaccess.h            | 20 +++++++---
 arch/um/include/shared/arch.h            |  2 +
 arch/um/include/shared/as-layout.h       |  2 +-
 arch/um/include/shared/irq_user.h        |  3 +-
 arch/um/include/shared/kern_util.h       | 12 ++++--
 arch/um/include/shared/os.h              |  1 -
 arch/um/kernel/Makefile                  |  2 +-
 arch/um/kernel/irq.c                     |  3 +-
 arch/um/kernel/maccess.c                 | 19 ---------
 arch/um/kernel/mem.c                     | 10 +++++
 arch/um/kernel/trap.c                    | 28 ++++++++++---
 arch/um/os-Linux/process.c               | 51 ------------------------
 arch/um/os-Linux/signal.c                |  4 +-
 arch/um/os-Linux/skas/process.c          |  8 ++--
 arch/x86/um/os-Linux/mcontext.c          | 12 ++++++
 arch/x86/um/shared/sysdep/faultinfo_32.h | 12 ++++++
 arch/x86/um/shared/sysdep/faultinfo_64.h | 12 ++++++
 19 files changed, 109 insertions(+), 95 deletions(-)
 delete mode 100644 arch/um/kernel/maccess.c

-- 
2.48.1


