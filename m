Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed,  8 Jul 2015 21:15:47 +0200
Message-Id: <1436382947-13181-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: umid: Use strdup to simplify code
To: jdike@addtoit.com, richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Replace a malloc+strcpy by an equivalent strdup in order to improve
readability.
Turn a some spaces into a tab to be consistent with the rest of the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/um/os-Linux/umid.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index c1dc892..cc9ac2e 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -48,15 +48,14 @@ static int __init make_uml_dir(void)
 		strlcat(dir, "/", sizeof(dir));
 
 	err = -ENOMEM;
-	uml_dir = malloc(strlen(dir) + 1);
+	uml_dir = strdup(dir);
 	if (uml_dir == NULL) {
-		printf("make_uml_dir : malloc failed, errno = %d\n", errno);
+		printf("make_uml_dir : strdup failed, errno = %d\n", errno);
 		goto err;
 	}
-	strcpy(uml_dir, dir);
 
 	if ((mkdir(uml_dir, 0777) < 0) && (errno != EEXIST)) {
-	        printf("Failed to mkdir '%s': %s\n", uml_dir, strerror(errno));
+		printf("Failed to mkdir '%s': %s\n", uml_dir, strerror(errno));
 		err = -errno;
 		goto err_free;
 	}
-- 
2.1.4

