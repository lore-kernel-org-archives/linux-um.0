Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBAEC4332F
	for <linux-um@archiver.kernel.org>; Wed,  4 Jan 2023 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yfCQ0s6/czwDSi8LIfSrqLi53F/4jEsTKrKU8IBqdSc=; b=gWl8CUi0i2V5AU
	/XmeDcgbf0S+f5Ya5/5K00IoVgq8gJfTsxX2x6OKlms0fA8Xuah7AIgoKXx0cd+dAr4Kv+PnAdGDa
	5dRrFcMV+dvQOlr0HcgGYr1IpzEl7/SKVjm/euZKCCMDRjaBJhx2CzBdiyZND9LZJqx9gSWLIVjSz
	w+wR5rrl1iMDpIg8Ar153YUz29UskiXRAQ27/v0IVJ5Gh8y6kRBxjvIV9g51RhUWTo9VviLLSIkdK
	8EII1SRDrJGzfDoPAijXPKDGCa68zUoumkqYF1dJoWZB9hjgtwhrJbL7z+ZPamQaBHoqXYxd2zUWU
	LzIk9ROi7LWedDbWiYmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD6Uf-00ALt9-86; Wed, 04 Jan 2023 16:19:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pD6SD-00ALGi-9S
	for linux-um@lists.infradead.org; Wed, 04 Jan 2023 16:17:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8AD7C617AF;
	Wed,  4 Jan 2023 16:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9D9C433D2;
	Wed,  4 Jan 2023 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1672849044;
	bh=28ckKiyj9m0vg3THgDlgJYCvyX5Xu6g7B6dQBS8gd2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTnfd8rTB0nkbSXvABRkWGFn4gPolfFhGtW15d5FvL4f/+nqVKI4LZMPoasTyZK5q
	 1/UxMkvM7uIBsq3O4A8m8qYaNniymab8W22mdaOEQNULv+7dU5yZC0EHx13dYTOMoF
	 SnC0oObVuguPNX57tvnGdEh5CrqqZk/0rua9lBF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	linux-um@lists.infradead.org,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.1 124/207] um: virt-pci: Avoid GCC non-NULL warning
Date: Wed,  4 Jan 2023 17:06:22 +0100
Message-Id: <20230104160515.842647496@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104160511.905925875@linuxfoundation.org>
References: <20230104160511.905925875@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230104_081725_494098_D757A826 
X-CRM114-Status: GOOD (  13.79  )
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

From: Kees Cook <keescook@chromium.org>

commit bdc77507fecd00ddad2f502f86a48a9ec38f0f84 upstream.

GCC gets confused about the return value of get_cpu_var() possibly
being NULL, so explicitly test for it before calls to memcpy() and
memset(). Avoids warnings like this:

   arch/um/drivers/virt-pci.c: In function 'um_pci_send_cmd':
   include/linux/fortify-string.h:48:33: warning: argument 1 null where non-null expected [-Wnonnull]
      48 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:438:9: note: in expansion of macro '__underlying_memcpy'
     438 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~
   include/linux/fortify-string.h:483:26: note: in expansion of macro '__fortify_memcpy_chk'
     483 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
         |                          ^~~~~~~~~~~~~~~~~~~~
   arch/um/drivers/virt-pci.c:100:9: note: in expansion of macro 'memcpy'
     100 |         memcpy(buf, cmd, cmd_size);
         |         ^~~~~~

While at it, avoid literal "8" and use stored sizeof(buf->data) in
memset() and um_pci_send_cmd().

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202211271212.SUZSC9f9-lkp@intel.com
Fixes: ba38961a069b ("um: Enable FORTIFY_SOURCE")
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: linux-um@lists.infradead.org
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/drivers/virt-pci.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -97,7 +97,8 @@ static int um_pci_send_cmd(struct um_pci
 	}
 
 	buf = get_cpu_var(um_pci_msg_bufs);
-	memcpy(buf, cmd, cmd_size);
+	if (buf)
+		memcpy(buf, cmd, cmd_size);
 
 	if (posted) {
 		u8 *ncmd = kmalloc(cmd_size + extra_size, GFP_ATOMIC);
@@ -182,6 +183,7 @@ static unsigned long um_pci_cfgspace_rea
 	struct um_pci_message_buffer *buf;
 	u8 *data;
 	unsigned long ret = ULONG_MAX;
+	size_t bytes = sizeof(buf->data);
 
 	if (!dev)
 		return ULONG_MAX;
@@ -189,7 +191,8 @@ static unsigned long um_pci_cfgspace_rea
 	buf = get_cpu_var(um_pci_msg_bufs);
 	data = buf->data;
 
-	memset(buf->data, 0xff, sizeof(buf->data));
+	if (buf)
+		memset(data, 0xff, bytes);
 
 	switch (size) {
 	case 1:
@@ -204,7 +207,7 @@ static unsigned long um_pci_cfgspace_rea
 		goto out;
 	}
 
-	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, 8))
+	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, bytes))
 		goto out;
 
 	switch (size) {



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
