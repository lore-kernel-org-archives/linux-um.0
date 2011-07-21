Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QjpPD-0006v3-86
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:55 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QjpP8-0006x6-RB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:55 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 21 Jul 2011 11:18:28 +0200
Message-Id: <1311239914-8301-4-git-send-email-richard@nod.at>
In-Reply-To: <1311239914-8301-1-git-send-email-richard@nod.at>
References: <1311239914-8301-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 04/10] uml: free resources
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Davidlohr Bueso <dave@gnu.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Davidlohr Bueso <dave@gnu.org>

When creating the temp file there's a memory and file descriptor leak upon error.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Reviewed-by: Vitaliy Ivanov <vitalivanov@gmail.com>
---
 arch/um/os-Linux/mem.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index e696144..62878cf 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -176,7 +176,7 @@ static int __init make_tempfile(const char *template, char **out_tempname,
 
 	find_tempdir();
 	if ((tempdir == NULL) || (strlen(tempdir) >= MAXPATHLEN))
-		return -1;
+		goto out;
 
 	if (template[0] != '/')
 		strcpy(tempname, tempdir);
@@ -191,13 +191,15 @@ static int __init make_tempfile(const char *template, char **out_tempname,
 	}
 	if (do_unlink && (unlink(tempname) < 0)) {
 		perror("unlink");
-		goto out;
+		goto close;
 	}
 	if (out_tempname) {
 		*out_tempname = tempname;
 	} else
 		free(tempname);
 	return fd;
+close:
+	close(fd);
 out:
 	free(tempname);
 	return -1;
-- 
1.7.6


------------------------------------------------------------------------------
5 Ways to Improve & Secure Unified Communications
Unified Communications promises greater efficiencies for business. UC can 
improve internal communications as well as offer faster, more efficient ways
to interact with customers and streamline customer service. Learn more!
http://www.accelacomm.com/jaw/sfnl/114/51426253/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

