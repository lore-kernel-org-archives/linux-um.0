Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20747C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 10:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P5HkgcwWSB+VBqVrzWsm5Ly58AiNgXE2oyKFzhJuTV0=; b=cc5iFbrYZH3p5rxHcGpzoQhEta
	d0ys6Hy3Of059vODSG9IMpgcjuvGG3AEnZ0pZD5V/TGnMyLIj0udG6+lFTYLspd5VHhFlowLPFU3b
	GhEaRWYcOcFl1qtayh+0zbEg5L+b6yQ3vMW2IfcRKjeO25k+lrhyKPPtbt1ISgn7Y2/PhQHH3jPeC
	xMQOEimM21pV4OndPf+WZ95tXq7jAWzMFo5cjz8ycjdcMK6T56R+Sw0nMdq3+Xjx+rYeuxoRmxjcK
	61ZWiwuycCvBVE5uAEgBztRS6ZOgy2P5sMA93/bVAj4CoVDB4Jem3Y8L71RPK3VjvfMkBJR1IgVBd
	bhCQj1DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJa4-0000000CrNX-1Y2r;
	Thu, 04 Jul 2024 10:20:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJa1-0000000CrN1-2mmu
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 10:20:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=P5HkgcwWSB+VBqVrzWsm5Ly58AiNgXE2oyKFzhJuTV0=; t=1720088445; x=1721298045; 
	b=OVK5Tkuocpb7jMkEBnnMi+yOHk5aPb7IBrk6PabQxLRPw+xbID3GTMhYvPHyt5JUa8Pg/HyJvTh
	uMY428Z4O3SBjrSr2P55Gu8DRM3CQQgIobXdaTlUAE5tqv27s4cg1dB7tdg1BHq3YyZrq61ENiTWV
	X81ARQonw+ZBZIsks/hUOQz64fPiRQljGH4ivxCHZmy4gvVK8gsOgD4F7FKa6bobAtSWmmQ1zniI+
	pUpe51CZMQLsum+ZcMe+nbg0NWouzDgnAqVlhRDzEK6mbLLBWQ78ITcjr2+F/qzH4Q/8VbKuRTzU4
	3OKGkxSY99DpH5kqEiBZC15+Uh33YHIM6g9A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sPJZy-0000000CTNW-1QbT;
	Thu, 04 Jul 2024 12:20:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] um: remove variable stack array in os_rcv_fd_msg()
Date: Thu,  4 Jul 2024 12:20:36 +0200
Message-ID: <20240704122035.789b679b263c.I17235f263887dfd4bde6c5d5f132f974bd2f756f@changeid>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_032045_724679_9213E25E 
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

From: Johannes Berg <johannes.berg@intel.com>

When generalizing this, I was in the mindset of this being
"userspace" code, but even there we should not use variable
arrays as the kernel is moving away from allowing that.

Simply reserve (but not use) enough space for the maximum
two descriptors we might need now, and return an error if
attempting to receive more than that.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407041459.3SYg4TEi-lkp@intel.com/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 5adf8f630049..f1d03cf3957f 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -528,7 +528,8 @@ int os_shutdown_socket(int fd, int r, int w)
 ssize_t os_rcv_fd_msg(int fd, int *fds, unsigned int n_fds,
 		      void *data, size_t data_len)
 {
-	char buf[CMSG_SPACE(sizeof(*fds) * n_fds)];
+#define MAX_RCV_FDS	2
+	char buf[CMSG_SPACE(sizeof(*fds) * MAX_RCV_FDS)];
 	struct cmsghdr *cmsg;
 	struct iovec iov = {
 		.iov_base = data,
@@ -538,10 +539,13 @@ ssize_t os_rcv_fd_msg(int fd, int *fds, unsigned int n_fds,
 		.msg_iov = &iov,
 		.msg_iovlen = 1,
 		.msg_control = buf,
-		.msg_controllen = sizeof(buf),
+		.msg_controllen = CMSG_SPACE(sizeof(*fds) * n_fds),
 	};
 	int n;
 
+	if (n_fds > MAX_RCV_FDS)
+		return -EINVAL;
+
 	n = recvmsg(fd, &msg, 0);
 	if (n < 0)
 		return -errno;
-- 
2.45.2


