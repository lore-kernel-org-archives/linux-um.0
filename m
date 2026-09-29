Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DA5CA5FA1
	for <linux-um@archiver.kernel.org>; Tue, 29 Sep 2026 03:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qxLbnCMjOsISk4dkJ+9u2CP2IpXgRDtHatTLjBExLk0=; b=aKeMI4sNdkFi0Mhrw27ckmjZBc
	QasmPIfPmXw5lHENQM+Wtv3toH4Dsg5xypXoNmqrir59+ZSpWdHDoTtu4HYkv2+E5x/7bOuTFg0dS
	YYnURhGo+kL4tzcihPamI2sw+fll1FjKG2mtcwaxxnQf1W9R2chxZ2hLgld9Ok4Rl5/frf3wtjlLB
	tvO/3zf+Oz89STS+9j8S5eT7PNgzkzL4mB1EaHNZ8ygShbq+taARpMLDN93F0L9aX1YwrFw4wHFws
	ZKYSOQQczYJQQAvEW7zSfqaLdx85Uxjws0zYJnMvcK5e+O3AorbN8eUPAbPzSEM5692n0+EH8IqUD
	KDXrMsbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOrF-00000002Hm1-2uny;
	Tue, 29 Sep 2026 03:50:21 +0000
Received: from out199-28.us.a.mail.aliyun.com ([47.90.199.28])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBOrC-00000002HlI-1laV
	for linux-um@lists.infradead.org;
	Tue, 29 Sep 2026 03:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1790653813; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qxLbnCMjOsISk4dkJ+9u2CP2IpXgRDtHatTLjBExLk0=;
	b=ewbshE6+Zkhga3pnO1bqR8Jee+A1MAyaQIZ4mLexfiOXl7b4JnazZV0zPvrFWJOqqo+AE5AZ2ql1ksfnQns+yH8h6P01HpE2lGvhwObXEQeueM56MvkKWCVSI0jidmfjK8VYyK0G9qVOz6ksUWHExlhCewtmYuhQ5m9gEuB+W6Y=
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1186648|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00757088-0.000741671-0.991687;FP=16780791132089850986|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=wdhh6@aliyun.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---0XBrsXwJ_1790653808;
Received: from localhost.localdomain(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0XBrsXwJ_1790653808 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 11:50:10 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-um@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chaohai Chen <wdhh6@aliyun.com>
Subject: [PATCH] docs: Fix outdated URL in user_mode_linux_howto_v2.rst
Date: Tue, 29 Sep 2026 11:50:06 +0800
Message-ID: <20260929035006.2201371-1-wdhh6@aliyun.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_205018_720064_2437FC41 
X-CRM114-Status: UNSURE (   8.68  )
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

Using an outdated website results in an error:
  E: Failed getting release file http://deb.debian.org/debian/dists/buster/Release

It works successfully using https://archive.debian.org/debian-archive/debian .

Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
---
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index 9224bea5ee9f..c4d5d08e2bab 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -123,7 +123,7 @@ jfs, etc will work too.
 
 Create a minimal OS installation on the mounted filesystem::
 
-   # debootstrap buster /mnt http://deb.debian.org/debian
+   # debootstrap buster /mnt https://archive.debian.org/debian-archive/debian
 
 debootstrap does not set up the root password, fstab, hostname or
 anything related to networking. It is up to the user to do that.
-- 
2.43.7


