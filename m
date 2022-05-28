Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuraJ-001jH9-Gp
	for linux-um@lists.infradead.org; Sat, 28 May 2022 08:14:08 +0000
Received: by mail-pj1-x1033.google.com with SMTP id d20so2405434pjr.0
        for <linux-um@lists.infradead.org>; Sat, 28 May 2022 01:14:06 -0700 (PDT)
From: Yu-Jen Chang <arthurchang09@gmail.com>
Subject: [PATCH 2/2] x86/um: Use x86_64-optimized memchr
Date: Sat, 28 May 2022 16:12:36 +0800
Message-Id: <20220528081236.3020-3-arthurchang09@gmail.com>
In-Reply-To: <20220528081236.3020-1-arthurchang09@gmail.com>
References: <20220528081236.3020-1-arthurchang09@gmail.com>
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
To: ak@linux.intel.com, jdike@linux.intel.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, keescook@chromium.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org, jserv@ccns.ncku.edu.tw, Yu-Jen Chang <arthurchang09@gmail.com>

Add x86_64-optimized memchr, which is 4x faster
than the original implementation, into um.

Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
---
 arch/x86/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index ba5789c35..52b7c21ca 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -28,7 +28,7 @@ else
 
 obj-y += syscalls_64.o vdso/
 
-subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
+subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../lib/string_64.o ../entry/thunk_64.o
 
 endif
 
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

