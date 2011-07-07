Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date: Thu, 07 Jul 2011 00:02:51 -0400
Message-ID: <1310011371.3309.2.camel@offbook>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] uml: free resources
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: uml <user-mode-linux-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Davidlohr Bueso <dave@gnu.org>

When creating the temp file there's a memory and file descriptor leak upon error.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
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
1.7.4.1


