Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27010CD5BD1
	for <linux-um@archiver.kernel.org>; Tue,  2 Jun 2026 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ezV5ICAM2va0jVjd8iAniGdLxBSb69xxnF1gv2JwpSY=; b=HRqKtafjVrKryatEVtqizcuatP
	TGzT5lnV8y/sb2DReEs42KKUgjPzxJlexoOgfUmqUKMROGO9kY8SkdP0PP6brrQqXxMjTTXGRUfm9
	vOON6QlOre/SgIGp7RXvHcxs3t7lzU4ZPKj0elXTRiKGnyjl3WHAVYoxLU1FslH9ZDemOFxTgyIU/
	xr8+xthb6bI6Xhi1Q4P4//FfjwSBcBEJQV/WcJ0BJIN1K021vsPjrq+GEx27S77HhFUXuufyC3eYW
	v0UNC8wWIHANBKiDEcMUJj9GZprG0o0IqkY+8iLFMyHldTjnkoyv8lLwEEf9FcDdfaMJmUrBOlGo9
	vbrhPr2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUPKa-0000000D7vC-1zri;
	Tue, 02 Jun 2026 13:38:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ3Wi-00000007uCR-23x1
	for linux-um@lists.infradead.org;
	Thu, 21 May 2026 13:33:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A25643D68;
	Thu, 21 May 2026 13:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664AA1F00A3C;
	Thu, 21 May 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779370406;
	bh=ezV5ICAM2va0jVjd8iAniGdLxBSb69xxnF1gv2JwpSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j4CDviTd6M6LDTj5r6sQRqgJ6ESa9aWMu37zRV8mtOcXrJiE1zLL6x/OVHUw7taNB
	 jl6ETIYiu8JAkRBqc4Wuv2aB534ln8Hu69MX1fb2GFClu2Mmurr/zb532bCHmICyRT
	 bW4gGDuRH21kbO4Mt3QzAC1BgrPy+si2Rjb35ZfN4nboZAY9y9toARiousj3e/bp3M
	 OhVS9wgD8OvUpe6jIOQ+pq818okRHEEM5Lah2/H+GkNEe7+pCkBUV/HEs3jXEYS4f4
	 MtCRjjIGdmkPubfqUsmmCsve0nsahQ5jfKPmPGh0P3LHoWU280OP0E1I4NEEZgAN1h
	 MDV3MyE2qhaxQ==
From: Kees Cook <kees@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@vger.kernel.org,
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
Subject: [PATCH 01/11] params: bound array element output to the caller's page buffer
Date: Thu, 21 May 2026 06:33:14 -0700
Message-Id: <20260521133326.2465264-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=kees@kernel.org; h=from:subject; bh=3eO38ZdE0rbljlF5l/QfEOapKDQ3GxlJmKbxHXugskI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFn8nAtqmS7cf3B//69jZ5rrq6va9p3fNOGM7h2Jd74Pn JTCV6u3dZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzEYiojw//ne8uu9YZ9+sWp mJ7czDyrP2Afv+2f21+/99yL9Jp+OI2RYVNeQ9witS6BzPe55aerW/eveRmS81ixc8XMVftPpj7 OZQAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_063328_574821_7CCBECF7 
X-CRM114-Status: GOOD (  18.62  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 06:38:56 -0700
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

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

param_array_get() appends each element's string representation into the
shared sysfs page buffer by passing buffer + off to the element getter.

That works for getters that only write a small bounded string, but
param_get_charp() and similar helpers format against PAGE_SIZE from the
pointer they receive. Once off is non-zero, an element getter can
therefore write past the end of the original sysfs page buffer.

Collect each element into a temporary PAGE_SIZE buffer first and then
copy only the remaining space into the caller's page buffer.

Cc: stable@vger.kernel.org
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 kernel/params.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 74d620bc2521..752721922a15 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -475,22 +475,36 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
 static int param_array_get(char *buffer, const struct kernel_param *kp)
 {
 	int i, off, ret;
+	char *elem_buf;
 	const struct kparam_array *arr = kp->arr;
 	struct kernel_param p = *kp;
 
+	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!elem_buf)
+		return -ENOMEM;
+
 	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
-		/* Replace \n with comma */
-		if (i)
-			buffer[off - 1] = ',';
 		p.arg = arr->elem + arr->elemsize * i;
 		check_kparam_locked(p.mod);
-		ret = arr->ops->get(buffer + off, &p);
+		ret = arr->ops->get(elem_buf, &p);
 		if (ret < 0)
-			return ret;
+			goto out;
+		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
+		if (!ret)
+			break;
+		/* Replace the previous element's trailing newline with a comma. */
+		if (i)
+			buffer[off - 1] = ',';
+		memcpy(buffer + off, elem_buf, ret);
 		off += ret;
+		if (off == PAGE_SIZE - 1)
+			break;
 	}
 	buffer[off] = '\0';
-	return off;
+	ret = off;
+out:
+	kfree(elem_buf);
+	return ret;
 }
 
 static void param_array_free(void *arg)
-- 
2.34.1


