Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A41C83F24
	for <linux-um@archiver.kernel.org>; Fri, 11 Jul 2025 05:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wM0Uk9RW4iK25wVSKwbOk7r8z54vTCsoaRj5gGKuMrU=; b=1HWLo/oCYQpE9nlEhj+SCzaaiR
	kaImiG08WcPlySL4Mio++v/31MWJkStnGEyQVJIr7C1y93kWBzgwTB14HV006Tv6iZ6gG0Xs6UdHf
	ZVEB/Oz3R6eA3vQQsRThNwflO41oxIEq24L+ELEleF58mX0n8kCxcXNPmkyjzSJwF7dPzbAWDr/zX
	JpLlZddoSRXN7EHGKaCokYZ6NpYhSmmoqMu51z5ekqJ+2QXYrEUlC+5NkPeLqm6BEp6Lua9X/xzII
	zvXACaHiHQCBcHPRVQ0z+tRzlshK0CqDdXidTC3kW7vZJZJlDgEJ6hkLbybroPirvogcQQRBJWnX6
	5orTMswQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua6S7-0000000DlcP-2EJF;
	Fri, 11 Jul 2025 05:37:43 +0000
Received: from out-189.mta1.migadu.com ([2001:41d0:203:375::bd])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua6J8-0000000DkjO-2bfM
	for linux-um@lists.infradead.org;
	Fri, 11 Jul 2025 05:28:27 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752211687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wM0Uk9RW4iK25wVSKwbOk7r8z54vTCsoaRj5gGKuMrU=;
	b=uA4aYY1AJpSHvY2OtzBEScs7aDM0+5nQOu2OWiI7TA1gE1nh6yz7C/kbwyl9XyMSF/niMu
	wi7JkcTxVEBCB9VMBkK90b928ZVJyPE+bh0u4iLTLT1FAnlJ3GBb8DypBISBZCkVT3VkYm
	6TutOMEKAVax0u+WpV1gqUOuvU1e2n0=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 0/3] um: Remove userspace_pid[]
Date: Fri, 11 Jul 2025 13:27:45 +0800
Message-Id: <20250711052748.2434424-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_222826_799428_D2EC08B0 
X-CRM114-Status: UNSURE (   3.47  )
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

Tiwei Bie (3):
  um: Use err consistently in userspace()
  um: Remove the pid parameter of handle_trap()
  um: Stop tracking stub's PID via userspace_pid[]

 arch/um/include/asm/mmu_context.h   |  9 +-------
 arch/um/include/shared/skas/mm_id.h |  2 --
 arch/um/kernel/exec.c               |  2 --
 arch/um/os-Linux/skas/process.c     | 33 ++++++++++++-----------------
 4 files changed, 15 insertions(+), 31 deletions(-)

-- 
2.34.1


