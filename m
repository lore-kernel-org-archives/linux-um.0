Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C858CFA3755
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 14:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICwDMhjJ7dbADtxlBSbI8KnsxD7naRbiR1HvDVegF5k=; b=Ima4K+36dklaFBPJQc/UC3IUHB
	kdS8eFN2Iyl43Mq3f23I9/7HPXkngtbgFcT64vPkoHgkM0BqXyyAC5ULq9M/mbpqvRj7WW6VsyyEh
	NZhDkSqtfA037GMx3mFPyqBNs9L6eHRdt9k4kwDvmbxLc4iYFyY8BpM42c9xId9j6x0knGKXH5+/L
	zfnEfCQ6MtM/HB4EF1TPvgHKQ/GHgWHa1xqdmCb3b8gPY8G6xEKV51k35UaAs8+MHQOUift5+d7ab
	73ZmrG4MT5cA3/jVhCF4Pwvj/GHVqBI4cWXSX3gw/9Ghi6KLDCFZzs9g28WWG+0CVw8oNZBPXH+Sq
	WgG43bbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7BL-0000000GAqW-1atb;
	Fri, 13 Sep 2024 14:21:55 +0000
Received: from out0-219.mail.aliyun.com ([140.205.0.219])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7BG-0000000GAo5-2qN7
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 14:21:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726237308; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ICwDMhjJ7dbADtxlBSbI8KnsxD7naRbiR1HvDVegF5k=;
	b=h+AEMustB7uYHtjGg2n6Ew+fgce8xmVCUNHwJGCQY/WeKBYhsXpejKmmNw/H3hBnS7kzFIyUsjdaTPvo8n9qBZU8iL2CqALZlaKg2tsyJtYnr3AKNVH7h2lTbxchAzluQjDk6W2T36ZoJVHgU97wkODk9ITLmodDOUDw3KCY90g=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZIP7E7j_1726237303)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 22:21:45 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/3] um: Remove the redundant declaration of high_physmem
Date: Fri, 13 Sep 2024 22:21:35 +0800
Message-Id: <20240913142137.248245-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913142137.248245-1-tiwei.btw@antgroup.com>
References: <20240913142137.248245-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_072150_913839_5FECA80A 
X-CRM114-Status: UNSURE (   7.93  )
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

high_physmem has already been declared in as-layout.h, so there is
no need to declare it explicitly in the .c file again.

While at it, group the declarations of __real_malloc and __real_free
together to make the code slightly more readable.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index f98ff79cdbf7..cf1179ed1aec 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -182,6 +182,7 @@ int __init main(int argc, char **argv, char **envp)
 }
 
 extern void *__real_malloc(int);
+extern void __real_free(void *);
 
 /* workaround for -Wmissing-prototypes warnings */
 void *__wrap_malloc(int size);
@@ -219,10 +220,6 @@ void *__wrap_calloc(int n, int size)
 	return ptr;
 }
 
-extern void __real_free(void *);
-
-extern unsigned long high_physmem;
-
 void __wrap_free(void *ptr)
 {
 	unsigned long addr = (unsigned long) ptr;
-- 
2.34.1


