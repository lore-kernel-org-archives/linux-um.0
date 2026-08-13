Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEE8C5CFCF
	for <linux-um@archiver.kernel.org>; Thu, 13 Aug 2026 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GgHNIRpaiGrsleuWQ8qibHY2uklIV42xG6wSQPY4e1M=; b=JLSmnM95lOaJbMKhCh/liWviCe
	K5+jjhRkgCaIP4E188WJc3eac8GbbyH4si615RhFGlheWY6KdjhXPyQQ1IDuGDo1+TQyEEPHvlR6k
	D05fXQCyZk0te8zgqkZ8JAc+RqvME7PBWMhH3S/MSR3k5EzJumogkyVvheEb56TNZYT86wztLI/V6
	/TL9FKD9GHJzUQvIowannZhPYVukGitzbkyksHUpRFLjXcIgWNNd3lk0+yc6Tzuqy8H9XvbITwBLz
	f3ecbh32mhEi05kceuIlXfE5InfqJ+W0gKzhcZe3C+UTmliXY6XOGhIksBkQjTpgm9pQnxTfCsBKN
	3nROXj9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYqz-00000001DyA-1uLl;
	Thu, 13 Aug 2026 17:04:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYqy-00000001Dxh-2jv1
	for linux-um@bombadil.infradead.org;
	Thu, 13 Aug 2026 17:04:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GgHNIRpaiGrsleuWQ8qibHY2uklIV42xG6wSQPY4e1M=; b=ZJKm9IjyYhCwOvvEXNJeDKSHiD
	xQGSdA9+Te2x1p3h7bfSFe+VhPT/Pj+hubede6t41xFssayQLZDON7FmFnrXmCuSajPXWLUhnPOW2
	5FtvH9fmEJslGkugfIjq7K1JPqvBHrga5T4Y4okVqP+jW61+Dh+8zVNtTRUGi+IXeoV0D7jfkJXnN
	1t2/Qb0j4HAahkQGThl0Rfl/Zmu1RFqpSTEeV2rUOuxlznazyTKDgadUdcfyXzbt8F3wpehonR/Sg
	FyD8I1PgBx5d8Cjhf0yDNzCVp7FjklCLisR02erLZ1N/qM7/mP+uW+MVFPgyMc45iqgzD4KJ7eBtq
	o14GqbcQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wuYqv-0000000GMPz-3tv2
	for linux-um@lists.infradead.org;
	Thu, 13 Aug 2026 17:04:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgHNIRpaiGrsleuWQ8qibHY2uklIV42xG6wSQPY4e1M=;
	b=LVHaVHnCNimCbAdD4vkNBZaScKjm8KAxPBtNFY4eYh9MI9JzrGpPAvxbU+AxrUdT6/5+Zb
	VLY1Bkou4mdCh4qiBaDJRXo0lQbgaU4WPQUrQHHAEQQnVOYpTM/PPZ6WcB2zNwfdWG6rvp
	P3talaPHP6zMyiZC+Nd9nK9ywHCYo8Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786640665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgHNIRpaiGrsleuWQ8qibHY2uklIV42xG6wSQPY4e1M=;
	b=C4CdOFUC8iz5RnILQpyXU/9VmXggunVHczih330ICv0pB/BjHrH3UQWggqMBxUI9IdfQy5
	BtuF5JZMsMtGOXjawzjXuoe3uWgjwnGoFcA9v4VQlrOUTKucR62XJH3swgQkAhQMCwO+3S
	HXw6r0Wko3DpUtLdTQB52t2DTCVRy9Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-v7F3cTZiOfi696D6EVHhdQ-1; Thu,
 13 Aug 2026 13:04:13 -0400
X-MC-Unique: v7F3cTZiOfi696D6EVHhdQ-1
X-Mimecast-MFC-AGG-ID: v7F3cTZiOfi696D6EVHhdQ_1786640647
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FFB5180066A;
	Thu, 13 Aug 2026 17:04:06 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07750195608A;
	Thu, 13 Aug 2026 17:03:51 +0000 (UTC)
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
Subject: [PATCH 02/13] alpha: pass all six syscall args to audit_syscall_entry()
Date: Thu, 13 Aug 2026 14:02:52 -0300
Message-ID: <7dec380a50e3db536bdec61a33b8f3b2e2e7ec65.1786626275.git.rrobaina@redhat.com>
In-Reply-To: <cover.1786626275.git.rrobaina@redhat.com>
References: <cover.1786626275.git.rrobaina@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ttXAR8_1Sx6tDV0Xj3jC1ySfuO52a6LpJ45TeMGktsw_1786640647
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_180426_080573_3D612A35 
X-CRM114-Status: UNSURE (   8.01  )
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
syscall arguments (r20, r21) now that the audit core logs all six.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 arch/alpha/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index 0687760ea466..d90e2194b528 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -396,7 +396,8 @@ asmlinkage unsigned long syscall_trace_enter(void)
 
 #ifdef CONFIG_AUDITSYSCALL
 	audit_syscall_entry(syscall_get_nr(current, regs),
-		regs->r16, regs->r17, regs->r18, regs->r19);
+		regs->r16, regs->r17, regs->r18, regs->r19,
+		regs->r20, regs->r21);
 #endif
 	return syscall_get_nr(current, regs);
 }
-- 
2.55.0


