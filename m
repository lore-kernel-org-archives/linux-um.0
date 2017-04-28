Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 1/7] um: Use printk instead of printf in make_uml_dir
Date: Fri, 28 Apr 2017 19:21:01 +0900
Message-Id: <149337485165.14717.463075225620641986.stgit@devbox>
In-Reply-To: <149337478135.14717.16640886389891283.stgit@devbox>
References: <149337478135.14717.16640886389891283.stgit@devbox>
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
 arch/um/os-Linux/umid.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index c1dc892..b94a416 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -50,13 +50,15 @@ static int __init make_uml_dir(void)
 	err = -ENOMEM;
 	uml_dir = malloc(strlen(dir) + 1);
 	if (uml_dir == NULL) {
-		printf("make_uml_dir : malloc failed, errno = %d\n", errno);
+		printk(UM_KERN_ERR "make_uml_dir : malloc failed, "
+			"errno = %d\n", errno);
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


