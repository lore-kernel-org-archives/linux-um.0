Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0777CDB482
	for <linux-um@archiver.kernel.org>; Wed, 18 Oct 2023 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dMjmsKh8Ykz15ELcoKl2cnplrh5Re5Yl5J0E1piMJ0E=; b=xCsy7iJ6FxCHme
	ABBQZEWJkwJR8JSb8bbWFWWmqGVP1pNmwizm8QH+eVlKxg5/jiNoAkRiSBf4VLXz888dFqJtDMQup
	b8HbLu72ifoxh4xeBTZarjDq82wHJesfbM21+e/Brye+emRFrDi3pB075NK1gPSL9pgBnW0yNUazt
	9H4IMYABXQuvDtW3YT8ghv21BXetnU1NqUeVjFNXJZgVQE1Si3o2tVlusrxCTE9ZjtQO1oii4wTfR
	mJU0qW65uSOrY5hdORo8bZl8qE22FMCJVOrLHOSNWUMfGD1mTEcSr0frbSKncFj1goekWfPU9AANR
	iWBPBTiIVNZixPfavk+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt5nJ-00Eg3g-1K;
	Wed, 18 Oct 2023 12:37:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt5nF-00Eg1B-1H
	for linux-um@lists.infradead.org;
	Wed, 18 Oct 2023 12:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZVzXtDh3PmoDHU/k1yKEWokaugjQz13Ytv0HThHXJH4=;
	t=1697632617; x=1698842217; b=VVHXHlviaEYoHofMayup6/iykT4jHnRmf8zZxTGS0hW2ps/
	XaMuPl/iRjVYyJSkJidqdUbhoMre8sc9553VqOtKoFrZF1+OUV2WTFTW36Bba7hueQmcEiGkSDur9
	L6avOxiM+9IFR1Qo/QN8Bz8CIqsg2rtvTqDBD4FNbGwyYuFNSXsTA+GSpKGZZHMcRIRmJ6547MayA
	7WKg5on00e2fd8z5SF6jJv4DEWfgx/uFq8kqC8Cv5YeifIQkerS9+vZqS4eANhls1DrUEGQ3BhkqS
	KSuMiOE4UGY89eUw/w8lIdo4AC6D0ZgEigfqMbY4i0OJ+oY0iPw74sYkWnVpqkEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1qt5nD-0000000Bo1V-2jWy;
	Wed, 18 Oct 2023 14:36:55 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/4] um: chan_user: retry partial writes
Date: Wed, 18 Oct 2023 14:36:42 +0200
Message-ID: <20231018123643.1255813-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018123643.1255813-1-benjamin@sipsolutions.net>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_053657_430947_F7850A6F 
X-CRM114-Status: GOOD (  12.44  )
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

In the next commit, we are going to set the output FD to be blocking.
Once that is done, the write() may be short if an interrupt happens
while it is writing out data. As such, to properly catch an EINTR error,
we need to retry the write.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/chan_user.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 29c68820522a..339aae56b6f1 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -37,11 +37,23 @@ int generic_read(int fd, char *c_out, void *unused)
 
 int generic_write(int fd, const char *buf, int n, void *unused)
 {
+	int written = 0;
 	int err;
 
-	CATCH_EINTR(err = write(fd, buf, n));
-	if (err > 0)
-		return err;
+	/* The FD may be in blocking mode, as such, need to retry short writes,
+	 * they may have been interrupted by a signal.
+	 */
+	do {
+		errno = 0;
+		err = write(fd, buf + written, n - written);
+		if (err > 0) {
+			written += err;
+			continue;
+		}
+	} while (err < 0 && errno == EINTR);
+
+	if (written > 0)
+		return written;
 	else if (errno == EAGAIN)
 		return 0;
 	else if (err == 0)
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
