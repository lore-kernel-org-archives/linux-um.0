Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F78DC41513
	for <linux-um@archiver.kernel.org>; Wed, 18 Oct 2023 12:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hQ5lv7/Ko7Ozv3fqUNdC1gQ84iYiNnifhZslHiPgft0=; b=k9lqUXJNlZS9Eh
	i+PfXDJ8Oiqrn2Ko9Wxb2aCVX1iDWv/zfhCT+c6gUgafkHowvF7zRqiZs10m+AdDvvioho7Ct3wt6
	zlz20uGLrKBu4jqovuPkKZLxGmGpcKHdwWG104Mjy0fHDd8LUk44UF4dMI0H32ZBO5Fiiyvu/B4Fo
	f8+o5n0OeoQHdum5kJ702Ejn59YBDaaRY++uFTjxiV0MeFZXR/cjKJ8OxFPCoTQ1BlY+XD9mGBkKD
	hDiVbiHYYSNPZ4HJFyqzdkHCnd7HgZGChYrmAvRdLLOYmPK/GaK4c2jAVDrJ2rpUIR5XFgv/2Cymu
	5EFNU2qUE2zBG9CvOKlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt5nJ-00Eg3w-2T;
	Wed, 18 Oct 2023 12:37:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt5nG-00Eg14-1u
	for linux-um@lists.infradead.org;
	Wed, 18 Oct 2023 12:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q1BmknCBL/yQO2Xrd0cjBKupVqUkFC+5wO8f3I4HGD4=;
	t=1697632617; x=1698842217; b=pWDHdBuLhtv6iLQVSK10lLQUa5s4vOf/sWfXqHkmoc+8sKb
	wOfWsV2XGvK9QIaGO1NWPWiXUU3ohg/9X4h1vzWKWCTJ1lOMPUEys9iKYb9Wx8BL70PM9TM0YkYJf
	I73JRGi5i9PrSLJbOFuC4tI4eeB3M725a3dcbpcTukN8MFDSRnWVHJAQRBB3dYL5zBh+nzJ2aJntz
	o1+95gGsRcxjxvyizONE63q4UA9FI39NqAwu6wMAWbhunVcdHtwCifzDb3ZbnSC4WaZW7KfQP76ur
	BZvhdUgXw22agu6tv/cJ5OyiiHz7TGJBAYlLt78tie8slGkfV4s415R0piHp5qUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1qt5nC-0000000Bo1V-1sJ3;
	Wed, 18 Oct 2023 14:36:54 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/4] um: chan_user: catch EINTR when reading and writing
Date: Wed, 18 Oct 2023 14:36:41 +0200
Message-ID: <20231018123643.1255813-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018123643.1255813-1-benjamin@sipsolutions.net>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_053658_627944_8C65E419 
X-CRM114-Status: GOOD (  11.06  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

If the read/write function returns an error then we expect to see an
event/IRQ later on. However, this will only happen after an EAGAIN as we
are using edge based event triggering.

As such, EINTR needs to be caught should it happen.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/chan_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 25727ed648b7..29c68820522a 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -23,7 +23,7 @@ int generic_read(int fd, char *c_out, void *unused)
 {
 	int n;
 
-	n = read(fd, c_out, sizeof(*c_out));
+	CATCH_EINTR(n = read(fd, c_out, sizeof(*c_out)));
 	if (n > 0)
 		return n;
 	else if (n == 0)
@@ -39,7 +39,7 @@ int generic_write(int fd, const char *buf, int n, void *unused)
 {
 	int err;
 
-	err = write(fd, buf, n);
+	CATCH_EINTR(err = write(fd, buf, n));
 	if (err > 0)
 		return err;
 	else if (errno == EAGAIN)
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
