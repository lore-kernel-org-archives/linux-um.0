Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BAB606B0E5
	for <linux-um@archiver.kernel.org>; Mon,  2 Nov 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=J7zE4aZU;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIoUwWZI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lzi0v2Iw6r5Nf2GLOsMSQBwdPNX93e2TzGzGfD3oQvk=; b=J7zE4aZU6IA063
	hB/8uZFvH8fjj8o90KD+aXpWg1/68RPEK/g/LnUlZHy/hKPeUw5k/j0p4+solLev7V1aeDK+cc8S+
	QoBhbv8hP8ryy8zFC+WfHxnTmbfYnOECKCUwytWW8wyafp1sGHjTFaVR/J9h2A28kwfAcAFFiGqcx
	Xk/i376PTA2rHSDd8DjIbBSckmFmgpaAL27nMEw/T6poq/boqp28+2kkIX8aEpiu8Um1OSKfPs+mW
	dPH6wFpWMhrrgPgH6XQWNvmw1IjbYDoX1sPmRFbiNGc5JmuKHHiAC97nb8s+V2C8fOK2csnVnslnL
	ahMota7uvbl2dgBOUs9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtdY-0000000GzLJ-2Gcr;
	Mon, 02 Nov 2026 15:07:52 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNtdV-0000000GzKM-40Fe;
	Mon, 02 Nov 2026 15:07:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B1FD84378E;
	Mon,  2 Nov 2026 15:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6921F00A18;
	Mon,  2 Nov 2026 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632069;
	bh=lzi0v2Iw6r5Nf2GLOsMSQBwdPNX93e2TzGzGfD3oQvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kIoUwWZIZJmPIDGcbCqUMn+ysgkkYH4B9KIOKwQcxHvHBenqGMDwfSExIyruQhbFw
	 GSvSuGXqLlsS/+2bX4zY15r68FSJdvY7PhgxxV9bnP9Q3PrAcl12NmKthDnezkWdzA
	 YQcdsHreaTBVFGkt5/ixU0O685iwRTrAmT2xH295OHXHJaGkHJFEIXEMqGqXCeqbKp
	 nkpHGaPfZ7GY12qU7tMKJN88syBFW289W+duXDc1qru1IIyFkTan4orRc22NIVl3pP
	 G9JHqYUFv0jVxFqVlQXSQgnsHBo0FeNBeFWC+sINyeJMsGIfziINB34GYCGOVyuJWO
	 tkxpbHP0pDc6g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:01:45 +0100
Subject: [PATCH RFC 18/22] macintosh/via-pmu: let procfs copy in writes to
 the options file
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-arch-v1-18-c9492ab08480@kernel.org>
References: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
In-Reply-To: <20261102-work-procfs-arch-v1-0-c9492ab08480@kernel.org>
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
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
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

Implement ->proc_write_buf() so procfs copies in what is written before
it pins the entry, and parse the option from that copy. Writes larger
than PAGE_SIZE - 1 bytes fail with -EINVAL now.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/macintosh/via-pmu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 49f929ae10e4..079c085be5d2 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -913,7 +913,7 @@ static int pmu_options_proc_show(struct seq_file *m, void *v)
 }
 
 static ssize_t pmu_options_proc_write(struct file *file,
-		const char __user *buffer, size_t count, loff_t *pos)
+		char *buffer, size_t count, loff_t *pos)
 {
 	char tmp[33];
 	char *label, *val;
@@ -923,8 +923,7 @@ static ssize_t pmu_options_proc_write(struct file *file,
 		return -EINVAL;
 	if (count > 32)
 		count = 32;
-	if (copy_from_user(tmp, buffer, count))
-		return -EFAULT;
+	memcpy(tmp, buffer, count);
 	tmp[count] = 0;
 
 	label = tmp;
@@ -958,7 +957,7 @@ static ssize_t pmu_options_proc_write(struct file *file,
 
 static const struct proc_ops pmu_options_proc_ops = {
 	.proc_show	= pmu_options_proc_show,
-	.proc_write	= pmu_options_proc_write,
+	.proc_write_buf	= pmu_options_proc_write,
 };
 #endif
 

-- 
2.53.0


