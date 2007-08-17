Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILvWh-00059O-N2 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 23:41:43 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILvWg-0003r2-Aq
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 23:41:43 -0700
Date: Fri, 17 Aug 2007 12:24:23 +0530 (IST)
From: Satyam Sharma <satyam@infradead.org>
In-Reply-To: <20070816145210.GD6670@c2.user-mode-linux.org>
Message-ID: <alpine.LFD.0.999.0708171208060.3666@enigma.security.iitk.ac.in>
References: <20070815235825.GB17004@redhat.com>
	<1187224811.5906.55.camel@localhost>
	<20070816145210.GD6670@c2.user-mode-linux.org>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] hostfs: Remove pointless if statement
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Joe Perches <joe@perches.com>, Linux Kernel <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

[ Cc: list heavily trimmed. ]


On Thu, 16 Aug 2007, Jeff Dike wrote:

> On Wed, Aug 15, 2007 at 05:40:11PM -0700, Joe Perches wrote:
> > fs/hostfs/hostfs_user.c:        if(attrs->ia_valid & HOSTFS_ATTR_CTIME) ;
> 
> This one can be deleted, but I think I did it for documentation
> reasons, to make it clear that ctime handling wasn't left out by
> mistake.


We normally use "comments" for that, not dead code that a compiler
then elids ;-)


[PATCH] hostfs: Remove pointless if statement

And replace with comment saying we don't handle ctime.
Also some codingstyle while I was there.

Signed-off-by: Satyam Sharma <satyam@infradead.org>

---

 fs/hostfs/hostfs_user.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index 5625e24..a554a0a 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -283,12 +283,12 @@ int set_attr(const char *file, struct hostfs_iattr *attrs, int fd)
 		}
 	}
 
-	if(attrs->ia_valid & HOSTFS_ATTR_CTIME) ;
-	if(attrs->ia_valid & (HOSTFS_ATTR_ATIME | HOSTFS_ATTR_MTIME)){
+	/* ctime is not handled */
+	if (attrs->ia_valid & (HOSTFS_ATTR_ATIME | HOSTFS_ATTR_MTIME)){
 		err = stat_file(file, NULL, NULL, NULL, NULL, NULL, NULL,
 				&attrs->ia_atime, &attrs->ia_mtime, NULL,
 				NULL, NULL, fd);
-		if(err != 0)
+		if (err != 0)
 			return err;
 	}
 	return 0;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
