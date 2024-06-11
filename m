Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4EAC27C65
	for <linux-um@archiver.kernel.org>; Tue, 11 Jun 2024 19:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=J3UtuCqDgO+FUcqbXedj2B4aQ9vmXFoB4I0RO6m6E5c=; b=cXYXkXxo4YK9AOLIET3xNtaum5
	vH2Yo9ZdvdGbPcrgFUHdmaKao7jytpxUfHiE2Jx/tOexoGB5HhX/hD1fh55f+NPS3tINPN6SJmbi9
	WS7pDjMmoYqh8NSOCNPzi2LdxZe8OTx9DYLacSuDmcjTMnaCYPmFDKpRsw2H2TeADSlXiu6+ricMU
	LGYoCGJQ7/wWv9GmcVMzv5cG4cWCGmYr7qe0ihK8cSvld8Lhw88kZNUVPR9nd6l4dFy4mWJqN/+yq
	998E3/5z0fskCgyqL2x4JuG3p9Q34anwGXjTTeuXvlT9zlxR93cw9g8sbx3lRs6/1WSrtic3TUkY6
	UW97hZ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH7dx-0000000A6XS-32NH;
	Tue, 11 Jun 2024 19:58:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH7dv-0000000A6Wy-2PkK
	for linux-um@lists.infradead.org;
	Tue, 11 Jun 2024 19:58:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BE04261179;
	Tue, 11 Jun 2024 19:58:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3D4C2BD10;
	Tue, 11 Jun 2024 19:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718135934;
	bh=lXlj/SstpuQpKJCP8HW5gJ3hni3Cit4VvKRlRHAAa4w=;
	h=From:Date:Subject:To:Cc:From;
	b=iu7BhgprMOv8XOaBfONHSAx1MZ0tsPJvlJh0PSsKLcpKkvgMQaxkQIQ86soxxL3SQ
	 2LAtx8PSkRMasS+eya8sp7MhyF9H0KkMVLzX3GvYdfpkwmmbHS6cpIzhiCu/yQkJID
	 IGf/ZY6x25hnmb7NC9gW7Vr13tdaLUxr3clTbdbicHIndhtALLVDVC8Qpa3TefzCjK
	 6ckg+gWMWtx2TzB3vkyqHkp/amtXkKuZGS5q96mHtJz4RXz4F+9rB++s588SWhB11h
	 scVLUExz8DwgB6N+MwkOADpUblBoNfunvxk5lNr3WcaktmHElxEa63j74V3PcMSjGD
	 +AYBDUEHbsrRg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 11 Jun 2024 12:58:41 -0700
Subject: [PATCH] hostfs: Add const qualifier to host_root in
 hostfs_fill_super()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-hostfs-fix-mount-api-conversion-v1-1-ef75bbc77f44@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHCsaGYC/x2NSwqAMAwFryJZG7BV/F1FXJSaaha20qgI4t2tL
 gfevLlBKDIJ9NkNkU4WDj6ByjOwi/EzIU+JQRe6KmqlcAmyO0HHF67h8DuajdEGf1L8XGxLmoz
 ubFM5gvSyRUrbvzCMz/MCkc5BuXEAAAA=
To: Christian Brauner <brauner@kernel.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=nathan@kernel.org;
 h=from:subject:message-id; bh=lXlj/SstpuQpKJCP8HW5gJ3hni3Cit4VvKRlRHAAa4w=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGkZa2qXOP7YIvwhTFa/7j7T7FabE9Yrc+KesvFMm8IZr
 z/zu8LXjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRakZGhuPcM21muJdM8fRa
 GZci717ov/I9l+LbadwzdI9NWDHvvw3DP/0Xe9pduV3ZpZM44zasq9ui6CO+2dTb3ffBDEMvQS0
 ddgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_125855_697702_AC2633A9 
X-CRM114-Status: GOOD (  11.45  )
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

After the recent conversion to the new mount API, there is a warning
when building hostfs (which may be upgraded to an error via
CONFIG_WERROR=y):

  fs/hostfs/hostfs_kern.c: In function 'hostfs_fill_super':
  fs/hostfs/hostfs_kern.c:942:27: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    942 |         char *host_root = fc->source;
        |                           ^~

Add the 'const' qualifier, as host_root will not be modified after its
assignment. Move the assignment to keep the existing reverse Christmas
tree order intact.

Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6ec3c368d7bf..e44747bbfe87 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -938,8 +938,8 @@ static const struct inode_operations hostfs_link_iops = {
 static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct hostfs_fs_info *fsi = sb->s_fs_info;
+	const char *host_root = fc->source;
 	struct inode *root_inode;
-	char *host_root = fc->source;
 	int err;
 
 	sb->s_blocksize = 1024;

---
base-commit: cd140ce9f611a5e9d2a5989a282b75e55c71dab3
change-id: 20240611-hostfs-fix-mount-api-conversion-83eda29c74fe

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


