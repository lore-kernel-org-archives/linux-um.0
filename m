Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 1/6] um: Use printk instead of printf in make_uml_dir
Date: Thu, 18 May 2017 02:14:57 +0900
Message-Id: <149504128715.2543.10601605976866434403.stgit@devbox>
In-Reply-To: <149504121868.2543.16105153409840504430.stgit@devbox>
References: <149504121868.2543.16105153409840504430.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Since this function will be called after printk buffer
initialized, use printk as other functions do.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2:
   - Use "%s", __func__ according to checkpatches.pl
---
 arch/um/os-Linux/umid.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index c1dc892..37cfaba 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -35,8 +35,9 @@ static int __init make_uml_dir(void)
 
 		err = -ENOENT;
 		if (home == NULL) {
-			printk(UM_KERN_ERR "make_uml_dir : no value in "
-			       "environment for $HOME\n");
+			printk(UM_KERN_ERR
+				"%s: no value in environment for $HOME\n",
+				__func__);
 			goto err;
 		}
 		strlcpy(dir, home, sizeof(dir));
@@ -50,13 +51,15 @@ static int __init make_uml_dir(void)
 	err = -ENOMEM;
 	uml_dir = malloc(strlen(dir) + 1);
 	if (uml_dir == NULL) {
-		printf("make_uml_dir : malloc failed, errno = %d\n", errno);
+		printk(UM_KERN_ERR "%s : malloc failed, errno = %d\n",
+			__func__, errno);
 		goto err;
 	}
 	strcpy(uml_dir, dir);
 
 	if ((mkdir(uml_dir, 0777) < 0) && (errno != EEXIST)) {
-	        printf("Failed to mkdir '%s': %s\n", uml_dir, strerror(errno));
+		printk(UM_KERN_ERR "Failed to mkdir '%s': %s\n",
+			uml_dir, strerror(errno));
 		err = -errno;
 		goto err_free;
 	}


