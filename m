Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A8C5B572
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m7DByCcmMjMcU6fVtAV0LTF+gTPKITg6ZRJZBP5hclI=; b=Na9mUEzLOWM3nTcMNKQp2ZHkS+
	ScwoBp8mMby+bCUb3kEm76PPO1JKlOQ2bUbk1WD/09/3Bj8RHzXqIKY2C9pRoVugZRIZXWO6AwhAs
	OR3qGykPvKh1q4PDZR/XhNsiXg5F7MTUfZDAFXk4tZjpWLAgnqIMJ4Qd8EZ/TeV/8NaJMeQRwXnGw
	dJx9HDCe7xj7Js2p37nyUJJUUXueUPqSa7PAb4xVXZw/r9UIPmhOSkzgtg+temVSvroLEr5dmQrJ8
	LCOfDYBx+96+fcpoG82YhwCA67CakLAu0wCVAz34kk+aujq0bovavaH+5CB7S5SSgYjDUvd/PW3Y6
	Ic295AJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYsA-00000001EbE-2l8K;
	Thu, 13 Aug 2026 17:05:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYs7-00000001EYw-3EqE
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 17:05:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7DByCcmMjMcU6fVtAV0LTF+gTPKITg6ZRJZBP5hclI=;
	b=QefH/dIWdAlQ1Q30l7rU4IrYy1VoGQ67K27yU4fnFrtnb6NzwQtoeN/j8I0+8IFsCQF0a3
	h3/cIbRVsvhiKCZ55dvS4Rm2NWwnJZRHBgVr83BKovGYfe3yql9Lf+KMq7GcGNXQjddrXa
	1qbKkbkf57Pjd8dCmx5LtmDCPr8oAgM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-dZ4Wkn9xN22gyZ5-MF-yqw-1; Thu,
 13 Aug 2026 13:05:34 -0400
X-MC-Unique: dZ4Wkn9xN22gyZ5-MF-yqw-1
X-Mimecast-MFC-AGG-ID: dZ4Wkn9xN22gyZ5-MF-yqw_1786640728
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2B841956071;
	Thu, 13 Aug 2026 17:05:27 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76CC6195DF98;
	Thu, 13 Aug 2026 17:05:15 +0000 (UTC)
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
Subject: [PATCH 08/13] openrisc: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:58 -0300
Message-ID: <1616198d0cfa9434b36fc1ac6055064ae8c08057.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: BB4trAwuHhDlko0pUtlBvKWEJDkJKx4gZZWgzAE3edk_1786640728
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_100540_296762_A2AF3EBD 
X-CRM114-Status: UNSURE (   8.02  )
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

Update the audit_syscall_entry() call to forward the 5th and 6th
syscall arguments (gpr[7], gpr[8]) now that the audit core logs
all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/openrisc/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 552489b24855..197a616d6c65 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -302,7 +302,8 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		ret = -1L;
 
 	audit_syscall_entry(regs->gpr[11], regs->gpr[3], regs->gpr[4],
-			    regs->gpr[5], regs->gpr[6]);
+			    regs->gpr[5], regs->gpr[6],
+			    regs->gpr[7], regs->gpr[8]);
 
 	return ret ? : regs->gpr[11];
 }
-- 
2.55.0


