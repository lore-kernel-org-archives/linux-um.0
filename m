Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D7ECD5BBF
	for <linux-um@archiver.kernel.org>; Thu, 21 May 2026 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mj7DVCvMStdFPb34OrcUAAH1hWW4OYzU+C7hp9VpbjY=; b=wUoRHBIL1+FhSJ16Faps+/g88M
	vLAN470G0rr2KqasP9aXtT4sS124lK/GxQ4DErrxs7CVyxztYlorLfV/D/q9+R/uG6SWq6iFc0z25
	oimwf8NJOdWAz/emDodbZ/9/N5d5ONtpcqnwku5LkHhxHOuwvHhIGUvyf/haZdxmeBcnUdF34GWrN
	TZMpvCZ+7TSr+tiowS1B09B+7Fe/HBO0aWDKFnk6xO0x/UsY8itxE8o4B1cLc5LErsVKD4O0RVOfW
	uZ8HxkdK5+rbzxi1DJdJEOv8R090ktUE+zR0wf0Oqto63DEsJATbJWFInSThHe2cLE11ApUYHsmN1
	jygC/GJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3Wr-00000007uJM-2BT0;
	Thu, 21 May 2026 13:33:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3Wl-00000007uEY-43cn
	for linux-um@lists.infradead.org;
	Thu, 21 May 2026 13:33:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B203445E1;
	Thu, 21 May 2026 13:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38751F00A3E;
	Thu, 21 May 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370406;
	bh=Mj7DVCvMStdFPb34OrcUAAH1hWW4OYzU+C7hp9VpbjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eL7P5sQOnRUqovuCINXrhkkCMFQg4gJz9lHl+mo5l/7tWzuLIYX1MykUtmft4cIo2
	 M+FcdXMoQ4rswOfqo73Od6nx4/NZcLe4hChmGlU7e8EHcktUR9bbKkyMDXjIyfyf9B
	 eV78dkZWgUFtYC1qxRKZKBtpzjNh1YNv+xYbvGb/59goFKFuu3NOIeGjgRpvSgtIPo
	 8ivmmDGfUlUajD9Xi2Zb0jv40IpLIkZ1zlVqLGUDtdGxm942GdK2191iVOUAdgY/d9
	 LkEDqWs4BcK2jEMPeiyQHLfliXA1m2lVAX62EVolUfTIC9T8HiuTytz5hngxpheUFV
	 LHEYk2tMnbFvw==
From: Kees Cook <kees@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	kvm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	qemu-devel@nongnu.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 06/11] moduleparam: Add seq_buf-based .get callback alongside .get_str
Date: Thu, 21 May 2026 06:33:19 -0700
Message-Id: <20260521133326.2465264-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3696; i=kees@kernel.org; h=from:subject; bh=T4N6FoAPN5e2cqvWSGS7oEs1xiLk99wdr1LKck0ur78=; b=owGbwMvMwCVmps19z/KJym7G02pJDFn8nIs2HH8iHuPEcem9X7HM2rJrS2LZVs8vP/M+reLdF K3trxtfdZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExEwZOR4alreLoXi13roV/i 9/tfrbvsVLZZb2L3Qh33TS8N1v2/U8fwT//2x1KTz9OUg91P7LvT39NrdVL4qeIHRzc9ZcnAHRc /cgAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_063332_046561_9ACCF99A 
X-CRM114-Status: GOOD (  23.64  )
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

Add a new struct kernel_param_ops::get callback whose signature
takes a struct seq_buf instead of a raw char buffer:

  int (*get)(struct seq_buf *sb, const struct kernel_param *kp);

The previously-legacy .get field is now .get_str (char *buffer);
.get is the new seq_buf-aware form.  param_attr_show() prefers .get
when set, otherwise falls back to .get_str.  WARN_ON_ONCE() if both
are set.  Return contract for .get:

  < 0 : errno propagated to userspace; seq_buf contents discarded
  = 0 : success; length derived from seq_buf_used()
  > 0 : forbidden; the dispatcher WARN_ON_ONCE()s and treats as 0

The default policy on seq_buf_has_overflowed() is silent truncation,
matching scnprintf()/sysfs_emit() behaviour.  Callbacks that want a
specific overflow errno can check seq_buf_has_overflowed() and
return their preferred error.

No callbacks use .get yet; the legacy path is still the only one in use
after this commit. A subsequent commit teaches DEFINE_KERNEL_PARAM_OPS
to route initializers by type.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/moduleparam.h | 13 ++++++++++++-
 kernel/params.c             | 26 ++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index f5f4148e2504..c52120f6ac28 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -7,6 +7,7 @@
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/init.h>
+#include <linux/seq_buf.h>
 #include <linux/stringify.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -62,7 +63,17 @@ struct kernel_param_ops {
 	unsigned int flags;
 	/* Returns 0, or -errno.  arg is in kp->arg. */
 	int (*set)(const char *val, const struct kernel_param *kp);
-	/* Returns length written or -errno.  Buffer is 4k (ie. be short!) */
+	/*
+	 * Format the parameter's value into @s.  Return 0 on success
+	 * (length derived from seq_buf_used()) or -errno on error.
+	 * Exactly one of .get and .get_str should be set; the dispatcher
+	 * WARNs and prefers .get if both are.
+	 */
+	int (*get)(struct seq_buf *s, const struct kernel_param *kp);
+	/*
+	 * Returns length written or -errno.  Buffer is 4k (ie. be short!).
+	 * Deprecated: callbacks should implement .get instead.
+	 */
 	int (*get_str)(char *buffer, const struct kernel_param *kp);
 	/* Optional function to free kp->arg when module unloaded. */
 	void (*free)(void *arg);
diff --git a/kernel/params.c b/kernel/params.c
index 6852caea1785..4eda2d23ddf2 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -553,12 +553,34 @@ static ssize_t param_attr_show(const struct module_attribute *mattr,
 {
 	int count;
 	const struct param_attribute *attribute = to_param_attr(mattr);
+	const struct kernel_param_ops *ops = attribute->param->ops;
 
-	if (!attribute->param->ops->get_str)
+	if (!ops->get && !ops->get_str)
 		return -EPERM;
 
+	WARN_ON_ONCE(ops->get && ops->get_str);
+
 	kernel_param_lock(mk->mod);
-	count = attribute->param->ops->get_str(buf, attribute->param);
+	if (ops->get) {
+		struct seq_buf s;
+
+		seq_buf_init(&s, buf, PAGE_SIZE);
+		count = ops->get(&s, attribute->param);
+		if (count >= 0) {
+			WARN_ON_ONCE(count > 0);
+			count = seq_buf_used(&s);
+			/* Make sure string is terminated. */
+			seq_buf_str(&s);
+			/*
+			 * If overflowed, reduce count by 1 for trailing
+			 * NUL byte.
+			 */
+			if (seq_buf_has_overflowed(&s))
+				count--;
+		}
+	} else {
+		count = ops->get_str(buf, attribute->param);
+	}
 	kernel_param_unlock(mk->mod);
 	return count;
 }
-- 
2.34.1


