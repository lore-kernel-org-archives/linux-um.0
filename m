Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406B6C52D7C
	for <linux-um@archiver.kernel.org>; Tue, 13 Aug 2024 23:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dbtX85OIvDZqZDvoebC/8Rwcxt4sIKvuHnf821Q6cFk=; b=TpI8dQ0VZe1NQiKdB/v77JziYo
	rIOn2FU0RfImnoQ5SuP3KqT0D78zzsvCfathlykVUVlmowjw37n/YLSgluVnLbyk9zXtAAXGgxho4
	VfukJbozU08WOCAAFAhbmpMjeuqsRmrqZGWGI2vKLAJWM6luOOF+uP/d1c1c61Tpu+KP4BjpI+gom
	N1u9kr/X6VZM4XHGeWnCAwbUqogxtqA2a9VJQbH/oqSTZJGxk3C1A4Ib1sk4d7tvtQtHvbk1SxpXB
	M4Kz7TGl0kbLqCJCHqmBcbiC5aKOi7xYNZnjnv/tXWIfQIaJmw5JmewFWFIetyczmswiWA2GtdB8d
	2M67elOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se1FC-00000005DdJ-44QL;
	Tue, 13 Aug 2024 23:48:02 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1se1F9-00000005Dcn-39mF
	for linux-um@lists.infradead.org;
	Tue, 13 Aug 2024 23:48:01 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso10631607276.1
        for <linux-um@lists.infradead.org>; Tue, 13 Aug 2024 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723592878; x=1724197678; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dbtX85OIvDZqZDvoebC/8Rwcxt4sIKvuHnf821Q6cFk=;
        b=pMrGPMpf7NPPd/gQhGyTrH8zqnUVeiiaaVCCB2d0m3/d8nt+Do6YgyBcSatnVUiO4N
         MuLRRx7RERtggAJqyqMmY2FWzDTcUcvELMsu9ZioVwoVyLJgc/slK5jt4vX48EwCmDgj
         f9kXjymoAOiQZiG2DVoiXZI0zZd9mEAlLIYoFewYVyDDAXSb4more3a9pF7sIvGAwUX/
         B7ihYtVapss4I+F3nMpblVoTRMugFLj7vYEVXIOuVEVbwiNWVJf++dmbtW3nsgw8EIR2
         3yJdsrLx7AGQS7mDdUfgprDoWF5daise/u57Exkx9CER6UhW8p8Bkr4CI3R1PfHRCIBu
         VTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723592878; x=1724197678;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbtX85OIvDZqZDvoebC/8Rwcxt4sIKvuHnf821Q6cFk=;
        b=reVkyCaqZvLpbE9AJui4tLsW4CKYQ+s8x6VOPNj9l7uh6nbVyz5sPZLIxXSgGGlGc7
         BOvo4mIitWPijcJBC3+L3Y0rofhvoyzo8lj/QZx2PC8ktfYCqoSuOBvndR5Ecpuq3+NR
         sio0bAmlpZSYKBVDBBz4IfyhvFXQRr2kYDMnEhTxJrjJGuXcIU9XlRkBz2WTgp5DkK/q
         eG8l3/m0nMKfeuMxmTwyVlfVaMaPBBjPqzfgWavYNEojTL1mjtfWT50RXVFQCthIcOMO
         bY4S7LuQXhhewauH6NgJahgvLsF5A2Y//wF895s+3mZi2cT4ywGw4VbNaZhj1D077EQj
         MbGw==
X-Forwarded-Encrypted: i=1; AJvYcCVRXQlRyPH6FOAAhYb7Qqhpii1ENqxNjNbK9DiHqVb1CEneAPbt64FJlYcfbO2KTLQkFuf7oRQCLBn0BHSwVgOM2xip96kExWMDW7nl
X-Gm-Message-State: AOJu0YxT0tkS2yGkOXk1wwau9Qg08CpVPOqtJBFA4KisU83j36EQvsrW
	SC/u4+aWsEw5jMHkS+DTBwUUR3iPUIrI4ezytN9sIseBeC4MVJwWbfh3fRVWdDnujyWdkw==
X-Google-Smtp-Source: AGHT+IGrjD1ml7A/TNR6lQFgx73bBKn21UdMK+Yp53+uTqPz9PLiWm/B6ur1ScVNlYzKlitVe/qxgYCP
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:7199:1729:2be2:5cf4])
 (user=maze job=sendgmr) by 2002:a25:cc3:0:b0:e05:f565:6bd3 with SMTP id
 3f1490d57ef6-e1155bbe9dfmr1591276.12.1723592878254; Tue, 13 Aug 2024 16:47:58
 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:47:55 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813234755.3615697-1-maze@google.com>
Subject: [PATCH] um: make personality(PER_LINUX32) work on x86_64
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_164759_845597_9CB02922 
X-CRM114-Status: GOOD (  12.40  )
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

Without this patch:
  #!/usr/bin/python3
  import ctypes
  import os
  personality =3D ctypes.CDLL(None).personality
  personality.restype =3D ctypes.c_int
  personality.argtypes =3D [ctypes.c_ulong]
  PER_LINUX32=3D8
  personality(PER_LINUX32)
  print(os.uname().machine)
returns:
  x86_64
instead of the desired:
  i686

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 arch/um/include/asm/Kbuild   |  1 -
 arch/um/include/asm/compat.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/include/asm/compat.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b2d834a29f3a..0b961dd089ab 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y +=3D bpf_perf_event.h
 generic-y +=3D bug.h
-generic-y +=3D compat.h
 generic-y +=3D current.h
 generic-y +=3D device.h
 generic-y +=3D dma-mapping.h
diff --git a/arch/um/include/asm/compat.h b/arch/um/include/asm/compat.h
new file mode 100644
index 000000000000..110319031dcf
--- /dev/null
+++ b/arch/um/include/asm/compat.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_COMPAT_H
+#define __UM_COMPAT_H
+
+#include <asm-generic/compat.h>
+
+#if defined(CONFIG_UML_X86) && defined(CONFIG_64BIT)
+/* From arch/x86/include/asm/compat.h */
+#define COMPAT_UTS_MACHINE     "i686\0\0"
+#endif
+
+#endif
--=20
2.46.0.76.ge559c4bf1a-goog


