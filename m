Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04666CCA476
	for <linux-um@archiver.kernel.org>; Mon, 13 Oct 2025 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JRdH5OWjRWxrNcJ0VKmKwoWlo3oISFAAE4kf8Dl0jEE=; b=NKJDtjhqiydTCU
	0UpE8g8bHCxmm7oD3cEmfMrJradPEVtY67Waltycxh3d1FI/IQ8pN0KgNMyT1klzG22gfn240RN3L
	SuaBkBGdtjJKM4IKh6VsPUpNMG7Gwfa5y5gv2Dh5DxVNtI/FhJc4gj2kce7woMEqlBY2moctaECs8
	jlZ/8c0UdbYe4M241bbI5yzralpp9zzDoMXcMqwmbMtcMF4QyJlzD+L/ME0EOE9yrNMkQRPQJQ8Ol
	clcQV/Bfb/JcZ/FKHr4o94Gwh0QDNCQQzBVGqONCsoEV7+7eXy7a1lIDLA6JSWWaKm2G0ROqvC0Zj
	UMFLimEDDdkvHywk+S5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Fyi-0000000Cv71-3D3F;
	Mon, 13 Oct 2025 10:40:32 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Fyf-0000000Cv59-3S1p
	for linux-um@lists.infradead.org;
	Mon, 13 Oct 2025 10:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760352023;
	bh=Mrb4l4VwFe57hHJrtEKqjD7k2DRvwUiyKeXgdYmWW80=;
	h=From:Subject:Date:To:Cc:From;
	b=jqRitX9VURvOh/X+D6KmLllRbR5qXzGLVkVNbzpzPiqNe5YqZwKjDbJMOCU9FShYX
	 hGXwBx0vuSGkPhOiaLj4ENKrBfEMQ4HV8E9du1RvIQVQsSScJW+Fz7SCvv4bTvVQyl
	 9zZu9gHGZkyUPyeIUuS2Vxuds/J28MBWMjms7w9c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] x86/um/vdso: Cleanups
Date: Mon, 13 Oct 2025 12:40:17 +0200
Message-Id: <20251013-uml-vdso-cleanup-v1-0-a079c7adcc69@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABHX7GgC/x3MMQqAMAxA0atIZgNRUdCriIPURAO1LS2KIL27x
 fEN/7+QOConmKoXIt+a1LuCpq7AHKvbGXUrhpbansaO8Dot3lvyaCyv7gpI1MhAJGJEoGQhsuj
 zL+cl5w/8o6FsYgAAAA==
X-Change-ID: 20250930-uml-vdso-cleanup-001f600ffcff
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760352023; l=731;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Mrb4l4VwFe57hHJrtEKqjD7k2DRvwUiyKeXgdYmWW80=;
 b=2WLmEd+A409WrKyYOGq7GyoCqX0zwTKy8RyVV4NIe9KNr8PVNUVCeI8I+19FqeJU3UNOhdnOg
 dW1JMehNlvOB+lWb5U7l4dhkbn7QdSToim7BF/DXiB6Eur8LPvU6HaY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_034030_018340_12C051F2 
X-CRM114-Status: UNSURE (   4.50  )
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

Various cleanups I stumbled up while looking at the UML vDSO.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      x86/um/vdso: Fix prototype of clock_gettime()
      x86/um/vdso: Use prototypes from generic vDSO headers
      x86/um/vdso: Panic when vDSO can not be allocated
      x86/um/vdso: Drop VDSO64-y from Makefile

 arch/x86/um/vdso/Makefile  |  7 ++-----
 arch/x86/um/vdso/um_vdso.c |  8 +++-----
 arch/x86/um/vdso/vma.c     | 12 +-----------
 3 files changed, 6 insertions(+), 21 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250930-uml-vdso-cleanup-001f600ffcff

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


