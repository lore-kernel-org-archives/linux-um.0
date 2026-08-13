Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD339C5CFCF
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0X07In1qldTGybmdx53x+y5tR/aR+S5pQLXMdfQFUQ4=; b=aVBqLMNjm1sxnw3xnlc4o6JcsC
	zntjdgYXfHs76WAyR4XidGmPGbUos3cGMBnTT/V0qbsWUDbicuMDKX6dRGFwwXVJgMDDgpYBe6P8Z
	M9w1Gw5+qMSDx9J1sAI/Qja/svm1XVNLvBAcw8DOlNEtRfag0JOq0iqJFCrw5zhlXjfIlikiBmSGW
	sR2TKEp5Ww5uE7i4Rf88hdd/D4GxJgOR9MtQKTCAi2CxUPqtLSX/t4lFY0AgK+5O9knE5U3eSNfsW
	7ar5C6vHQqX4kStUnm3LtqLMHpraTW5WsewQFWnm8KZo9M/GordiqPwEMloMyybIUcelh+Ep4cWZC
	qpcAESrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYsw-00000001FCO-1dVe;
	Thu, 13 Aug 2026 17:06:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYsu-00000001FB2-32J0
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 17:06:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0X07In1qldTGybmdx53x+y5tR/aR+S5pQLXMdfQFUQ4=;
	b=D0eqXnS8XkzEcRybZXqxwDffG8ljt/Ig8FBAk97pyRVMBl34WgBTd3NN8d8HtuT3OkeB8r
	IRe3vceoydRprISe+8ZUPPaDt7K31WTTa+lR1GHWPKgb1qj+ma39+6Z1BiCduYVTeaERSS
	R7UuSl2Ijg3zCC2bw997d1OfStbKTJk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-HbeFCVHqOGGW_1hh13qClQ-1; Thu,
 13 Aug 2026 13:06:23 -0400
X-MC-Unique: HbeFCVHqOGGW_1hh13qClQ-1
X-Mimecast-MFC-AGG-ID: HbeFCVHqOGGW_1hh13qClQ_1786640778
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B963618001E6;
	Thu, 13 Aug 2026 17:06:18 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7586A195608A;
	Thu, 13 Aug 2026 17:06:06 +0000 (UTC)
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
Subject: [PATCH 12/13] um: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:03:02 -0300
Message-ID: <c4118be04a7247aca96de49950dd5d866aa352b8.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: dSxqswaDD5wHXpjfOfN61t4BHPH61Chp57BLdQ75ujM_1786640778
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_100628_837323_D2B228C6 
X-CRM114-Status: UNSURE (   8.49  )
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
syscall arguments (UPT_SYSCALL_ARG5, UPT_SYSCALL_ARG6) now that
the audit core logs all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/um/kernel/ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index fdbb37b5c399..c597a368592d 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -127,7 +127,9 @@ int syscall_trace_enter(struct pt_regs *regs)
 			    UPT_SYSCALL_ARG1(&regs->regs),
 			    UPT_SYSCALL_ARG2(&regs->regs),
 			    UPT_SYSCALL_ARG3(&regs->regs),
-			    UPT_SYSCALL_ARG4(&regs->regs));
+			    UPT_SYSCALL_ARG4(&regs->regs),
+			    UPT_SYSCALL_ARG5(&regs->regs),
+			    UPT_SYSCALL_ARG6(&regs->regs));
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, UPT_SYSCALL_NR(&regs->regs));
-- 
2.55.0


