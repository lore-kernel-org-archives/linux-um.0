Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0B9C4828E
	for <linux-um@archiver.kernel.org>; Fri,  2 Feb 2024 21:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8L33DBBndo3NokgAYjpkdsaWW74PWfcxGD0pnplvp7U=; b=EhKdDHDB7S5O7HemZ4DSCVRX+w
	1RqceCp8nJFpefFwkIe6SfMOQz3NkEbXu+yiYWp62KqK2KEOSCNW1P7+/6F8glxHH3qpJIihMG5FD
	vq9fjQbqhbrKO3I3bWlaNSWGOABSRmaKgfn5u16JfO0fAAab6pK/7pbrhIgPVXp1N0y7/SnbvmCJl
	Cy5rdFJ1dh8cRbYi0vHZwLsgcjdR7vunOCEGd2/yh7/ZAF0rj4xCTY3BgSlJf0lZrWxGEiy9fRs4U
	HrEZ464ONAk7hbxdKF03M0Z/ep00MQhFkD0TTMReuXKOpod2e8AGr1DtkDjbw+1j9Nxac6WbdwRcP
	iIT8AYWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rW0h0-0000000DStl-3X8I;
	Fri, 02 Feb 2024 21:03:22 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVzfn-0000000DHlC-0v9c
	for linux-um@lists.infradead.org;
	Fri, 02 Feb 2024 19:58:18 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4A8E4240101
	for <linux-um@lists.infradead.org>; Fri,  2 Feb 2024 20:57:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1706903879; bh=ZjzdVNfrMUY9UbVAc1VBiqKQvpy3NY8jNomBSoF8YQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=hDqww7k1xSH3YS9NyU1U28mv8gyk1ry5awu7xlodsYIIk4O2fLsbBE9+M1IFr/WQM
	 EUCeqAHXHalRpQx4KBL+zKeqTy2FsguPk6FfbeycHb8qTOfZ1PolxAbmmodMGoF189
	 3CGyLU/yOj5WNm/1fw9MAg3AOZUfuo3wnXWRIotznjP91oZFPA7TdKrvbi2WzVt9X9
	 vsWYrR7ys9VbaeQd+aK+P9LvRFC/EOoZ7sDSxdiCTUtOyzbu8batzONrJK4N+6DNPP
	 cSmpXl6FyfNcrapy2G0aQk1q3TkmznRJIJssQsrV9bkLaYtbZyYqpGzN8bBKHYQbDL
	 NqKkz9q4IxgMw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TRRQW0V8Zz9rxG;
	Fri,  2 Feb 2024 20:57:54 +0100 (CET)
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Yueh-Shun Li <shamrocklee@posteo.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: Makefile: use bash from the environment
Date: Fri,  2 Feb 2024 19:56:33 +0000
Message-ID: <20240202195645.3224648-1-shamrocklee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_115803_484516_3100E856 
X-CRM114-Status: UNSURE (   8.81  )
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

Set Makefile SHELL to bash instead of /bin/bash for better portability.

Some systems do not install binaries to /bin, and therefore do not
provide /bin/bash. OS distributions such as NixOS and Guix System
intentionally avoid implementing the Filesystem Hierarchy Standard (FHS).

The recipies inside arch/um/Makefile don't require top-level Bash to
build, and setting "SHELL" to "bash" makes Make pick the Bash executable
from the environment[2], hence this patch.

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 arch/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 82f05f250634..904e2b990963 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -20,7 +20,7 @@ endif
 ARCH_DIR := arch/um
 # We require bash because the vmlinux link and loader script cpp use bash
 # features.
-SHELL := /bin/bash
+SHELL := bash
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 
-- 
2.42.0


