Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Thu,  9 Jul 2015 07:06:03 +0200
Message-Id: <1436418364-5201-1-git-send-email-christophe.jaillet@wanadoo.fr>
In-Reply-To: <1436382947-13181-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <1436382947-13181-1-git-send-email-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 1/2] um: umid: Use tab instead of spaces
To: jdike@addtoit.com, richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Turn some spaces into a tab to be consistent with the rest of the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/um/os-Linux/umid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index c1dc892..b514ead 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -56,7 +56,7 @@ static int __init make_uml_dir(void)
 	strcpy(uml_dir, dir);
 
 	if ((mkdir(uml_dir, 0777) < 0) && (errno != EEXIST)) {
-	        printf("Failed to mkdir '%s': %s\n", uml_dir, strerror(errno));
+		printf("Failed to mkdir '%s': %s\n", uml_dir, strerror(errno));
 		err = -errno;
 		goto err_free;
 	}
-- 
2.1.4

