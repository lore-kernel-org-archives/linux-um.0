Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 14:11:06 +0200
Message-Id: <20160521121106.13904-1-andrea.gelmini@gelma.net>
Subject: [uml-devel] [PATCH 0263/1529] Fix typo
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
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, user-mode-linux-devel@lists.sourceforge.net, richard@nod.at, jdike@addtoit.com, aivanov@brocade.com, user-mode-linux-user@lists.sourceforge.net, thomas@m3y3r.de

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/os-Linux/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 0e39b99..6caa556 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -91,7 +91,7 @@ int os_timer_set_interval(void* timer, void* i)
 /**
  * os_timer_remain() - returns the remaining nano seconds of the given interval
  *                     timer
- * Because this is the remaining time of an interval timer, which correspondends
+ * Because this is the remaining time of an interval timer, which correspondences
  * to HZ, this value can never be bigger than one second. Just
  * the nanosecond part of the timer is returned.
  * The returned time is relative to the start time of the interval timer.
-- 
2.8.2.534.g1f66975


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

