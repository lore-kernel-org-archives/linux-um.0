Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F834CD5BAC
	for <linux-um@archiver.kernel.org>; Thu, 21 May 2026 13:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIIxiknLSHVZBHNOKlLgNSXxWTGeUxPYBjk6/bNkxVs=; b=tE56bNjI0E2g8Aj9aYxLBDD8Mq
	+2SmZ6XY+RopcPHrArOu6bcMJJbZWfoJL/JmBJr6/la3lyuZw4/PHMDUA/AREY8KKJF+Yfccw1wu8
	Q2nYxtaKx8ctWYJwb2ujbf73Yll9NtKn5CLHTg4v74IXoxBuh4nN8bCyASwrzWzqTX6qWt3Pkm8BP
	Mj5vTHxyJEl48ll2fGdY2kqJVQimNL3vKt6qyu2WTkH2iUvy1tVd/ZCsVYMuJEsgfJm5MZvNGBmvr
	PYYu5YQOL+VQ0/gvGckz2+/FWFtU1vsQHOUp19M3QT9zdRqQ89ofWGrJJE9vmzXOWki7Dfkb/4jJx
	4F92Fqcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3Wm-00000007uFm-3gdE;
	Thu, 21 May 2026 13:33:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3Wj-00000007uD9-1ek8
	for linux-um@lists.infradead.org;
	Thu, 21 May 2026 13:33:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E19D34460C;
	Thu, 21 May 2026 13:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9C71F0155A;
	Thu, 21 May 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370406;
	bh=xIIxiknLSHVZBHNOKlLgNSXxWTGeUxPYBjk6/bNkxVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7Ykfcvp0h6C12Jt7BShNBYGEpfAXvBIAx55A0+93dBwBTPwWMwDWRrO5isUznkhU
	 itctVylBMPCseJ9S3+reU25bfhnxLGs81ROGkHDrSKeWpg/Rez1y63/E0p0lUE95MZ
	 f/u4MnqyDBhhEHDleXISBtEDS8S6m8ZqoBy++9FLbj+QOoOdhCrl4GIXgLtDV0fnor
	 mdHdAkA0VigFdnzXd0I0EUKIL42pTjUoBNZrx7zwWr/eWeE294mHLH60nGc7HBVsnN
	 mHi84Fj8xXC12VUh1R1/Dg14UV22HTZGInV0oKdkocpJo9YXz5btVupLw70hiUfFNW
	 gaqKIygTuUjnA==
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
Subject: [PATCH 03/11] moduleparam: Add DEFINE_KERNEL_PARAM_OPS macro family
Date: Thu, 21 May 2026 06:33:16 -0700
Message-Id: <20260521133326.2465264-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3674; i=kees@kernel.org; h=from:subject; bh=3qCwRbQEn6qV8q9ahXLM93O2aOukjHk7G2WsPfFNfHo=; b=owGbwMvMwCVmps19z/KJym7G02pJDFn8nAuull67+C5txg2e1YGCbPvcujb6Wx/JN/xsvCs3x vgezzqPjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkYvWZkOH+4UFL72GLVDkfh BLNPz5NZzv2JWSzlWpkxwSTGt4VrNiPD9r2rxE49blEzn3CRa4uBQPBb6Zti6VkbO1blT5RSdFv EBQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_063329_474549_86E7799D 
X-CRM114-Status: GOOD (  16.38  )
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

Add macros that define a struct kernel_param_ops initializer through a
macro so the underlying field layout can evolve without touching every
call site. Three variants cover the three cases:

 DEFINE_KERNEL_PARAM_OPS(name, set, get) // basic
 DEFINE_KERNEL_PARAM_OPS_NOARG(name, set, get) // set KERNEL_PARAM_OPS_FL_NOARG
 DEFINE_KERNEL_PARAM_OPS_FREE(name, set, get, free) // also set .free

Callers prefix their own visibility qualifiers, e.g.:

  static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);

Also update module_param_call() and STANDARD_PARAM_DEF() to use
DEFINE_KERNEL_PARAM_OPS internally so the generated ops table will go
through the same macro as everything else.

Subsequent commits convert all open-coded struct kernel_param_ops
definitions to use these macros, in preparation for migrating to a
seq_buf .get API.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/moduleparam.h | 36 ++++++++++++++++++++++++++++++++++--
 kernel/params.c             |  6 ++----
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 075f28585074..26bf45b36d02 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -68,6 +68,39 @@ struct kernel_param_ops {
 	void (*free)(void *arg);
 };
 
+/*
+ * Define a const struct kernel_param_ops initializer. Callers prefix with
+ * any required visibility qualifiers (typically "static"):
+ *
+ *   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
+ *
+ * Routing the @_set and @_get function pointers through the macro
+ * (rather than naming the struct fields at every call site) lets the
+ * field layout change in one place when callbacks are migrated to a
+ * new signature.
+ */
+#define DEFINE_KERNEL_PARAM_OPS(_name, _set, _get)			\
+	const struct kernel_param_ops _name = {				\
+		.set = (_set),						\
+		.get = (_get),						\
+	}
+
+/* As DEFINE_KERNEL_PARAM_OPS, with KERNEL_PARAM_OPS_FL_NOARG set. */
+#define DEFINE_KERNEL_PARAM_OPS_NOARG(_name, _set, _get)		\
+	const struct kernel_param_ops _name = {				\
+		.flags = KERNEL_PARAM_OPS_FL_NOARG,			\
+		.set = (_set),						\
+		.get = (_get),						\
+	}
+
+/* As DEFINE_KERNEL_PARAM_OPS, with an additional .free callback. */
+#define DEFINE_KERNEL_PARAM_OPS_FREE(_name, _set, _get, _free)		\
+	const struct kernel_param_ops _name = {				\
+		.set = (_set),						\
+		.get = (_get),						\
+		.free = (_free),					\
+	}
+
 /*
  * Flags available for kernel_param
  *
@@ -311,8 +344,7 @@ struct kparam_array
  * kernel_param_ops), use module_param_cb() instead.
  */
 #define module_param_call(name, _set, _get, arg, perm)			\
-	static const struct kernel_param_ops __param_ops_##name =	\
-		{ .flags = 0, .set = _set, .get = _get };		\
+	static DEFINE_KERNEL_PARAM_OPS(__param_ops_##name, _set, _get); \
 	__module_param_call(MODULE_PARAM_PREFIX,			\
 			    name, &__param_ops_##name, arg, perm, -1, 0)
 
diff --git a/kernel/params.c b/kernel/params.c
index 752721922a15..2cbad1f4dd06 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -222,10 +222,8 @@ char *parse_args(const char *doing,
 		return scnprintf(buffer, PAGE_SIZE, format "\n",	\
 				*((type *)kp->arg));			\
 	}								\
-	const struct kernel_param_ops param_ops_##name = {			\
-		.set = param_set_##name,				\
-		.get = param_get_##name,				\
-	};								\
+	DEFINE_KERNEL_PARAM_OPS(param_ops_##name,			\
+				param_set_##name, param_get_##name);	\
 	EXPORT_SYMBOL(param_set_##name);				\
 	EXPORT_SYMBOL(param_get_##name);				\
 	EXPORT_SYMBOL(param_ops_##name)
-- 
2.34.1


