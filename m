Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqztG-00057d-Hi
 for linux-um@lists.infradead.org; Thu, 02 Jul 2020 14:08:39 +0000
Received: by mail-pf1-x443.google.com with SMTP id t11so7733370pfq.11
 for <linux-um@lists.infradead.org>; Thu, 02 Jul 2020 07:08:38 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 06/21] scritps: um: suppress warnings if SRCARCH=um
Date: Thu,  2 Jul 2020 23:07:00 +0900
Message-Id: <103c87a24c9966f465cdc3c4e4d6519c81cf33d2.1593697069.git.thehajime@gmail.com>
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

This commit fixes numbers of warning messages about leaked CONFIG
options.  nommu mode of UML requires copies of kernel headers to offer
syscall-like API for the library users.  Thus, the warnings are to be
avoided to function this exposure of API.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 scripts/headers_install.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index a07668a5c36b..59966f3b4ebe 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -99,6 +99,9 @@ include/uapi/linux/raw.h:CONFIG_MAX_RAW_DEVS
 for c in $configs
 do
 	warn=1
+	if [ "$SRCARCH" = "um" ] ; then
+		break
+	fi
 
 	for ignore in $config_leak_ignores
 	do
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

