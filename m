Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-11.nifty.com ([210.131.2.78])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1floTn-0001xa-5N
 for linux-um@lists.infradead.org; Sat, 04 Aug 2018 04:47:54 +0000
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/3] kbuild: add %asm-generic to no-dot-config-targets
Date: Sat,  4 Aug 2018 13:47:02 +0900
Message-Id: <1533358023-5801-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Randy Dunlap <rdunlap@infradead.org>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>

asm-generic and uapi-asm-generic do not depend on the kernel
configuration.  In fact, uapi-asm-generic is the prerequisite of
headers_{install,check}, hence it should not require the .config file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 85f3481..5cf87a18 100644
--- a/Makefile
+++ b/Makefile
@@ -224,7 +224,7 @@ clean-targets := %clean mrproper cleandocs
 no-dot-config-targets := $(clean-targets) \
 			 cscope gtags TAGS tags help% %docs check% coccicheck \
 			 $(version_h) headers_% archheaders archscripts \
-			 kernelversion %src-pkg
+			 %asm-generic kernelversion %src-pkg
 
 config-targets := 0
 mixed-targets  := 0
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

