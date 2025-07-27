Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820DBC87FD1
	for <linux-um@archiver.kernel.org>; Sun, 27 Jul 2025 06:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jlwexLkYGu2ZtTYYoSkq3O6VnFeFlkrnBT4/ZXL+z88=; b=yAxJocPdA0TYm1j/4oymre2DSH
	n+umdFn4l0SCw5HhSXuSRerNix3pIs64Nav66eO7PJgZiwKPkltCrRzrjZtJWaTKBFqccPXcdh8uP
	6JX6YQ9g3lK2swrFLfdsMgn2PuWpFxk4vs0qKcflPZdKgC4XvyReYaEE0ya11qm6lIynPISID3dW6
	JtkE4XKxgceGeO/44ktyaiuFcJW3yfAdSMw/s4HMEqs9zUBfxxO6DfwYMOqbuiYeBYQM6S4uN3MRx
	tkRblF5+Dw2IUDLO8csMbErdXmVlm0sTJZ9ZIEOrN7NvZyIonV+zidju6otwUkWcf12uO5010FxyX
	5Dw2RVgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufutm-0000000CNqy-0ZyN;
	Sun, 27 Jul 2025 06:30:18 +0000
Received: from out-186.mta0.migadu.com ([2001:41d0:1004:224b::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufutj-0000000CNpf-1ViV
	for linux-um@lists.infradead.org;
	Sun, 27 Jul 2025 06:30:16 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753597812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlwexLkYGu2ZtTYYoSkq3O6VnFeFlkrnBT4/ZXL+z88=;
	b=EqbvVbK5Pd6ACH80L6+hJ7zIHv1wYTOCpA/Q1n82fb7k4o8TZfv6Ozv2PB2ts9dimmlgnV
	b8/sAhA/unqMyXPbmbkLxaX1/DmlWPZQTNkXwQEtvL3+dpnrR4j+iDeiWdJ0BEDN8h8y2t
	J8MMwMMb3/sDDGLa0uiiQywOiqcxUPk=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 4/9] um: Preserve errno within signal handler
Date: Sun, 27 Jul 2025 14:29:32 +0800
Message-Id: <20250727062937.1369050-5-tiwei.bie@linux.dev>
In-Reply-To: <20250727062937.1369050-1-tiwei.bie@linux.dev>
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_233015_544293_624FA2D4 
X-CRM114-Status: UNSURE (   6.81  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

We rely on errno to determine if a syscall has failed. However,
the current signal handler may modify errno. Preserve errno within
the signal handler to ensure it remains async-signal safe.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 11f07f498270..217a71244b69 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -201,8 +201,11 @@ static void hard_handler(int sig, siginfo_t *si, void *p)
 {
 	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
+	int errno_saved = errno;
 
 	(*handlers[sig])(sig, (struct siginfo *)si, mc);
+
+	errno = errno_saved;
 }
 
 void set_handler(int sig)
-- 
2.34.1


