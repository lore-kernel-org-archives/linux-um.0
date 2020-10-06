Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPjX0-0008Np-1J
 for linux-um@lists.infradead.org; Tue, 06 Oct 2020 09:45:14 +0000
Received: by mail-pj1-x1042.google.com with SMTP id a17so1298779pju.1
 for <linux-um@lists.infradead.org>; Tue, 06 Oct 2020 02:45:13 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 06/21] scritps: um: suppress warnings if SRCARCH=um
Date: Tue,  6 Oct 2020 18:44:15 +0900
Message-Id: <e994b27b4732a21a571cf09bd5071f583d85dd89.1601960644.git.thehajime@gmail.com>
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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
To: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>, retrage01@gmail.com

This commit fixes numbers of warning messages about leaked CONFIG
options.  nommu mode of UML requires copies of kernel headers to offer
syscall-like API for the library users.  Thus, the warnings are to be
avoided to function this exposure of API.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 scripts/headers_install.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index dd554bd436cc..8890a0147012 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -93,6 +93,10 @@ include/uapi/linux/pktcdvd.h:CONFIG_CDROM_PKTCDVD_WCACHE
 
 for c in $configs
 do
+	if [ "$SRCARCH" = "um" ] ; then
+		break
+	fi
+
 	leak_error=1
 
 	for ignore in $config_leak_ignores
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

