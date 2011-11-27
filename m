Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Cong Wang <amwang@redhat.com>
Date: Sun, 27 Nov 2011 13:26:47 +0800
Message-Id: <1322371662-26166-8-git-send-email-amwang@redhat.com>
In-Reply-To: <1322371662-26166-1-git-send-email-amwang@redhat.com>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>
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
Subject: [uml-devel] [PATCH 07/62] um: remove the second argument of
	k[un]map_atomic()
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <amwang@redhat.com>, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-user@lists.sourceforge.net, akpm@linux-foundation.org


Signed-off-by: Cong Wang <amwang@redhat.com>
---
 arch/um/kernel/skas/uaccess.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 9fefd92..cd7df79 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -69,7 +69,7 @@ static int do_op_one_page(unsigned long addr, int len, int is_write,
 		return -1;
 
 	page = pte_page(*pte);
-	addr = (unsigned long) kmap_atomic(page, KM_UML_USERCOPY) +
+	addr = (unsigned long) kmap_atomic(page) +
 		(addr & ~PAGE_MASK);
 
 	current->thread.fault_catcher = &buf;
@@ -82,7 +82,7 @@ static int do_op_one_page(unsigned long addr, int len, int is_write,
 
 	current->thread.fault_catcher = NULL;
 
-	kunmap_atomic((void *)addr, KM_UML_USERCOPY);
+	kunmap_atomic((void *)addr);
 
 	return n;
 }
-- 
1.7.4.4


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

