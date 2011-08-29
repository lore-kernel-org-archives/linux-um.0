Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Qy4TD-0004ns-04
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:13:55 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qy4TC-0006BF-1V
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2011 16:13:54 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 29 Aug 2011 18:13:31 +0200
Message-Id: <1314634419-24766-2-git-send-email-richard@nod.at>
In-Reply-To: <1314634419-24766-1-git-send-email-richard@nod.at>
References: <1314634419-24766-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 1/9] um: disable CMPXCHG_DOUBLE as it breaks UML
	build
To: akpm@linux-foundation.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Christoph Lameter <cl@linux.com>

From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

Commit b789ef518b2a7231b0668c813f677cee528a9d3f tests for cmpxchg_double
support in the SLUB code and it breaks UML builds with SLUB. Since UML
does not support checking for CPU features, disable CMPXCHG_DOUBLE just
like CMPXCHG_LOCAL is disabled for UML.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.x86 |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/um/Kconfig.x86 b/arch/um/Kconfig.x86
index d31ecf3..21bebe6 100644
--- a/arch/um/Kconfig.x86
+++ b/arch/um/Kconfig.x86
@@ -10,6 +10,10 @@ config CMPXCHG_LOCAL
 	bool
 	default n
 
+config CMPXCHG_DOUBLE
+	bool
+	default n
+
 source "arch/x86/Kconfig.cpu"
 
 endmenu
-- 
1.7.6.1


------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

