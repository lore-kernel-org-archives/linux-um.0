Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C5606A320
	for <linux-um@archiver.kernel.org>; Sun, 22 Nov 2026 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1Vvhvn4M;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl78x+Zb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=nS1Wyq0+teU+0NPEh7FueTOvVWx377NaWwBlgjjiVaM=; b=1Vvhvn4MX16Dh9c40U4I6NSu2q
	1eoHKqeyhNlSEAkk4mpe60+sgfTF70d+4Sru1Zhpn7n6+ErgLOLpIaxP3ADDfSNkTIfkU5/deJVOW
	J2RgE6rf2VQ9fbwlYJkFF23AYHDtHyHDZbBOPFmxmrJ+4jOUUlEfXUWQ9vW67M3vAF00kINbkXsiy
	XsNL1paPbsqAH4sW1zPYLGE4Vkn5mSQgoW7UFIuq5uY9bzY1RPBk0Ea1agcLaxpjAapruBIKV5rvJ
	nXY2RhLOYv816RNbCWt1pwdXytCCoGlPrx3u2asi0MM5tZFKWL41/uLwioqzMEGMV3e2uI2j9SyIL
	ObW4RtPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV6oy-000000016O0-3FRX;
	Sun, 22 Nov 2026 12:37:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV6ow-000000016Ns-3sSx
	for linux-um@lists.infradead.org;
	Sun, 22 Nov 2026 12:37:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6079861884;
	Sun, 22 Nov 2026 12:37:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795351045;
	b=AUzRbPBd9jJZFrJv1WeJZC1I4/xGQj7pny4FOAF6KqckiJ52L5KdVwpEn4PolxdUKMyH
	 Rwtq2TbpWNPfrG//vOe/DW3tzJRSGxjuTLfBgXM/F3C6wob6CB/ENKAHLKkWXOe+YLja1
	 SHxM6WpLzwo6a10rVlvN5kJgntqfgoEZeW4/8E4VHNimuYRgfywOBEvVncTftjCbN649P
	 qfBBSrvSVGiu/601HOPyPti2s/kHJto/tTxTfgFFOFLt4NoVh3MJC5zvzKtmTavSBWPuu
	 cMXIBt6XakQSF5M3CZNcT1t5vCe5GjIi598KPDDOebWSizlxfurVfGkl1/QoWEziivA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795351045;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=nS1Wyq0+teU+0NPEh7FueTOvVWx377NaWwBlgjjiVaM=;
	b=K7tCC1YGjI2rwWkDwKaRjZo27YHjM2Ljqk5iKGGMpeShoZjJlyxwUNItxU5Pw+M8fxfR
	 ufO8vC8RglNqw0nnQe9IBCEWWJA0Kz3R17P/+hmmp6RVRpMYALCB+jhePr+084TcJJA8U
	 gQDi6t5GO399OxaHy56q3tqZ0Aa6cnzFEuez6dzxV75Iyy2BShPfpfGiWqRZFfdbo/OEZ
	 CK7BS1DAfI98svb84hIT88y7sWUprdRb8Mvhuz9u41LwENuu3fzLXl54noU6RvXW6sH1h
	 2TmgIWkB7cUHUDEl6Idc6aHl8l73BhdxQIQ49x6EpvwpsL3lFO6Jp5rpkaPf0nin8CA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0F8791F000C4;
	Sun, 22 Nov 2026 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795351045;
	bh=nS1Wyq0+teU+0NPEh7FueTOvVWx377NaWwBlgjjiVaM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Pl78x+ZbHLXHOA1CeaR/tzviB4YaDS+6f87Lem7hbHRv0kr1bUGwZea5Ba+cxjuj7
	 eBqE1KRv0UgRt1DX/ohPYjwtYVfODUd3hHirHgPLXo1XKu36G35kUfV8wAEufkqFcf
	 DdXKbl/wo9RUD4tZ8ox7QfTCBKbSksWKHq98ZYk1ASHz6PjRwR0GMH4iPB0v8XRmUH
	 XIiBiKQj93kMlxu7pkgAfIje0MaYxcEqzA3TFnqhbx8Wenx+xWYX04mgGzZflO4iOx
	 ks1fLHKqrsmj/V2FtMqtlQ+I8dqOGi5srfm/B0RndVSrJro/FY3LDAIos95sfChP1K
	 vpSumRDB7Dvjw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 90BDB4C02B;
	Sun, 22 Nov 2026 12:37:14 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 12:37:14 +0000
Subject: [PATCH] um: line: Free the read IRQ when the write IRQ request
 fails
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-uml-line-irq-v1-1-64b525cf8d2f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPnhAmsC/yXMyw5AMBCF4VeRWWui4+5VxMJlMELRIhLx7orld
 5LzX2BIMxnInAs0HWx4VhbSdaDuS9WR4MYa0MNISkSxT6MYWdldr8JPieIYkyCUCPayaGr5/HJ
 58dvs1UD19jbgvh/S+U5ncAAAAA==
X-Change-ID: 20261122-uml-line-irq-39ee77284512
To: johannes@sipsolutions.net, anton.ivanov@cambridgegreys.com, 
 richard@nod.at
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795351033; l=1580;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=EbX7KODF5wd8UgFNPa78Kwlbo1tt/cnAoI1sKqIv8xo=;
 b=aJAuyN16nWR2Vppc4QoXL1GhbRI+Pv7Eg/ats+Kvd4l/cImMnwPfjvpR06CzeWnvnPwoXf2QL
 Y3JSi2SS7ULCUub3MVqA8RxPuGPJQ+hWe5hFPWJyFhlzGLh8hJmiyf9
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: shyckless@gmail.com
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Suyuan Wang <stevewong@hust.edu.cn>

line_setup_irq() requests the read IRQ first and then the write IRQ.
If the write IRQ request fails, it returns the error without freeing
the read IRQ. Its caller, open_chan(), then calls close_chan(), but
close_one_chan() only frees the IRQs of a channel that is enabled, and
the channel was never marked enabled. So the read IRQ stays registered
for an fd that close_one_chan() then closes.

Free the read IRQ in line_setup_irq() before returning the error.

Found with a static analysis tool and checked by hand.

Fixes: d14ad81f800a ("uml: handle errors on opening host side of consoles")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested with ARCH=um (W=1, no new warnings); the failure path wasn't run.
---
 arch/um/drivers/line.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index c851a592809c..5589fa68871e 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -273,8 +273,12 @@ int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 		err = um_request_irq(UM_IRQ_ALLOC, fd, IRQ_WRITE,
 				     line_write_interrupt, 0,
 				     driver->write_irq_name, data);
-		if (err < 0)
+		if (err < 0) {
+			/* the caller won't free it, the channel isn't enabled */
+			if (input)
+				um_free_irq(line->read_irq, data);
 			return err;
+		}
 
 		line->write_irq = err;
 	}





