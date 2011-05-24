Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joe@perches.com>) id 1QOxwC-0003Dp-Nz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 May 2011 20:10:44 +0000
Received: from mail.perches.com ([173.55.12.10])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QOxwB-0003Ht-Sk for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 May 2011 20:10:44 +0000
From: Joe Perches <joe@perches.com>
In-Reply-To: <20110524123433.0b74f33e.akpm@linux-foundation.org>
References: <1306075716-20042-1-git-send-email-richard@nod.at>
	<1306075716-20042-5-git-send-email-richard@nod.at>
	<20110524123433.0b74f33e.akpm@linux-foundation.org>
Date: Tue, 24 May 2011 13:02:26 -0700
Message-ID: <1306267346.2298.58.camel@Joe-Laptop>
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] checkpatch: Add warning for uses of
	printk_ratelimit
To: Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Warn about uses of printk_ratelimit because it uses a
global state and can hide subsequent useful messages.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d867081..d1a9adc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1943,6 +1943,11 @@ sub process {
 			WARN("LINUX_VERSION_CODE should be avoided, code should be for the version to which it is merged\n" . $herecurr);
 		}
 
+# check for uses of printk_ratelimit
+		if ($line =~ /\bprintk_ratelimit\s*\(/) {
+			WARN("Prefer printk_ratelimited or pr_<level>_ratelimited to printk_ratelimit\n" . $herecurr);
+		}
+
 # printk should use KERN_* levels.  Note that follow on printk's on the
 # same line do not need a level, so we use the current block context
 # to try and find and validate the current printk.  In summary the current



------------------------------------------------------------------------------
vRanger cuts backup time in half-while increasing security.
With the market-leading solution for virtual backup and recovery, 
you get blazing-fast, flexible, and affordable data protection.
Download your free trial now. 
http://p.sf.net/sfu/quest-d2dcopy1
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

