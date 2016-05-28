Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 28 May 2016 18:39:03 +0530
From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] um: Eliminate null test after alloc_bootmem
Message-ID: <20160528130903.GA23109@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

alloc_bootmem function never returns NULL. Thus a NULL test after a
call to this function is unnecessary.

The Coccinelle semantic patch used to make this change is follows:
@@
expression E;
statement S;
@@

E =
alloc_bootmem(...)
... when != E
- if (E == NULL) S

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 arch/um/kernel/initrd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index 55cead8..48bae81 100644
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -37,8 +37,6 @@ static int __init read_initrd(void)
 	}
 
 	area = alloc_bootmem(size);
-	if (area == NULL)
-		return 0;
 
 	if (load_initrd(initrd, area, size) == -1)
 		return 0;
-- 
1.9.1


