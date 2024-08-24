Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BEFC52D6F
	for <linux-um@archiver.kernel.org>; Sat, 24 Aug 2024 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=34RfHDOjHJePt7cVgoRsoc0EmlUSCnDZz3OUn0GMJJ8=; b=3jlF+iOSPl7zTsEUDHIrvX6e/d
	9WApqrWxzLqtMI/i8tgdNN+55Rrw++7sJ4OlPbdy6xLAqkjMl1ZmbPbLURyeIAXBlANMInVadCtec
	S5qQsLj5iEvO7+zIqyHbJpR1S3UVYrEhuBA1ThbHIqqOS7+QtOkz6ahqW94DQ1u3F+m3cvxHKB+JU
	rGR9zQkQh5ckGGQg43cZcwAASBYy0iHj9SXrzp6IeEolLOri+1ilW+iKKNwYJJqL0brQVlBXQ+bOt
	0o0Msj+DGix3PK9W5b17JjqlthnKthr0VXU4DSUG02iiQcHzzZe6R2+jPnehfa33lfdF74rkA6cxr
	U+1SO7Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shpWO-00000002Auh-10EN;
	Sat, 24 Aug 2024 12:05:32 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shpWK-00000002AtF-2Aih
	for linux-um@lists.infradead.org;
	Sat, 24 Aug 2024 12:05:31 +0000
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WrbFg5dBBzpVl1;
	Sat, 24 Aug 2024 20:04:07 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D76F18007C;
	Sat, 24 Aug 2024 20:04:51 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 24 Aug 2024 20:04:50 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <benjamin.berg@intel.com>,
	<cuigaosheng1@huawei.com>
CC: <linux-um@lists.infradead.org>
Subject: [PATCH -next] um: Remove obsoleted declaration for execute_syscall_skas
Date: Sat, 24 Aug 2024 20:04:49 +0800
Message-ID: <20240824120449.2517046-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200011.china.huawei.com (7.221.188.251)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_050529_434457_E2FDF0DB 
X-CRM114-Status: UNSURE (   7.52  )
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

The execute_syscall_skas() have been removed since
commit e32dacb9f481 ("[PATCH] uml: system call path cleanup"),
and now it is useless, so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/um/include/shared/skas/skas.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index ebaa116de30b..854cff8d6319 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -13,7 +13,6 @@ extern int userspace_pid[];
 extern int user_thread(unsigned long stack, int flags);
 extern void new_thread_handler(void);
 extern void handle_syscall(struct uml_pt_regs *regs);
-extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
 extern struct mm_id *current_mm_id(void);
 extern void current_mm_sync(void);
-- 
2.25.1


