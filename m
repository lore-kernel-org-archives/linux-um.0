Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hUIMr-0000aN-5Q
 for linux-um@lists.infradead.org; Fri, 24 May 2019 22:08:50 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] arch: um: add an option to make serial driver non-raw
Date: Sat, 25 May 2019 00:08:43 +0200
Message-Id: <20190524220843.27623-1-johannes@sipsolutions.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: j@w1.fi, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Johannes Berg <johannes.berg@intel.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Johannes Berg <johannes.berg@intel.com>

In some cases, for example when the program(s) running inside UML
isn't/aren't interactive (like the hwsim tests for wpa_supplicant)
there's really no value in having the serial lines configured to
be raw as they are now by default. Setting them to non-raw lets
one abort the whole UML with Ctrl-C, which is really the right
thing to do in these cases, basically the whole UML instance is
more like a single (testing) program.

Add a "ssl-non-raw" option to UML to support such a mode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/chan_user.h | 2 +-
 arch/um/drivers/ssl.c       | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/chan_user.h b/arch/um/drivers/chan_user.h
index 03f1b565c5f9..3ae1ff6e3822 100644
--- a/arch/um/drivers/chan_user.h
+++ b/arch/um/drivers/chan_user.h
@@ -11,7 +11,7 @@
 struct chan_opts {
 	void (*const announce)(char *dev_name, int dev);
 	char *xterm_title;
-	const int raw;
+	int raw;
 };
 
 struct chan_ops {
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index 7ae407d5337e..cd91c70568c9 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -196,3 +196,11 @@ static int ssl_chan_setup(char *str)
 
 __setup("ssl", ssl_chan_setup);
 __channel_help(ssl_chan_setup, "ssl");
+
+static int ssl_non_raw_setup(char *str)
+{
+	opts.raw = 0;
+	return 1;
+}
+__setup("ssl-non-raw", ssl_non_raw_setup);
+__channel_help(ssl_non_raw_setup, "set serial lines to non-raw mode");
-- 
2.17.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

