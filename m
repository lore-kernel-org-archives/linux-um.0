Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7232CC531FC
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T8AGe6rDXg/ldNC57i46EQffqrXduzkulXxSMWcod/M=; b=ZNQQK/OFinrfBp7UWaTjmnA5QR
	aNta1UgKozN8QEHc5ZafVUgtM2RtMzYu2wsWPYM8M6MoRF9zi00vf9c8jdjfBGDKyRMF/kOgsJtnq
	t6bAcBWgxY0kMknEI0HS3MPoiqRi/ToyZDbhtOVq6kryraeG97XhPVxbsx92JrfLs/TL4QN/0jchF
	sxNj+wYfE6S/Iocu/bE6u1bcJB5u3UIDP0V4Bv6xSOMyz+b0UUVT2bp7Nmdf/EgmtyKiEXCx9tHRs
	UyYcwQDnPJDDyPEQLrAHjGaooAZPKBxxWNNumFAxkyXH6K8RXY2unMqyVjQtvmBlNUQ9YTXf/V8Sk
	Oq79DhSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe9-0000000HGqF-0KJG;
	Fri, 24 Jul 2026 21:41:33 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.144.205])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe1-0000000HGhF-0Fs0
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 21:41:29 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8403DC0000FC;
	Fri, 24 Jul 2026 14:41:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8403DC0000FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929283;
	bh=a0Cfg7X+g3S2j3WgmrnppIxwpz2k3rDILWehus98x28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RF0dO4fxr+fXUcerTBF4BDXI8aar+8stV5nFdcqIKg5cJqwA3wvps+YdMx+XQv74x
	 Z1JTdJw2EXCfq7Sp20J8hQlWwLzttFUpiPsFcp+BfGhXnD007X+1FiCI4SazOx6an/
	 tcaFJRy70sO2JuWSkcM0aU1kPKWdSg7c2EiILzTs=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 14C66ACE;
	Fri, 24 Jul 2026 14:41:23 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.12 9/9] um: Preserve errno within signal handler
Date: Fri, 24 Jul 2026 14:41:19 -0700
Message-Id: <20260724214119.1066665-10-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_144125_195353_F63F9C72 
X-CRM114-Status: GOOD (  10.91  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

commit f68b2d5a907b53eed99cf2efcaaae116df73c298 upstream

We rely on errno to determine whether a syscall has failed, so we
need to ensure that accessing errno is async-signal-safe. Currently,
we preserve the errno in sig_handler_common(), but it doesn't cover
every possible case. Let's do it in hard_handler() instead, which
is the signal handler we actually register.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20260106001228.1531146-2-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[florian: hard_handler() in 6.12 retains the to_irq_stack/from_irq_stack
loop from before the upstream SMP refactoring; errno save/restore is wrapped
around that loop rather than replacing sig_handler_common's existing save/restore]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/os-Linux/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index b11ed66c8bb0..94abc9e3ec7e 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -190,6 +190,7 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 {
 	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
+	int save_errno = errno;
 	unsigned long pending = 1UL << sig;
 
 	do {
@@ -227,6 +228,8 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 		if (!nested)
 			pending = from_irq_stack(nested);
 	} while (pending);
+
+	errno = save_errno;
 }
 
 void set_handler(int sig)
-- 
2.34.1


