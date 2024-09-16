Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43216C3ABCB
	for <linux-um@archiver.kernel.org>; Mon, 16 Sep 2024 05:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cbbIBKc7FkHrrK8qYg7r4mWInrYZd8lfitbgdnVzDr4=; b=O6lSNaSj2AW8xo6zI2GVP1OM73
	ymXKkYxf1Y4t78lOLCg1YLAsDu4DyVR3MkjawINckqc0H+LVf1VvcTWxqX4sJXKo1eIl4U6hO0iAJ
	Fn2j1ofDwiJrteBZ4GGnoaLF+ri0aAZklSL4mKEyIhmerVv0Jc7VUUKhUEP1fJbv/yMPTWFLLrDRI
	tZrpHQ3ALIOP7CNUkEZt3Brycwmm4bPidKLSlrw4C6c9jwPq06gIVyXakYMbYNSdpo5+/ugrf+G8A
	HrW/u9ApsXVsuALiwNrmcvkzf8aUAfXPYAI6qQR63E2uXmxz6f0BD8BSQ5i+2wVgGDRtwWhyUY8F2
	IIdRS17g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sq3qQ-000000035TM-3OxW;
	Mon, 16 Sep 2024 05:00:14 +0000
Received: from out0-195.mail.aliyun.com ([140.205.0.195])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sq3qL-000000035QB-1gJN
	for linux-um@lists.infradead.org;
	Mon, 16 Sep 2024 05:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726462806; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cbbIBKc7FkHrrK8qYg7r4mWInrYZd8lfitbgdnVzDr4=;
	b=rA3/kPTK2EKW9YnKvi1ffvmd+pHfG479Q6wst6YgIZpXFMnfKOrfV+CLCAzWgPtBMj2iiN2iX755bwzQxmIMYxUOv3y7+Sy7gS3luU6KObwNJZMkTrzyYwR48YzCjApq1GjDtyo/JoaKlyRsyKE7ArKo4sSr4o1F44h+h9Dvmts=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZKOkLWf_1726462804)
          by smtp.aliyun-inc.com;
          Mon, 16 Sep 2024 13:00:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 2/4] um: Fix potential integer overflow during physmem setup
Date: Mon, 16 Sep 2024 12:59:48 +0800
Message-Id: <20240916045950.508910-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916045950.508910-1-tiwei.btw@antgroup.com>
References: <20240916045950.508910-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240915_220009_797350_9901A084 
X-CRM114-Status: UNSURE (   8.51  )
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

This issue happens when the real map size is greater than LONG_MAX,
which can be easily triggered on UML/i386.

Fixes: fe205bdd1321 ("um: Print minimum physical memory requirement")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/physmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index fb2adfb49945..ee693e0b2b58 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -81,10 +81,10 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 			  unsigned long len, unsigned long long highmem)
 {
 	unsigned long reserve = reserve_end - start;
-	long map_size = len - reserve;
+	unsigned long map_size = len - reserve;
 	int err;
 
-	if(map_size <= 0) {
+	if (len <= reserve) {
 		os_warn("Too few physical memory! Needed=%lu, given=%lu\n",
 			reserve, len);
 		exit(1);
@@ -95,7 +95,7 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
 	err = os_map_memory((void *) reserve_end, physmem_fd, reserve,
 			    map_size, 1, 1, 1);
 	if (err < 0) {
-		os_warn("setup_physmem - mapping %ld bytes of memory at 0x%p "
+		os_warn("setup_physmem - mapping %lu bytes of memory at 0x%p "
 			"failed - errno = %d\n", map_size,
 			(void *) reserve_end, err);
 		exit(1);
-- 
2.34.1


