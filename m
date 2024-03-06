Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C18C54E5E
	for <linux-um@archiver.kernel.org>; Wed,  6 Mar 2024 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ziLtKkSqhI/U3k69c0/nGLWMWV6YVEamH20E92a/bd4=; b=Bzcnd903v0Sk3gSmO1NikL6ftZ
	Z9V2eX9rtUWECz1p+P6YnOGuet/A6b0UxShnprTbo4naW+yYHXnnwWeObg2ZMJmp0+YkXy3fyEdOy
	ILWVVOUo+hxdJPA/Mkn3HIlgPW7+RjkWGNf/LMM4eiHf5Riijg+eZ6hL25k8k6t6eX54f/J8+7GKF
	SFqhM88OzVrcp4xgCcETg/J005PeDJcDry++YS7KKGPuGfg1OZpcr3Yws5JIazyjgihaq4J39FyzP
	gtqxgPoKf15k4qgA+g76lIYjNoGdGwE7BMPSTVW/lRxK4g97E4TmRuJyrXZqKduOs7K0A1zKpREEd
	V6y8BuLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNJ-0000000HNBa-0qdP;
	Wed, 06 Mar 2024 10:19:49 +0000
Received: from out0-214.mail.aliyun.com ([140.205.0.214])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoNF-0000000HN88-1UYs
	for linux-um@lists.infradead.org;
	Wed, 06 Mar 2024 10:19:47 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047187;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-JT_1709720381;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-JT_1709720381)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:41 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 1/9] um: Make local functions and variables static
Date: Wed, 06 Mar 2024 18:19:17 +0800
Message-Id: <20240306101925.1088870-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_021945_696491_2D9E8089 
X-CRM114-Status: GOOD (  16.26  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

This will also fix the warnings like:

warning: no previous prototype for ‘fork_handler’ [-Wmissing-prototypes]
  140 | void fork_handler(void)
      |      ^~~~~~~~~~~~

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/pcap_kern.c              | 4 ++--
 arch/um/drivers/ubd_user.c               | 2 +-
 arch/um/kernel/kmsg_dump.c               | 2 +-
 arch/um/kernel/process.c                 | 8 ++++----
 arch/um/kernel/time.c                    | 6 +++---
 arch/um/os-Linux/drivers/ethertap_kern.c | 2 +-
 arch/um/os-Linux/drivers/tuntap_kern.c   | 2 +-
 arch/um/os-Linux/signal.c                | 4 ++--
 arch/x86/um/os-Linux/registers.c         | 2 +-
 arch/x86/um/tls_32.c                     | 2 +-
 10 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/um/drivers/pcap_kern.c b/arch/um/drivers/pcap_kern.c
index 25ee2c97ca21..d9bf95d7867b 100644
--- a/arch/um/drivers/pcap_kern.c
+++ b/arch/um/drivers/pcap_kern.c
@@ -15,7 +15,7 @@ struct pcap_init {
 	char *filter;
 };
 
-void pcap_init_kern(struct net_device *dev, void *data)
+static void pcap_init_kern(struct net_device *dev, void *data)
 {
 	struct uml_net_private *pri;
 	struct pcap_data *ppri;
@@ -50,7 +50,7 @@ static const struct net_kern_info pcap_kern_info = {
 	.write			= pcap_write,
 };
 
-int pcap_setup(char *str, char **mac_out, void *data)
+static int pcap_setup(char *str, char **mac_out, void *data)
 {
 	struct pcap_init *init = data;
 	char *remain, *host_if = NULL, *options[2] = { NULL, NULL };
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index a1afe414ce48..b4f8b8e60564 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -23,7 +23,7 @@
 #include <os.h>
 #include <poll.h>
 
-struct pollfd kernel_pollfd;
+static struct pollfd kernel_pollfd;
 
 int start_io_thread(unsigned long sp, int *fd_out)
 {
diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 427dd5a61a38..4382cf02a6d1 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -57,7 +57,7 @@ static struct kmsg_dumper kmsg_dumper = {
 	.dump = kmsg_dumper_stdout
 };
 
-int __init kmsg_dumper_stdout_init(void)
+static int __init kmsg_dumper_stdout_init(void)
 {
 	return kmsg_dump_register(&kmsg_dumper);
 }
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index ab95648e93e1..20f3813143d8 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -137,7 +137,7 @@ void new_thread_handler(void)
 }
 
 /* Called magically, see new_thread_handler above */
-void fork_handler(void)
+static void fork_handler(void)
 {
 	force_flush_all();
 
@@ -268,14 +268,14 @@ int clear_user_proc(void __user *buf, int size)
 static atomic_t using_sysemu = ATOMIC_INIT(0);
 int sysemu_supported;
 
-void set_using_sysemu(int value)
+static void set_using_sysemu(int value)
 {
 	if (value > sysemu_supported)
 		return;
 	atomic_set(&using_sysemu, value);
 }
 
-int get_using_sysemu(void)
+static int get_using_sysemu(void)
 {
 	return atomic_read(&using_sysemu);
 }
@@ -313,7 +313,7 @@ static const struct proc_ops sysemu_proc_ops = {
 	.proc_write	= sysemu_proc_write,
 };
 
-int __init make_proc_sysemu(void)
+static int __init make_proc_sysemu(void)
 {
 	struct proc_dir_entry *ent;
 	if (!sysemu_supported)
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 3e270da6b6f6..efa5b9c97992 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -319,7 +319,7 @@ void time_travel_add_event_rel(struct time_travel_event *e,
 	time_travel_add_event(e, time_travel_time + delay_ns);
 }
 
-void time_travel_periodic_timer(struct time_travel_event *e)
+static void time_travel_periodic_timer(struct time_travel_event *e)
 {
 	time_travel_add_event(&time_travel_timer_event,
 			      time_travel_time + time_travel_timer_interval);
@@ -812,7 +812,7 @@ unsigned long calibrate_delay_is_known(void)
 	return 0;
 }
 
-int setup_time_travel(char *str)
+static int setup_time_travel(char *str)
 {
 	if (strcmp(str, "=inf-cpu") == 0) {
 		time_travel_mode = TT_MODE_INFCPU;
@@ -862,7 +862,7 @@ __uml_help(setup_time_travel,
 "devices using it, assuming the device has the right capabilities.\n"
 "The optional ID is a 64-bit integer that's sent to the central scheduler.\n");
 
-int setup_time_travel_start(char *str)
+static int setup_time_travel_start(char *str)
 {
 	int err;
 
diff --git a/arch/um/os-Linux/drivers/ethertap_kern.c b/arch/um/os-Linux/drivers/ethertap_kern.c
index 3182e759d8de..5e5ee40680ce 100644
--- a/arch/um/os-Linux/drivers/ethertap_kern.c
+++ b/arch/um/os-Linux/drivers/ethertap_kern.c
@@ -63,7 +63,7 @@ const struct net_kern_info ethertap_kern_info = {
 	.write 			= etap_write,
 };
 
-int ethertap_setup(char *str, char **mac_out, void *data)
+static int ethertap_setup(char *str, char **mac_out, void *data)
 {
 	struct ethertap_init *init = data;
 
diff --git a/arch/um/os-Linux/drivers/tuntap_kern.c b/arch/um/os-Linux/drivers/tuntap_kern.c
index adcb6717be6f..ff022d9cf0dd 100644
--- a/arch/um/os-Linux/drivers/tuntap_kern.c
+++ b/arch/um/os-Linux/drivers/tuntap_kern.c
@@ -53,7 +53,7 @@ const struct net_kern_info tuntap_kern_info = {
 	.write 			= tuntap_write,
 };
 
-int tuntap_setup(char *str, char **mac_out, void *data)
+static int tuntap_setup(char *str, char **mac_out, void *data)
 {
 	struct tuntap_init *init = data;
 
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 24a403a70a02..787cfb9a0308 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -72,7 +72,7 @@ static int signals_blocked;
 static unsigned int signals_pending;
 static unsigned int signals_active = 0;
 
-void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
+static void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
 	int enabled = signals_enabled;
 
@@ -108,7 +108,7 @@ static void timer_real_alarm_handler(mcontext_t *mc)
 	timer_handler(SIGALRM, NULL, &regs);
 }
 
-void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
+static void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 {
 	int enabled;
 
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index df8f4b4bf98b..f3638dd09cec 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -17,7 +17,7 @@
 #include <linux/elf.h>
 #include <registers.h>
 
-int have_xstate_support;
+static int have_xstate_support;
 
 int save_i387_registers(int pid, unsigned long *fp_regs)
 {
diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
index 66162eafd8e8..ba40b1b8e179 100644
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -20,7 +20,7 @@
 static int host_supports_tls = -1;
 int host_gdt_entry_tls_min;
 
-int do_set_thread_area(struct user_desc *info)
+static int do_set_thread_area(struct user_desc *info)
 {
 	int ret;
 	u32 cpu;
-- 
2.34.1


