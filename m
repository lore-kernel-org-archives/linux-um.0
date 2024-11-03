Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB084D1118C
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 21:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FDQyZtyn7RqHuwp7BG/nxiLYcH8B+EamgD+1gnFWyr4=; b=1eyr3quN5XU3u+oZ1CcLy2yyVf
	+mf7L8UA5UbXbMDjQ91JA7Bd3hOL18bp6Fhl3qFZG8ZA2zu8NOHDdpbGTxUAt65KFpEa0zlnxQYdd
	N4l91FN9734wVpWf/9z+JLmCOriqx8nv02Z0hj0+J7bloGtGO/6qSiXnlyjha4T3AcrWVRL/GNpcY
	4nViB2WucSjgDpeCpgKzZ/771veNxzPgiLLYds0Nj4QY4qE9dEvZbIbBn0vY95NnvneWOFxgJ2PFD
	tybHHmhhej1B3dDzSZmgY/mUqWsbLLsuDC4GYJuqoC/AfZc8KzNWFFLYS/ALGTZ1SZXFs+pnhplvt
	4UNhPyeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7iBK-0000000C4R9-0OWO;
	Sun, 03 Nov 2024 21:30:46 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7iBG-0000000C4QB-0iSg
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 21:30:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=FDQyZtyn7RqHuwp7BG/nxiLYcH8B+EamgD+1gnFWyr4=; t=1730669441; x=1731879041; 
	b=ByYUq1bKrBUouXM0BijnMV56FbPUDK63yS4B4/9vRUQKAblbotnJ6ar7y8VJXp0pHeu3Weq/bgk
	0aEBxZ8OnPg/g6B8FbaUW9CVZAlRJaTUQj/cIqK4gdNsRmCOeHrtMyV7iy4UsSQaBemJsvVfF8FIB
	X655vQ/SkUcPoW539xKsfuFExg4mui78FC73GgGenqdEt+j84mIg/ls+SgpdMEtQpeIp7jn7D7/PX
	S077yamBrOz6XN+3yr6yJPYK5xCFyfv+hp52MvqADEIoSNNN75qFK5bp6QTo4brurae7+wiIDZPDU
	wynvSPb7RSx7pvZ6/ghC+Otlt/UcQYMXcM/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7iBC-0000000DCdx-2awD;
	Sun, 03 Nov 2024 22:30:38 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/4] Enable virtio-fs and virtio-snd in UML
Date: Sun,  3 Nov 2024 22:28:50 +0100
Message-ID: <20241103212854.1436046-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_133043_626761_6CDC9764 
X-CRM114-Status: UNSURE (   7.44  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

With these changes, both virtio-fs and virtio-snd seem to work fine. The
feature to query the number of vqs is not really needed, but I already
had the code.

You can for example boot a machine that has both by executing something
like the following:

 $ virtiofsd --sandbox none --socket-path=/tmp/vfsd.sock \
             --shared-dir / --announce-submounts \
             --tag vfs0
 $ vhost-device-sound --socket /tmp/vsnd.sock --backend pipewire

And then simply launching a UML VM directly from /

 $ ./linux mem=256M init=/bin/sh \
           virtio_uml.device=/tmp/vfsd.sock:26 \
           virtio_uml.device=/tmp/vsnd.sock:25 \
           root=vfs0 rootfstype=virtiofs

If you want to do a quick sound check, you could e.g. run the following
commands. The mount just avoids alsa configuration from the host to be
picked up, which might have configuration to use pipewire by default.

 # mount -t tmpfs none /etc
 # arecord | aplay

For me, this works fine on F40 (virtiofsd is installed in /usr/libexec)

Benjamin

Benjamin Berg (4):
  um: virtio_uml: send SET_MEM_TABLE message with the exact size
  um: virtio_uml: use smaller virtqueue sizes for VIRTIO_ID_SOUND
  um: virtio_uml: fix call_fd IRQ allocation
  um: virtio_uml: query the number of vqs if supported

 arch/um/drivers/vhost_user.h |  4 ++-
 arch/um/drivers/virtio_uml.c | 53 ++++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 9 deletions(-)

-- 
2.47.0


