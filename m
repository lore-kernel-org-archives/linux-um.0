Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 2/7] um: Use non_fatal() in check_coredump_limit
Date: Fri, 28 Apr 2017 19:22:11 +0900
Message-Id: <149337492076.14717.258748776692263679.stgit@devbox>
In-Reply-To: <149337478135.14717.16640886389891283.stgit@devbox>
References: <149337478135.14717.16640886389891283.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Use non_fatal() instead of printf in check_coredump_limit().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/um/os-Linux/start_up.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 22a358e..5052817 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -308,15 +308,17 @@ static void __init check_coredump_limit(void)
 		return;
 	}
 
-	printf("Core dump limits :\n\tsoft - ");
+	non_fatal("Core dump limits :\n\tsoft - ");
 	if (lim.rlim_cur == RLIM_INFINITY)
-		printf("NONE\n");
-	else printf("%lu\n", lim.rlim_cur);
+		non_fatal("NONE\n");
+	else
+		non_fatal("%lu\n", lim.rlim_cur);
 
-	printf("\thard - ");
+	non_fatal("\thard - ");
 	if (lim.rlim_max == RLIM_INFINITY)
-		printf("NONE\n");
-	else printf("%lu\n", lim.rlim_max);
+		non_fatal("NONE\n");
+	else
+		non_fatal("%lu\n", lim.rlim_max);
 }
 
 void __init os_early_checks(void)


