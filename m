Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E31CD1283
	for <linux-um@archiver.kernel.org>; Thu, 28 Mar 2024 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ZM+pq/GSSG3w0acZya1FsmZ0mi5CZ9pgRopR/Q9rxU=; b=PMUVvioK8KIh2h5wC/yB+UUSuk
	QOHK5aLs9livlyuV/SCv+z5xCy1Kalgn7bdAvU2eNh0l3r8k7mGlg1eFfb1lHqC8fiZDGnE5/cMBV
	P0ljFlofx1tIN4LT5UXoqJeTQSIw0cAZXr8RUEfW45QM1xT3p5nCk3B/hGaZtVU7DvU2+yxL1RPNC
	S4GG3IV4sP4unRxAYHR2ulUcC8Cf8wtQXgFb++anPsrp8K9yoZMuvHtnMBAlypkmGD/iDFHIJd+64
	7Pz6338OvOiA6V5AIrO4g5TT7IFXyWnIJpW77G2HMDl9SSwjhWnJEkABJpeo2L7p+5NJwKUYih32z
	MjbmCrhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplnX-0000000DFWt-2I38;
	Thu, 28 Mar 2024 09:11:47 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplnS-0000000DFUT-1vZw
	for linux-um@lists.infradead.org;
	Thu, 28 Mar 2024 09:11:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2ZM+pq/GSSG3w0acZya1FsmZ0mi5CZ9pgRopR/Q9rxU=;
	t=1711617102; x=1712826702; b=m/snCPN31VLgNKW/2SgDpNZ40B5bUTfZZspTtu27eZmbT2T
	V4SZDb7/7mBCfx/BdSAAFk+C62kSAvD3WtjWjbczcLz7aUDfSXxGJCNzcH0Y3r7wkphZ/HimE2lX0
	oVgh0MIjrjuMRuPLR32ux+hP5Zrl3RHTPtANMkCas9drvTuFYAMu0XjTuqAkcLb5P9jg+39AYdhlD
	N9tMuUp63Ir4x66kDdqv2HxLaHXbAOcxG2soU570BuLRC8TR+eq8MUis6MvVQ7OQR24Y8h2zWCRhy
	LD2tms2DLymDSwKr7bN9JVDFeEJbRy9RAJAWFwlYYyIBIG9IsNX+RhTLQs+yLsyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplnP-00000000oe8-2ZiD;
	Thu, 28 Mar 2024 10:11:39 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/5] um: slirp: remove set but unused variable 'pid'
Date: Thu, 28 Mar 2024 10:06:35 +0100
Message-ID: <20240328100640.93259e4a5f81.Iedc5c3ffb2c7b09c74ef096c42fb55b624a13931@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
References: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_021142_646053_8A86F0B4 
X-CRM114-Status: UNSURE (   9.06  )
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

From: Johannes Berg <johannes.berg@intel.com>

The code doesn't use 'pid' here, just remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/slirp_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/slirp_user.c b/arch/um/drivers/slirp_user.c
index 8f633e2e5f3d..97228aa080cb 100644
--- a/arch/um/drivers/slirp_user.c
+++ b/arch/um/drivers/slirp_user.c
@@ -49,7 +49,7 @@ static int slirp_tramp(char **argv, int fd)
 static int slirp_open(void *data)
 {
 	struct slirp_data *pri = data;
-	int fds[2], pid, err;
+	int fds[2], err;
 
 	err = os_pipe(fds, 1, 1);
 	if (err)
@@ -60,7 +60,6 @@ static int slirp_open(void *data)
 		printk(UM_KERN_ERR "slirp_tramp failed - errno = %d\n", -err);
 		goto out;
 	}
-	pid = err;
 
 	pri->slave = fds[1];
 	pri->slip.pos = 0;
-- 
2.44.0


