Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D2DC636CC
	for <linux-um@archiver.kernel.org>; Tue,  7 Feb 2023 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=q/0GFR/QD4kRO9+e4pdwkbxlbPZq9EI2gj0EOBK15no=; b=3naEcSLhGiwUIe
	F/NOnXbb4GZYJP0/a68Flv8N5SfYwv+z8if4y8uq+5SV7wG+1hXnl04bMVtjCYuEmaCLavTLZ4c9d
	+REehL3QX3jhQHcKcaANjo9IcNBLUblqbao5ozB7LGaMTSyYH7bQpkMTtnYZTKjqIpYd2iD5gDUyu
	7wJbyHnG1dG1xaITiiWhWlxWWA/YefZ8Q6IEkFN5VDfZ9ffiVGzdBX2v1+tLD2VEeKZieH5Qi9GTn
	7kbPTeUELZbBhgdZoY9lGX3cp9aHpbrGxLWfDPOzwo+ABtlPdkH3h+4LHtcDONcTRsct8vgMaFRw+
	w10BOd99t9GOVzLHFKyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPR3X-00CqOz-Er; Tue, 07 Feb 2023 16:42:55 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPR3U-00CqNQ-Cy
	for linux-um@lists.infradead.org; Tue, 07 Feb 2023 16:42:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AEA67B81A1D;
	Tue,  7 Feb 2023 16:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9818EC4339B;
	Tue,  7 Feb 2023 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675788166;
	bh=/VdpoMtMa66d53ADOA7T8FLFwQUFmoaRRMXtxeZ3tF0=;
	h=From:To:Cc:Subject:Date:From;
	b=QZo0j0je9ovFBf+nj0zqSX8Nw/eWDl4xGzmPRNuxid5gjjSvPSYAGJCH/7FUqP930
	 ebpKqlcINwH2r3v5abAMfocaKqTOWBzRoVsPfTCW3jhaAgfzGr5Ke65ht53tPEtAQI
	 B312PEFjIp6/ksBh3TY9QAnfH5gl2I4Coko5AWHbQZkjeHdyViwajaUBlUvKck4HA2
	 M5nrGMj8FwR3qrqnRJupNZqENoX5/NHqmxlTYcXVoA8jG2+wdQkcELPzY69s1QDXg5
	 V/m6ou6W+Gafzo+LGiUrw/YN3KJSgEfgRM8jMS6zBNRlUQYjEbYJOeqrRBO7eGW4Ux
	 ekxANYooet6pg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH] UML: define RUNTIME_DISCARD_EXIT
Date: Wed,  8 Feb 2023 01:41:56 +0900
Message-Id: <20230207164156.537378-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230207_084252_619668_E8EEBCCB 
X-CRM114-Status: GOOD (  13.00  )
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

With CONFIG_VIRTIO_UML=y, GNU ld < 2.36 fails to link UML vmlinux
(w/wo CONFIG_LD_SCRIPT_STATIC).

  `.exit.text' referenced in section `.uml.exitcall.exit' of arch/um/drivers/virtio_uml.o: defined in discarded section `.exit.text' of arch/um/drivers/virtio_uml.o
  collect2: error: ld returned 1 exit status

This fix is similar to the following commits:

- 4b9880dbf3bd ("powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT")
- a494398bde27 ("s390: define RUNTIME_DISCARD_EXIT to fix link error
  with GNU ld < 2.36")
- c1c551bebf92 ("sh: define RUNTIME_DISCARD_EXIT")

Fixes: 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv")
Reported-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/um/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/vmlinux.lds.S b/arch/um/kernel/vmlinux.lds.S
index 16e49bfa2b42..53d719c04ba9 100644
--- a/arch/um/kernel/vmlinux.lds.S
+++ b/arch/um/kernel/vmlinux.lds.S
@@ -1,4 +1,4 @@
-
+#define RUNTIME_DISCARD_EXIT
 KERNEL_STACK_SIZE = 4096 * (1 << CONFIG_KERNEL_STACK_ORDER);
 
 #ifdef CONFIG_LD_SCRIPT_STATIC
-- 
2.34.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
