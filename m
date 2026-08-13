Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB21C5CFCF
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rmq0hRGs7XLSkpGEwHv2UKKAjTQAHgK3a7MrJIwRAjY=; b=j5npmsT9rsziZd/gcZdMtdK0q5
	JxtBd6NGArF8+5Nf9JynusAn72JB1Ra+eyloOJLEbbr2NDeK0qla0oB4YyQd7FU3K6YspFP4Ihd+j
	m/TlBq/dpRgOjRkcUJAvFrkDXstDKA4Mb7e8co/y/jamc3dxZ4Hn71BfXsX5DaQsaAiMw3YpARMXO
	nwUOowu37NaO1goozdDeGbYotD04HCoCGVHgeuB/j7a52It4kqcrYjqQwCfgoDE9D5kugF1THAFHb
	3kvKRy5lAcT79M9HakH1RbSxyVEze5A6dVmKsD3PBLXt3QrCx0Fxrn6XDOfl6BZOxBrNtIeIf/brm
	CnypRnTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYrz-00000001EUJ-2JeH;
	Thu, 13 Aug 2026 17:05:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYrx-00000001ESM-3pFr
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 17:05:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmq0hRGs7XLSkpGEwHv2UKKAjTQAHgK3a7MrJIwRAjY=;
	b=dXCs7zWViR75TT5uED4LPt/Xek1iZMCXaRVTC3qhkp4gWvnxY0HjC9urz/HupqSNRvuZtb
	PNxkz9XXVwx4Q3LRwld3jRMm8urYeccCnZWUDeWiKlfqwYb7WFkZ090xlfCQ0TKuBwoP+a
	0YvFGbbOjuQz7pyGx6jZV1EwhLmIUqU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-ArqhbR0JPReXkqbQc_9JUg-1; Thu,
 13 Aug 2026 13:05:20 -0400
X-MC-Unique: ArqhbR0JPReXkqbQc_9JUg-1
X-Mimecast-MFC-AGG-ID: ArqhbR0JPReXkqbQc_9JUg_1786640715
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E37A91800643;
	Thu, 13 Aug 2026 17:05:14 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DBDD3195608A;
	Thu, 13 Aug 2026 17:05:02 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	sgrubb@redhat.com,
	oleg@redhat.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	guoren@kernel.org,
	monstr@monstr.eu,
	tsbogend@alpha.franken.de,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	tglx@kernel.org,
	peterz@infradead.org,
	luto@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH 07/13] mips: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:57 -0300
Message-ID: <212ca026f8a19f564f3b37b03d1d3e09e0de3e47.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: s7XZVZkEuAj_9Q7W74LYz1lavC3CYSqftOv_3KDvn_c_1786640715
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_100530_028501_FFE3AD4F 
X-CRM114-Status: UNSURE (   8.28  )
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

Use syscall_get_arguments() to retrieve all six arguments portably.
On 32-bit MIPS (O32 ABI), arguments 5 and 6 live on the user stack
rather than in registers, so direct register access would be wrong.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/mips/kernel/ptrace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 3f4c94c88124..9e6f9accdb41 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1334,9 +1334,14 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
 
-	audit_syscall_entry(current_thread_info()->syscall,
-			    regs->regs[4], regs->regs[5],
-			    regs->regs[6], regs->regs[7]);
+	{
+		unsigned long args[6];
+
+		syscall_get_arguments(current, regs, args);
+		audit_syscall_entry(current_thread_info()->syscall,
+				    args[0], args[1], args[2], args[3],
+				    args[4], args[5]);
+	}
 
 	/*
 	 * Negative syscall numbers are mistaken for rejected syscalls, but
-- 
2.55.0


