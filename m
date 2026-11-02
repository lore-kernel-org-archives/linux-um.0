Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68326070249
	for <linux-um@archiver.kernel.org>; Mon,  2 Nov 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MdyjX/CM;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTKJcNWG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8QCucuYZDNmVJaqyrDFn0TUDlr5eGhlHKy/r+vN8wLA=; b=MdyjX/CMACc4qL
	udEtXdC7t4+QTgVHCXNg5LbwJS0K8dBF2nF8bfULZAnySBNojlnpGM82lZoVqF3EuQAoC6BX5ZWnD
	yOopngqocWQLoSOGmiQGUyz38x8mq1EUVVVuM6tSowM2skAF3QWBua4hA/ctvEGpAm6FuJpO9bBho
	9hzCUHhvWJuVttc4BXCWPCa/s6Hp3lfpaRZPSQ9GYMTUfy7Mr6sD8O3KoPnvNIanWjeHfKwIzf0V+
	BElkqH9i1tOybLwB27pmwvYkZkUa73fwpahJOpWXVt0uNfJXJ1S0/A7beRPFlv0jqVAblnzD5Kqcd
	AYTNR3s1vDu2BR+a3SNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNt1g-0000000Gpcc-2VMh;
	Mon, 02 Nov 2026 14:28:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNt1e-0000000GpbI-3QYh;
	Mon, 02 Nov 2026 14:28:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 90DC74386B;
	Mon,  2 Nov 2026 14:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA321F00A18;
	Mon,  2 Nov 2026 14:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629722;
	bh=8QCucuYZDNmVJaqyrDFn0TUDlr5eGhlHKy/r+vN8wLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eTKJcNWGC9V6irm/9DKKTQuZ13M+/P1en2BQ55yGY+lnmUDRqciw/Rf2PsHx9OoY0
	 buVb9lCjc5j1j+zVE00+8lE+7EIBrkA/7gY7pAiXO36HsFOR8TPuUiDrZTExwthr5Q
	 g2ntrsvA0FRDkX0DqkVI2R0zq637sI1kyS8+kikVTIf/hcY+oSRxJ/YR+1Xg+xR/Sp
	 aqNRXFGzdUJn5XBZWThM4MbuyB2ZEPnFIDc98ztB3FY2A2pzEfLhWTVFohA37ZdeKD
	 CBtYkQwAlSwOguLYUrqoxdDzbhzJby7zBKRKI64hRz0r7REL/5ePc9HqUQM4L5ULRF
	 akeGwQAgSlDqQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:21:45 +0100
Subject: [PATCH RFC 30/38] powerpc/pseries/lparcfg: return h_get_ppp()'s
 status as a long
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-bugfixes-v1-30-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, 
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-cifs@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org, 
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, 
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-debuggers@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KaAFx5Z9JEYFTwMkBWfFQWs2ORbRuBTJUi5MCRtyyf4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9mJOTxjOPK/q1b2ZgvpS2omCxgaLdOpGttm2Lmc8Xv
 BU/7jG7o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJJ7xgZGrU/qMj0nPKcWMLS
 d31xjeSx7XF/+lkE6y6zn7F2uXs3h5Hh2IQtWpWPJy1y5bu073hy0q9fd7PiLBl/7MisOXdm0pI
 kLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

h_get_ppp() returns the status of the H_GET_PPP hcall as an unsigned
int. update_ppp() hands it on as its ssize_t result, and
lparcfg_write() turns the hcall statuses it knows into an errno and
returns anything else as it is. So when H_GET_PPP fails, say with
H_PARAMETER (-4), the status comes back as 4294967292 and a write to
/proc/powerpc/lparcfg reports that many bytes written.

Return the status as the long it is. lparcfg_write() then treats it
like the status of H_SET_PPP and an unknown one is at least negative.
Before commit 11529396ea31 ("powerpc/pseries: Split processor
entitlement retrieval and gathering to helper routines") a failed
H_GET_PPP turned into -EIO.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 11529396ea31 ("powerpc/pseries: Split processor entitlement retrieval and gathering to helper routines")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 3280b7968cab..aa9b5b141434 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -113,7 +113,7 @@ struct hvcall_ppp_data {
  *	          XXXXXX - Entitled procs capacity % available to the
  *			   partitions pool.
  */
-static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
+static long h_get_ppp(struct hvcall_ppp_data *ppp_data)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
 	long rc;

-- 
2.53.0


