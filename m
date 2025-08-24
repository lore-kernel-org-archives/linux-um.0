Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A201CA0FE8
	for <linux-um@archiver.kernel.org>; Sun, 24 Aug 2025 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ePrILEPI8ASfod8c3JyLaJZTjPoP7Vn9TILwOYjTK6k=; b=JPpjOznhz0FsXNp+nACTsKIbsi
	8EJ0SHOyaaZ1sQ5JVjemCs1Mkf7G+5gA/w+/8q3n47cAKvzJl9Jz8TI9Ug0EY6q3zTMSBjmLknuD7
	DeWkhm6cbKmKPCuyV5roFYQ5TXZHSMhxe5xXxIS5OuZUmDo5furkdDM5klrjbPhiDraFlnaU2++Jg
	RAJOXFoUaiIMfXFfAwWczd8zWZ4gvMrkttX0oyQhIDcTaYnL7SpnX4VPXNkKPL+asc/ntLog2KX9V
	vrBUt3Kc/ZlQd6RUd7xdUIqy8w+Kd3aCQCr8TY79XhgoXyADjS8XBXmR2p2m1WmfVR4b2tcNpVkw2
	LogJzL3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCuE-00000006JGR-3MLI;
	Sun, 24 Aug 2025 15:45:18 +0000
Received: from out-181.mta1.migadu.com ([95.215.58.181])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCuC-00000006JET-1k9I
	for linux-um@lists.infradead.org;
	Sun, 24 Aug 2025 15:45:17 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756050303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePrILEPI8ASfod8c3JyLaJZTjPoP7Vn9TILwOYjTK6k=;
	b=OavHrhUlOavirLquoUmG0xYM7oFrTIuXwS9+Dh3Hwl6JEqQoBas0WXV5uJw3sYEFsGglnR
	l8xLZqq9kdmHbs+iWmduz3ddliCReNPeay7PbDR+FfkAPJF3pkMFDmrKD9Hq4bPG0Aw3O5
	9ra0IcvmK4qImKYJZbf51pXWTsJAHz4=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 2/7] um: vector: Fix indentation for help message
Date: Sun, 24 Aug 2025 23:44:20 +0800
Message-Id: <20250824154425.2243375-3-tiwei.bie@linux.dev>
In-Reply-To: <20250824154425.2243375-1-tiwei.bie@linux.dev>
References: <20250824154425.2243375-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_084516_597757_1F3E7060 
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

As with other help messages, use four spaces instead of a single
tab for indentation.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/vector_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 9bbbddfe866b..25d9258fa592 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1721,7 +1721,7 @@ static int __init vector_setup(char *str)
 __setup("vec", vector_setup);
 __uml_help(vector_setup,
 "vec[0-9]+:<option>=<value>,<option>=<value>\n"
-"	 Configure a vector io network device.\n\n"
+"    Configure a vector io network device.\n\n"
 );
 
 late_initcall(vector_init);
-- 
2.34.1


