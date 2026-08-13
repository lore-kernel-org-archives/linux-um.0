Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD55BC5CFCF
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 17:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UIpmsX6WtXNHFCRHtGccortX+Ir4DIAT5TQlZZyNQeo=; b=ip4Xorz8KUVX7Yyd+28ILCXx8S
	2p1L9eywwIW98YtLMAsf118wXB136LGl/5fgBvTccAIXdUeYowjQS8j/BRkZ1+v28CGDgGm4/njWJ
	ttgCFfpv7R7wfcC0KRUwvBvdhm/89iVkiMhRWhtMiTV5EKyZLFuymnxMrroKMHxlWiQIWD6HlzdxJ
	cmn3GsNLLyry92LKnB5ML4/vnCHwsWDmzpow3PGkU8CaCCeYj3zgYvghjLM850SZ3hOjbePvJN1gG
	uLx0MIAnHJfK5o1nRo4ougHQVPxPcSCykGR5UnaiIgcwI625LIBcN+2RgUG4Ho+rfRd9kzcQ8D9hr
	Xk5mFxJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYrS-00000001E90-1o5D;
	Thu, 13 Aug 2026 17:04:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYrQ-00000001E7Y-3O4E
	for linux-um@bombadil.infradead.org;
	Thu, 13 Aug 2026 17:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=UIpmsX6WtXNHFCRHtGccortX+Ir4DIAT5TQlZZyNQeo=; b=Bj1qcfpY6NGR6Jn7Cy/vgxjmsM
	tXT9ovRqHKRAE1Su6rZvfOiB2BkeS/Llk8ZfMI/utWGPeNZwiDg5vYY0rLhwkCLl757IaetKZvwcU
	lSTQ+lWwXN2xxVXQR0EtbOgzakIaVaKpX6YC9jLqOK3H3LtbdJHuvgbctWQlRpJDluxyCoQfBThY/
	6r5e25Hj5yr5pq83R0yL+8IJ0Efk1mFcGxU3lOlj26jmPt5084PXDei/6/T5mO+XGjcmdh3cxCNIB
	I316oG5A1VE8xoeTh32mE0mFI40oZIPAsAJ8yUeV6XnH//adZfh13ey+85nxPhPdUzc/ya4g1GlJ3
	6V/cn9vA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wuYrO-0000000GMU8-0FHv
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 17:04:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIpmsX6WtXNHFCRHtGccortX+Ir4DIAT5TQlZZyNQeo=;
	b=SCFBRbStNYr50yRTy/hGpFuC/FEfcZdSfNVy0DqxNI4zTvGhlA0dKWjYl/Qkig/8DLv9I4
	Q1HCqkI0JVG/RvKJDKGQKaFsj2/GxvnQhKrW9VHYCa18qbEqRs/O+hsTn8lVzY58kkbcPt
	YGtNLOpK/2QGWHMQ/560codEk3ApVsg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIpmsX6WtXNHFCRHtGccortX+Ir4DIAT5TQlZZyNQeo=;
	b=QRO/W8hBXg1QV2nbOO4C5Rba7tLkNpFVoR3Q7/5j5IOuXaeMRPMB2AY78vkVVMplZ7pw3Q
	rZ1ESHVR+AlhEWXTncTgGpuTJfC7H+CkoluqhQBuocnKXtEo328nnrmAWJe/hdpQO8KkLb
	AheoxKqcnQnAPz0wis3MVg70sVH5m7k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-6MwurZx8OlqzEe_HJiXJUg-1; Thu,
 13 Aug 2026 13:04:43 -0400
X-MC-Unique: 6MwurZx8OlqzEe_HJiXJUg-1
X-Mimecast-MFC-AGG-ID: 6MwurZx8OlqzEe_HJiXJUg_1786640677
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9356195609D;
	Thu, 13 Aug 2026 17:04:35 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B0A8195DF9A;
	Thu, 13 Aug 2026 17:04:22 +0000 (UTC)
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
Subject: [PATCH 04/13] arm64: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:54 -0300
Message-ID: <84e977166dfd72c8c5b53a54e86e149e7ed60672.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 0OF7TM2jBOS8bHx1GvPKj1GoqoskprIZxC1paDw5t8c_1786640677
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_180454_206066_0996EE9A 
X-CRM114-Status: UNSURE (   8.13  )
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
syscall arguments (regs[4], regs[5]) now that the audit core logs
all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/arm64/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4d08598e2891..093c20bff38a 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2427,7 +2427,8 @@ int syscall_trace_enter(struct pt_regs *regs)
 		trace_sys_enter(regs, regs->syscallno);
 
 	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
-			    regs->regs[2], regs->regs[3]);
+			    regs->regs[2], regs->regs[3],
+			    regs->regs[4], regs->regs[5]);
 
 	return regs->syscallno;
 }
-- 
2.55.0


