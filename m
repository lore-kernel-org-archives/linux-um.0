Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSIt9-00077B-Su
 for linux-um@lists.infradead.org; Tue, 13 Oct 2020 11:54:46 +0000
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v6 76/80] docs: virt: user_mode_linux_howto_v2.rst: fix a
 literal block markup
Date: Tue, 13 Oct 2020 13:54:31 +0200
Message-Id: <393933f6b2ffb20c3fed514508c13d78229562ff.1602589096.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

There's a missing new line for a literal block:

	.../Documentation/virt/uml/user_mode_linux_howto_v2.rst:682: WARNING: Unexpected indentation.

Fixes: 04301bf5b072 ("docs: replace the old User Mode Linux HowTo with a new one")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/virt/uml/user_mode_linux_howto_v2.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
index f70e6f5873c6..312e431695d9 100644
--- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
+++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
@@ -679,6 +679,7 @@ Starting UML
 
 We can now run UML.
 ::
+
    # linux mem=2048M umid=TEST \
     ubd0=Filesystem.img \
     vec0:transport=tap,ifname=tap0,depth=128,gro=1 \
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

