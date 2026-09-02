Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C82C624D3
	for <linux-um@archiver.kernel.org>; Wed,  2 Sep 2026 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3jzmBjzGkcUWIV8+PXpCllBMS71YAnuNqy8uXQRSDk8=; b=yeH4uPNg26mFCmcpSHqscg23TA
	yZrgz874lK6VkSIy/zwxiuvKmshqHzh00jkkLUCVh0U6yn49migvJ2IWku5tUAX4oabVxgs75V3UU
	dPnuxX/acSRWHiU1/cxc6I8JU4Se/yQ8KXhMtGl3c64mdkUfziO5U0VSl/fLwxXcHx9n0p3YdOjdu
	5AMUWJmVJDPynv5p4s897I6c7S0k8XwDELc9LI4xCz6t7P6s9InvG9PJ9dTP3kHSsURX43yDZE3YJ
	FSoyCHNy8GyHVkaH7j3XIm/XxeGeuHHBJ/3bY2+VuCh0iS9faeQSacmN4rnymhPQciKjDERNCQlm5
	98wwSutg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1mDv-0000000Ezks-0M3v;
	Wed, 02 Sep 2026 14:45:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1mDt-0000000Ezj2-10Vw
	for linux-um@lists.infradead.org;
	Wed, 02 Sep 2026 14:45:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jzmBjzGkcUWIV8+PXpCllBMS71YAnuNqy8uXQRSDk8=;
	b=B9m6GV5FA+7Hob2uDvrpOn2oBoBmBZ1tmy8/p+EOtgKx5UkqUSQ0kXb74LWCg5hBl/uYF2
	U9lkZe/a8ITji26TmcptKFW8afV/UcheCq9Iz4+ZcHh/KIuKm+MckbDVNYM80aVUPsLRmO
	G2RXfv3fkKZy/BjUxNVH9Jzv3edwMOk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-qp2Fhcg8PhKkCoXXpnbxsg-1; Wed,
 02 Sep 2026 10:45:50 -0400
X-MC-Unique: qp2Fhcg8PhKkCoXXpnbxsg-1
X-Mimecast-MFC-AGG-ID: qp2Fhcg8PhKkCoXXpnbxsg_1788360346
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96CCF184BA87;
	Wed,  2 Sep 2026 14:45:45 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.11])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 939571800642;
	Wed,  2 Sep 2026 14:45:33 +0000 (UTC)
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
Subject: [PATCH v2 07/13] mips: pass pt_regs to audit_syscall_entry()
Date: Wed,  2 Sep 2026 11:43:40 -0300
Message-ID: <153ece40b540f100ab436549b8e5819d52cd4f92.1788351089.git.rrobaina@redhat.com>
In-Reply-To: <cover.1788351089.git.rrobaina@redhat.com>
References: <cover.1788351089.git.rrobaina@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: RZBan9qoI60QOkHWuvmNliVh1itMXvcqIwvq2C08lvQ_1788360346
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_074557_344778_00613760 
X-CRM114-Status: UNSURE (   9.43  )
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

audit_syscall_entry() now takes a pointer to pt_regs and extracts
the syscall arguments itself via syscall_get_arguments(). Drop the
individual argument registers from the call and pass regs instead.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/mips/kernel/ptrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 17dc7249b8ca..7a09b4671a54 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1338,9 +1338,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
 
-	audit_syscall_entry(current_thread_info()->syscall,
-			    regs->regs[4], regs->regs[5],
-			    regs->regs[6], regs->regs[7]);
+	audit_syscall_entry(current_thread_info()->syscall, regs);
 
 	/*
 	 * Negative syscall numbers are mistaken for rejected syscalls, but
-- 
2.55.0


