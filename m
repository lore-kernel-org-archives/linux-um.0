Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C27C71153
	for <linux-um@archiver.kernel.org>; Sun, 10 Sep 2023 23:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-version:Message-id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1jGoiy0lPY+Z7s9W5vl/jcr4mlp2941MDHtSb+9HvPQ=; b=mMs7s6ge2ogrdq
	7XgLSwBbQg6eMEcJkV44ob9rL01SegRc5Ch9UAz3uTUh+0HYKZYlDttSJsUUDJC4uIGEVCzmovcwb
	x/3qU22/ufZ+X80+lF66KY2BmqeM10AGOHUPxDOliOezySPo9IG3jRTQgAzXYUNwq5QvVxb7aeH6D
	Su9/gvJPsMUJlCjIQuBXmOki58bxW33+/l12B/P2ueSEd9OSYwYveDvTjf5e85lr6/OV5hkU1idqo
	qUTsSdoBSdLtH04CSaRrDRlLqq0kB2VaMz/NOHlW43CdlDjuiGDIUWlRi9aZDXPIN5qXOoUICshg5
	gI1lj7hpWeW6nptWaQ3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfTpc-00GyeN-34;
	Sun, 10 Sep 2023 23:27:08 +0000
Received: from aib29gb127.yyz1.oracleemaildelivery.com ([192.29.72.127])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfTpU-00Gydo-0p
	for linux-um@lists.infradead.org;
	Sun, 10 Sep 2023 23:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-2023;
 d=n8pjl.ca;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=+QmQ39qJAAicmUv+YuxOplwYcssmPoT+fv3BqZix0gE=;
 b=cMBY11lBX3zAl4jH/9XHe1TshHdQ0BSWyowOIHEDdyieM9cMzLpSPK6H9YanHCUCejmMOunI9bsK
   NUCeaD+3x8l4ldoP8dhLEvcm9sImjxNB75pXo8CNP85B+2xhoIV/VcEYOmoQqNsAZBHBqDJYmPR/
   mCHIFOflhAbPEVcdBrw9iNMY8Xb5U3OojMZLPwszO/qmcu3AuwLQcZDPznOTJbrZeAhCLeuI+OP1
   R71zhBxnOaslxHng6s3oWyt6PCJJvLUmTW3M7yljwjE2PP/Kr6hXU6vdjsX4+vUYMseUmN6Zwli0
   N+l+SNK7TlBSdx1H8V17aU40g4f16uWwMq9wqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-yyz-20200204;
 d=yyz1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=+QmQ39qJAAicmUv+YuxOplwYcssmPoT+fv3BqZix0gE=;
 b=bDiI1zNIoUk8cjiNkOEbdjZuVYqPE7B7uX8RRd9Dj8jyktH4NuOZlssx0OOxWl6dk6WH/IzcFfnY
   jKMddOsImgfCBFMKsqEoyLWp9/cklz51VkcWezVZjDQ27FYy+NBAaZr+DgURHL1/ac7F5KJ66+2w
   LSCk+vU0oKr1CqSwjDsqE5OPR3mPfaeHlTDiMIT2LMyJ84vl3eAkLPv/i40jnsVbsPg1cwmjVBeL
   5u+jeSvaxvNfPHtHTUYoBCj+qdpdL2GyHfpvzhlhwWWhv/Lzi+6CQIE0ngmWprNA6F6AxcybDvQK
   F4NIZxrxZLfgDMKAa7E+fHs0pv/b1IZKITBCbw==
Received: by omta-ad1-fd3-402-ca-toronto-1.omtaad1.vcndpyyz.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230808 64bit (built Aug  8
 2023))
 with ESMTPS id <0S0S00DPAMGQKE40@omta-ad1-fd3-402-ca-toronto-1.omtaad1.vcndpyyz.oraclevcn.com> for
 linux-um@lists.infradead.org; Sun, 10 Sep 2023 23:26:50 +0000 (GMT)
From: Peter Lafreniere <peter@n8pjl.ca>
To: linux-um@lists.infradead.org
Cc: Peter Lafreniere <peter@n8pjl.ca>,	richard@nod.at,
	anton.ivanov@cambridgegreys.com,	johannes@sipsolutions.net,
	reiserfs-devel@vger.kernel.org,	jack@suse.cz
Subject: [PATCH] um: Remove CONFIG_REISERFS_FS from defconfig
Date: Sun, 10 Sep 2023 19:26:39 -0400
Message-id: <20230910232640.113938-1-peter@n8pjl.ca>
X-Mailer: git-send-email 2.42.0
MIME-version: 1.0
Reporting-Meta: AAFqYSi/Nz3yT+WmCCacHVh+wGgnWcRssPo3r9AOwMYpK0BBDia596AYNaQBaKkJ
 65vPtlWjwOBoyR5SC1xUcTzSX7EZjvCw1Yvjp7TseWvXLDFypw21eL0trGljk8tv
 MP3Z1CDe1RbQ1eRgtq132ADejtzQvW3xKCN1dbola2RGj8T+JNYnB8KLmV6iKR6M
 ValMu6JmPYMe66ZbN+ODn11LRZWyFf0VUkFKHvfphGlhr+EaXPeUx6cWBBW8k8pC
 Ezyh4Rgb+AK7lylcrduWWrwUvCT34tsi8kIqd+2WQuTgrcD4MdOPnDR+I28zQa/3
 953LEazspv65ga+DGg+62p26f1OOnXPlhKP09KJtv+ffuXViRb2yrWXKUXDfti5v
 WdNQSEy45mW0asQRnTvTCTWx5Amm5yMxljosKz0AYYnUR/IFScN86DSi3yS0ria9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230910_162701_221655_D93D1F58 
X-CRM114-Status: UNSURE (   6.21  )
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
