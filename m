Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A236E75459
	for <linux-um@archiver.kernel.org>; Tue,  3 Oct 2023 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mQnF2j/dNgNxiOhotVKAAIZOf1NAg0fC6hu7v4iLACo=; b=pxw1l3OjN1is1Z
	5aO8lgP3RO24rD+3ObuCuXEttcp7Va4/YASq9H6jwGFGti9+n8SC2BCM4B1dKCinLU+AUOplv4pNm
	hIKLzIGUa+xpDwU0OyiGmavDRp5aFAbI6j568Q3/7hgC/hvnHgC3MJXl5MmfNkVg98VV2j5yHl305
	aB2RDvy6XAAUEJPlcd7GS5AWriEQtrg6xMVcEwK1n0nV9f5kOCjOy41qmCbs7FDlEXlVaBrSFZXe8
	shRbhGjkIhcoDzzMaYSwGcLNNotZUp7v9G4WmuW887Yx0dSvHg7iOsD9lZxc4DTZtGSrAjCXUb2gh
	cYUwgpMI23Do8K+Db4wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnkFl-00F7sO-0c;
	Tue, 03 Oct 2023 18:36:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnkFe-00F7rv-1x
	for linux-um@lists.infradead.org;
	Tue, 03 Oct 2023 18:36:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DDE316132F;
	Tue,  3 Oct 2023 18:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E9DC433C7;
	Tue,  3 Oct 2023 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696358169;
	bh=uur6FVNUPgA68DU0+0V7uI6bm+Kw9EG25C8ZPIVUe20=;
	h=From:Date:Subject:To:Cc:From;
	b=ajILCUP9UyDP8jjvmTp66s7MbbRLmlzeH/og8T/AJIYctp8zr8JN7Yn8WHrzeo8yF
	 44o8sDdWsRpFjZEhn5Uzq0wyN9pyCfU5pLu7lNJS+KxT58DWp4ecGok7oRWWDPDCjU
	 mG2brcB5CgzM4RTCbaKezkpgYjfvSbcDDvTgxvmnZcaibnd7pHO6R5K2SFgs07FGEW
	 DnsegVdOv1SPyF54+RfpsjPRUB7KIzoatAzgwUxvgfkDQn6gVJCgOhSRtMFKXbkOWL
	 CWssFAvcIZMGoIpQrFUkDWuaF6PAw6BdM8NMiUKFzcsB9DYpLQtkVJcph0r9E1IxJS
	 9PsO9GbqSVQgg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 03 Oct 2023 11:35:53 -0700
Subject: [PATCH] um: net: Fix return type of uml_net_start_xmit()
MIME-Version: 1.0
Message-Id: <20231003-um-net-wifpts-v1-1-02888c634ee7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAhfHGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAwNj3dJc3bzUEt3yzLSCkmJdQ5NEcxMjy2RzUyMTJaCegqLUtMwKsHn
 RsbW1APIlzJJfAAAA
To: richard@nod.at, anton.ivanov@cambridgegreys.com, 
 johannes@sipsolutions.net
Cc: ndesaulniers@google.com, trix@redhat.com, linux-um@lists.infradead.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2224; i=nathan@kernel.org;
 h=from:subject:message-id; bh=uur6FVNUPgA68DU0+0V7uI6bm+Kw9EG25C8ZPIVUe20=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKky8RKZ/HJHlvMZn8lhlpq76f0N8fq4sMlsMkk7F9YFe
 bWlPb/ZUcrCIMbBICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACZi0s7wP3uCUNF91bJkY3U1
 iy0/WeSY7d93Xs/7kfJhyxK2ix8ErzEyPJ3k7PpBesnF+GLTzpLdGfJ7hNsiCy0EGr9pzqxYylf
 HAAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231003_113610_727856_62DDE0F5 
X-CRM114-Status: GOOD (  13.34  )
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

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
warning in clang aims to catch these at compile time, which reveals:

  arch/um/drivers/net_kern.c:353:21: warning: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Wincompatible-function-pointer-types-strict]
    353 |         .ndo_start_xmit         = uml_net_start_xmit,
        |                                   ^~~~~~~~~~~~~~~~~~
  1 warning generated.

->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
'netdev_tx_t', not 'int'. Adjust the return type of uml_net_start_xmit()
to match the prototype's to resolve the warning. While UML does not
currently implement support for kCFI, it could in the future, which
means this warning becomes a fatal CFI failure at run time.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310031340.v1vPh207-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/um/drivers/net_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 3d7836c46507..cabcc501b448 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -204,7 +204,7 @@ static int uml_net_close(struct net_device *dev)
 	return 0;
 }
 
-static int uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t uml_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct uml_net_private *lp = netdev_priv(dev);
 	unsigned long flags;

---
base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
change-id: 20231003-um-net-wifpts-14a7429c7524

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
