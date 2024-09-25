Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FE1CCF9EE
	for <linux-um@archiver.kernel.org>; Wed, 25 Sep 2024 20:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u49n3vt1xmXpdN+H3Ve037tCjCuO47RCORmnokub20Q=; b=Dl0jEjdzbH/nQVdfh3uTgRupyZ
	KeZndJYJYrQ2waYN+Kw/iq4mFST3oHWTz3b1gNNQb/XEyyXpGhdG2rA3l8XkSc8Suxc+H/WeJz/FJ
	wAenGmo9hcXMceAWWrLvMHtu3hAoNqAmrxX7uO5d+AZV4EvOimEQr6Cpd0DWyhVu6zkmXJrFQAD9z
	FffZEVKoojqAU/+8FP8rkuY4DHo09CO6tyojqq4ZdAYAuKophqQjkfwhReRNpbwguOESqYZd7xpm1
	A+BM9ycE6KoovgbHKqXXBG1FI1FA2cBTPUq+ZuPulYiZH9JNUpAVi6swMSVXfF0D5IZIFU2H2QIfw
	FXx8BAzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stYgv-00000006Uzx-1c5t;
	Wed, 25 Sep 2024 20:32:53 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stYgt-00000006Uyi-0BGM
	for linux-um@lists.infradead.org;
	Wed, 25 Sep 2024 20:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=u49n3vt1xmXpdN+H3Ve037tCjCuO47RCORmnokub20Q=;
	t=1727296369; x=1728505969; b=vLA/j9WLKqfBguDXaJUCP0Qf/xGkmpRkZqZ8QJL8zPSvHe7
	x1vpnZTjp5+6+NBPabGodDR65jDfBlPzEpFMK5Vpo9cb/c0NJMLb6UMAw/7Ycl7cOO1edT3SElllQ
	p2/fibEqQXu859kzgi0DW0NY8iSTNbWlOkwN4gPQoCkJS03sQQS3nQIMIkmBwjwy3RipZLO4r1uHT
	zXVX/vMd3uOpz8xONR533wcQsbYPPNQQUtccpNcC0/qUxTe+t67J+H9Pv/cIT71OL0trst9UAhu0x
	TAYHc81f4bWARtMdhZkAJreoANJ9nxtPvdToZ8jPiZ/RJ6oazHBy23STUl+erBjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1stYgo-00000001A19-1FAd;
	Wed, 25 Sep 2024 22:32:46 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH 1/9] um: Store full CSGSFS and SS register from mcontext
Date: Wed, 25 Sep 2024 22:32:24 +0200
Message-ID: <20240925203232.565086-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925203232.565086-1-benjamin@sipsolutions.net>
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_133251_102543_6186B98F 
X-CRM114-Status: GOOD (  10.19  )
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

Doing this allows using registers as retrieved from an mcontext to be
pushed to a process using PTRACE_SETREGS.

It is not entirely clear to me why CSGSFS was masked. Doing so creates
issues when using the mcontext as process state in seccomp and simply
copying the register appears to work perfectly fine for ptrace.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/x86/um/os-Linux/mcontext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index e80ab7d28117..1b0d95328b2c 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -27,7 +27,6 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	COPY(RIP);
 	COPY2(EFLAGS, EFL);
 	COPY2(CS, CSGSFS);
-	regs->gp[CS / sizeof(unsigned long)] &= 0xffff;
-	regs->gp[CS / sizeof(unsigned long)] |= 3;
+	regs->gp[SS / sizeof(unsigned long)] = mc->gregs[REG_CSGSFS] >> 48;
 #endif
 }
-- 
2.46.1


