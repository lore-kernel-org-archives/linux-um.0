Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD52AD690F1
	for <linux-um@archiver.kernel.org>; Thu, 28 Nov 2024 08:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hKhVlEWW5yxomHpxWri3aYSjhDtHnogmZ1Sltb2ZRNU=; b=OoIUqJDl9FSNqXFzdLSRa96eqe
	ydNhO9BGEGaou72TREGRPALAx1uzD845iiN70+Ui5WRC2sIP4iKyi53J4BXMujbjLl6Lurp6ar6CA
	K17YmNk1ircXTgelV4GPJ2ZNesLik0xagJQOV39NKRQVH3QzAyAakaNy88n5HmzcR/wZTJADzdFX7
	PsxUDJItZ6UNQ+BWx1t+KiFtZpBe4K7Ll1lnH642DM6BMx4zqRKe+py1c/S++yf0MMV7eVxpfv3BI
	dEuLt+9j1tGni4zBJKUHRozCFsXzuj2FcXigtt6sCYRca2Ts6mjEwO+gpdd6msOOxTr6vHpVXbffY
	WLBp31MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZxF-0000000F0v6-2Kbd;
	Thu, 28 Nov 2024 08:32:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwW-0000000F0pn-2fav
	for linux-um@bombadil.infradead.org;
	Thu, 28 Nov 2024 08:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hKhVlEWW5yxomHpxWri3aYSjhDtHnogmZ1Sltb2ZRNU=; b=h1KWL8jESMV0wEks2FZc6fajtD
	XhqW4dmHLZ8+yX3g4kSosUVE4BEfrAfTviuwpXGC5l1LgIZXtQTZWIoS/0V1/owVPUJ95suJgICBL
	kjlvY/Dpkab3Tflh99GfYG8tu5KBpN2HocqXPsHlPsnBpH7QpxNxLfE9/o0//e5+GcLcDmd/Oqaw+
	6GOXk2BndsFE0Zz8r8hjSKVun3FSHDqxHotVKkuB8lafROvv6JuMV4xPh3DMPBhqNQ4osImndzcHE
	OTGCnI9Kb+0he2vQ3hmx1LECPWg3HQFrbeP5Ea6AdmvFhOTRw+7Pqm+XoDnBH4b1IHy99DOQGJN0d
	BBzxU+tw==;
Received: from out0-197.mail.aliyun.com ([140.205.0.197])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGZwQ-00000001Yhq-09jt
	for linux-um@lists.infradead.org;
	Thu, 28 Nov 2024 08:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1732782709; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hKhVlEWW5yxomHpxWri3aYSjhDtHnogmZ1Sltb2ZRNU=;
	b=01y+cw2Y0umCraZuDJOeQXhEsjuwDUeHNK4UgNX7hnplrrxn1VVdgrRxx4MIf0cWV/A17m6yfDS0uQqqLi0jpVyWNKPa6EjHudB9XM/4Yx3FcXEKt9S2tu8TIoomOr/Uba8LdpIrV4LVYIrrXgiSuU7awgrvyWYE6VW+TYm53GQ=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.aP07WWu_1732782709 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 16:31:49 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 9/9] um: Remove unused user_context function
Date: Thu, 28 Nov 2024 16:31:37 +0800
Message-Id: <20241128083137.2219830-10-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
References: <20241128083137.2219830-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_083202_872837_3472A018 
X-CRM114-Status: UNSURE (   5.91  )
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

It's no longer used since commit 6aa802ce6acc ("uml: throw out
CHOOSE_MODE").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/process.c           | 8 --------
 arch/x86/um/shared/sysdep/ptrace.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 30bdc0a87dc8..e5a2d4d897e0 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -213,14 +213,6 @@ int __uml_cant_sleep(void) {
 	/* Is in_interrupt() really needed? */
 }
 
-int user_context(unsigned long sp)
-{
-	unsigned long stack;
-
-	stack = sp & (PAGE_MASK << CONFIG_KERNEL_STACK_ORDER);
-	return stack != (unsigned long) current_thread_info();
-}
-
 extern exitcall_t __uml_exitcall_begin, __uml_exitcall_end;
 
 void do_uml_exitcalls(void)
diff --git a/arch/x86/um/shared/sysdep/ptrace.h b/arch/x86/um/shared/sysdep/ptrace.h
index 2dd4ca6713f8..8f7476ff6e95 100644
--- a/arch/x86/um/shared/sysdep/ptrace.h
+++ b/arch/x86/um/shared/sysdep/ptrace.h
@@ -74,8 +74,6 @@ struct uml_pt_regs {
 #define UPT_FAULTINFO(r) (&(r)->faultinfo)
 #define UPT_IS_USER(r) ((r)->is_user)
 
-extern int user_context(unsigned long sp);
-
 extern int arch_init_registers(int pid);
 
 #endif /* __SYSDEP_X86_PTRACE_H */
-- 
2.34.1


