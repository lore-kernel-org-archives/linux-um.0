Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00558CD37B0
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fza+UVpdAE1DmMs1AaE7RFF9cYJXOrRqsvTSex7d50k=; b=YFXiDlgAVv8Agh
	Y0tERZ9VcxTlNJ6xAuWxw/JSAU4jGjwLorcos0LfCCby3LTfG1B7jA+87DvuzT6lluQO+DyUIlv/a
	kgzCGR0hMBMXc0ptzobqXvgGgwF89pCSjZU/6qjejmU+4GEzk057Gva4xYGr+0DM1ivUBVD0qp1/d
	tou2Rb9ODFN0HSLWzecJBWdwIRXrDa7eGHthhgl0MnNW9zq7rm6e/1hpAwMsykJHG5NGJnqCrZASB
	uY2pDt9aNAB+bKkFHesh6HZ5NWw66Bk9eAy7bzqBHB1pNyV/wSGBFAyWNcvU6+NVMIecOESG6S4/V
	RIuJyqJ+D9WBm2hFAG3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiDq0-00FTw8-0t;
	Mon, 18 Sep 2023 12:58:52 +0000
Received: from mail-4317.proton.ch ([185.70.43.17])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiDpw-00FTvg-1P
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 12:58:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695041922; x=1695301122;
	bh=jFSuVM37gBzzT3DlSXH+u3vj6sxnz1gtZhD0blEKUx0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GQAKpSTbQf+pySgjFZNHQICah6ZILzxAU9AfMv5pQAjyU66s0cZYbmz8rQ3+PYlq8
	 oVoFVbOeIsQao1ujOQR/gG9egtf8zBxaFZiuFEWZr8HbSJ2tdieT+7BlrwSzJSo9a0
	 7HYc2nXVPue9w6ysyPH8ZErcqaXU1x7lPvSJztJk/xK+wbzfeRsRZzh1xIgzg7N2Zb
	 MUnwqjmTJYKxKCITC9Q5F8qVI+DS/nFctPrkUW63TubposSC6dq04/U232yCCRpQNT
	 6Jg8VUWY1qD0C8vnWSOCI5cYs2C4tvYs54l6JP61O/qyOvFwL79rFWCY4Y8PP9WCA0
	 C2itn0Hub3BWQ==
Date: Mon, 18 Sep 2023 12:58:26 +0000
To: linux-um@lists.infradead.org
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: Peter Lafreniere <peter@n8pjl.ca>, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, reiserfs-devel@vger.kernel.org, jack@suse.cz
Subject: [PATCH RESEND] um: Remove CONFIG_REISERFS_FS from defconfig
Message-ID: <20230918125744.4342-1-peter@n8pjl.ca>
In-Reply-To: <20230910232640.113938-1-peter@n8pjl.ca>
References: <20230910232640.113938-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_055850_128438_CE78F875 
X-CRM114-Status: UNSURE (   6.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

ReiserFS has been deprecated for a year and a half, yet is still built
as part of a defconfig UML kernel.

According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
filesystem is slated to be removed in 2025. Remove it from the defconfig
profile now, as part of its deprecation process.

Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
---
Fixed invalid DKIM settings causing the previous patch to be rejected.

 arch/um/configs/i386_defconfig   | 1 -
 arch/um/configs/x86_64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index e543cbac8792..9c9c77f1255a 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -61,7 +61,6 @@ CONFIG_UML_NET_DAEMON=y
 CONFIG_UML_NET_MCAST=y
 CONFIG_UML_NET_SLIRP=y
 CONFIG_EXT4_FS=y
-CONFIG_REISERFS_FS=y
 CONFIG_QUOTA=y
 CONFIG_AUTOFS_FS=m
 CONFIG_ISO9660_FS=m
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 939cb12318ca..03b10d3f6816 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -59,7 +59,6 @@ CONFIG_UML_NET_DAEMON=y
 CONFIG_UML_NET_MCAST=y
 CONFIG_UML_NET_SLIRP=y
 CONFIG_EXT4_FS=y
-CONFIG_REISERFS_FS=y
 CONFIG_QUOTA=y
 CONFIG_AUTOFS_FS=m
 CONFIG_ISO9660_FS=m
-- 
2.42.0



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
