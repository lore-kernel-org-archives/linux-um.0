Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Luis Henriques <luis.henriques@canonical.com>
Date: Tue, 17 Dec 2013 18:12:38 +0000
Message-Id: <1387304012-23805-50-git-send-email-luis.henriques@canonical.com>
In-Reply-To: <1387304012-23805-1-git-send-email-luis.henriques@canonical.com>
References: <1387304012-23805-1-git-send-email-luis.henriques@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 3.5 049/103] um: add missing declaration of 'getrlimit()' and friends
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Sergei Trofimovich <slyfox@gentoo.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Luis Henriques <luis.henriques@canonical.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

3.5.7.28 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergei Trofimovich <slyfox@gentoo.org>

commit fdfa4c952844fce881df8c76de9c7180cbe913ab upstream.

arch/um/os-Linux/start_up.c: In function 'check_coredump_limit':
arch/um/os-Linux/start_up.c:338:16: error: storage size of 'lim' isn't known
arch/um/os-Linux/start_up.c:339:2: error: implicit declaration of function 'getrlimit' [-Werror=implicit-function-declaration]

Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
CC: Jeff Dike <jdike@addtoit.com>
CC: Richard Weinberger <richard@nod.at>
CC: Al Viro <viro@zeniv.linux.org.uk>
CC: user-mode-linux-devel@lists.sourceforge.net
CC: user-mode-linux-user@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/um/os-Linux/start_up.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 425162e..2f53b89 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -15,6 +15,8 @@
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 #include <asm/unistd.h>
 #include "init.h"
 #include "os.h"
-- 
1.8.3.2

