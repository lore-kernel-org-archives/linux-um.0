Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D06C001E0
	for <linux-um@archiver.kernel.org>; Sun, 16 Jul 2023 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fYwc8wiQoL4znkUIfn4e7AdaQlRYboSrFE587Byc+YI=; b=fVN5y5L6KyLjpP
	F/m/5a0YSt7p0WqtL1VdtIaPavyLdEE1GN+KPAlE6q2yZLWCU6GL8gZkzHl4cru53gZ/xZK+zbcbQ
	3FeUmwbheSfv3wS8xaw4l61n7ByaZq9Tfhzybux31VHuxBEG0Pyg6YtGsO5jmhMbAgmVFWtU67VbS
	AscpnGDmtEd/afX31r+mkWM2cvcFl1Pq66EbF/RK2aU14QaP6kqbGnH7DohdrD254T/BiYkwYIpe9
	pfCFMR1xCrxlihpeOTBGcqh1v0jlKeC7GdRwTzarHqQe7K8yO5AEuWBg1Oe/3wRfocK0WUFwCaZ6c
	giUfZMrgwte7VNs945Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qL8mI-00FKyl-2t;
	Sun, 16 Jul 2023 20:55:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qL8mG-00FKws-1B
	for linux-um@lists.infradead.org;
	Sun, 16 Jul 2023 20:55:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C29ED60DFD;
	Sun, 16 Jul 2023 20:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4752C433C8;
	Sun, 16 Jul 2023 20:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689540935;
	bh=x3HDupK+SDlDL81Sjk2JanGEtg2Epo7RPhzhOePIP3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOQLji8IX09/1ROb+k36esw2EZxAqqBf1B87aJoWQFY96t4/cYqe03Yty0g8zsMcs
	 gj5qA1K3EvX0YPYp7XQR6XDC69y4dFM9Xy8vB7wqdWdnRkpZdAwUyJMEURXvZ6yDXH
	 zvj4Gpfkzcg0K5z23DJcfjGLQvFftpFNB6hTmFcA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-um@lists.infradead.org,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.1 540/591] um: Use HOST_DIR for mrproper
Date: Sun, 16 Jul 2023 21:51:19 +0200
Message-ID: <20230716194937.834689949@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230716_135536_467173_760324B3 
X-CRM114-Status: GOOD (  10.93  )
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

commit a5a319ec2c2236bb96d147c16196d2f1f3799301 upstream.

When HEADER_ARCH was introduced, the MRPROPER_FILES (then MRPROPER_DIRS)
list wasn't adjusted, leaving SUBARCH as part of the path argument.
This resulted in the "mrproper" target not cleaning up arch/x86/... when
SUBARCH was specified. Since HOST_DIR is arch/$(HEADER_ARCH), use it
instead to get the correct path.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Cc: linux-um@lists.infradead.org
Fixes: 7bbe7204e937 ("um: merge Makefile-{i386,x86_64}")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230606222442.never.807-kees@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -148,7 +148,7 @@ export LDFLAGS_vmlinux := $(LDFLAGS_EXEC
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
-MRPROPER_FILES += arch/$(SUBARCH)/include/generated
+MRPROPER_FILES += $(HOST_DIR)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
