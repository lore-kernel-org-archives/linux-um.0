Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FD2C7EE23
	for <linux-um@archiver.kernel.org>; Sun, 26 Feb 2023 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:From:To
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xy4iWdWeMJ4jMsi6AHQ5msgXd2EseWbOL4ECtFg4cco=; b=PA1/zrO9VqXWv5
	fbtddE+WIUaM8P+euFPfkEAnj2n6BxMKHWoTsNXA2cKR25kZC5AUd8Jl5jjN3U5AeEH3Pm8mkW40t
	XSCZ+p1PXzRE52bmT3WyBWyGOQkt/xoU1+t6KZ3uyTZqMROvsBWjzwdEmamjyf0YPywBxPz6o1moR
	a83kEoByXkefyXVLQ+NTjdCZZ/wxP3UYArlkwXEkdP9zzUiFTO5B26bcgH6c3rZdzN/59BGdiEWZb
	SfaRFdlNkA9FKFO7JspCiKUoFjuEQ89eQX+Z+jJq1OQsj1zjchkDgIAuvwgX61aa86GVwpK5Muds/
	ha59hyTHcqT/TzUZrJCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWIyK-007WEQ-5S; Sun, 26 Feb 2023 15:29:56 +0000
Received: from mail-4018.proton.ch ([185.70.40.18])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWIyE-007WE2-TK
	for linux-um@lists.infradead.org; Sun, 26 Feb 2023 15:29:54 +0000
Date: Sun, 26 Feb 2023 15:29:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bamelis.dev;
	s=protonmail; t=1677425384; x=1677684584;
	bh=eoXPDUG4LE4aVTicadwgIDZhq2nFb3eJVYwjoPAWgDk=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NnJpFcuZlXuf27GopmnXoBKdZBHDadjNr3bhKTq6ZIhl6FVZoqlr2x3v5YgXSNQoW
	 9LofK32wRN5xU4Ee6/iWsNXLLaIMlXFzT3gCa91Lrq2935y/3QOXbSotLNHQFFodAB
	 hS4ptcaSJ9v2/MRcmaPfIOTPpBL4cRrGybBuAn3lHJusVCdozC8Mm8QTWoL6/yk5bz
	 Zh3YgDaHO3jGb5l49mKeSU8LloEp02nlWBEHC2jz9OSFLwzCKDdF0SFmWmkHf5N6JW
	 W9iBFbFOK0Fep5Duj0t2C7Fd7K0T9ezV/sJVxvgqu4bXmBSl0azB4rATcUQHIcqvfJ
	 r4I/kCvH/X0PQ==
To: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
From: dev <thomas@bamelis.dev>
Subject: [PATCH] rust: sort uml documentation arch support table
Message-ID: <I0YeaNjTtc4Nh47ZLJfAs6rgfAc_QZxhynNfz-GQKssVZ1S2UI_cTScCkp9-oX-hPYVcP3EfF7N0HMB9iAlm1FcvOJagnQoLeHtiW3bGCgM=@bamelis.dev>
Feedback-ID: 67636720:user:proton
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230226_072952_885101_B6914922 
X-CRM114-Status: UNSURE (   6.63  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Thomas Bamelis <thomas@bamelis.dev>

The arch_support table was not sorted alphabetically.
Sorts the table properly.

Fixes: 0438aadfa69a ("rust: arch/um: Add support for CONFIG_RUST under x86_64 UML")
Link: https://lore.kernel.org/rust-for-linux/CANiq72nXMsnUsJNZOG-QZiCVOqa9dRUSMc4RAS3ExLZNJ7VhHg@mail.gmail.com
Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Thomas Bamelis <thomas@bamelis.dev>
---
 Documentation/rust/arch-support.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index ed7f4f5b3cf1..b91e9ef4d0c2 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -15,7 +15,7 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
 ============  ================  ==============================================
 Architecture  Level of support  Constraints
 ============  ================  ==============================================
-``x86``       Maintained        ``x86_64`` only.
 ``um``        Maintained        ``x86_64`` only.
+``x86``       Maintained        ``x86_64`` only.
 ============  ================  ==============================================
 
-- 

Thank you,
Thomas


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
