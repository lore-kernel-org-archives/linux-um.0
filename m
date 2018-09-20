Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ritesh Raj Sarraf <rrs@debian.org>
Subject: [PATCH] Don't hardcode path as it is architecture dependent
Date: Thu, 20 Sep 2018 11:56:38 +0530
Message-Id: <20180920062640.23038-1-rrs@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Ritesh Raj Sarraf <rrs@debian.org>, Ritesh Raj Sarraf <rrs@researchut.com>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

The current code fails to run on amd64 because of hardcoded reference to
i386

Signed-off-by: Ritesh Raj Sarraf <rrs@researchut.com>
---
 arch/um/drivers/port_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
index 9a8e1b64c22e..5f56d11b886f 100644
--- a/arch/um/drivers/port_user.c
+++ b/arch/um/drivers/port_user.c
@@ -168,7 +168,7 @@ int port_connection(int fd, int *socket, int *pid_out)
 {
 	int new, err;
 	char *argv[] = { "/usr/sbin/in.telnetd", "-L",
-			 "/usr/lib/uml/port-helper", NULL };
+			 OS_LIB_PATH "/uml/port-helper", NULL };
 	struct port_pre_exec_data data;
 
 	new = accept(fd, NULL, 0);
-- 
2.18.0


