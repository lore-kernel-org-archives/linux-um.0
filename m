Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE27CA0EEB
	for <linux-um@archiver.kernel.org>; Sun, 24 Aug 2025 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8GOKSVQZfgD9OUlxTARvTO4ehyW2keQdi8b1GG1yF0A=; b=mBKZDVQbhF4ywrJ3+pgub0ydFk
	Eer0ml5xjW9gKAWafNU+6VYckQ2QbY0NiNntTXLBPhw+GoO91TsaGQzt0MNUECRjy0OpOOO3rX1Iv
	kGV5atq0OIlVt2afCY+R3t0hNi9Is0XQ8s4/lpZ2YcIDdl3n8Qet/FDBgyhqiP33t5mqPt2U1WvEv
	7tSVWo0y9S6mrTlv/IUZ3MeL13CCotcig1Vv3rFyRUXSNPljuU0M0j0pzN6XCmczcbPxGkDn3vkyO
	d9fU+NxNnIeu6TfV3XWzGC9XmvgefimNXdEGKiIeyU8NJCoOk2KLUFC2EY0nGI19N77of/+DIMCjg
	3PtJqsZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCuC-00000006JFJ-0vkd;
	Sun, 24 Aug 2025 15:45:16 +0000
Received: from out-181.mta1.migadu.com ([95.215.58.181])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqCu9-00000006JDt-1MYC
	for linux-um@lists.infradead.org;
	Sun, 24 Aug 2025 15:45:14 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756050299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8GOKSVQZfgD9OUlxTARvTO4ehyW2keQdi8b1GG1yF0A=;
	b=MwlK3MwAm9xUWFmHq1e0u8oqGgSKWf0jRcSRkw20c+J1FnUgG8ni1ThK2nkHLngjctG8t+
	itXM0C23uBf06d+k1EJ41WqAgqsXxSmt4WYd0HEHnCquMUQC5cRMTP8iVTf5UFgH//RsPA
	wSqGyzNpbhGuAFx1aNFrQGccXgiOvSw=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 1/7] um: Add missing trailing newline to help messages
Date: Sun, 24 Aug 2025 23:44:19 +0800
Message-Id: <20250824154425.2243375-2-tiwei.bie@linux.dev>
In-Reply-To: <20250824154425.2243375-1-tiwei.bie@linux.dev>
References: <20250824154425.2243375-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250824_084513_781410_7A7185AF 
X-CRM114-Status: GOOD (  14.57  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

Some help messages are missing a trailing newline. They should
end with two newlines, but only one is present. Add the missing
newline to make the --help output more readable.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/ubd_kern.c      | 2 +-
 arch/um/kernel/dtb.c            | 2 +-
 arch/um/kernel/time.c           | 5 +++--
 arch/um/os-Linux/skas/process.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 4de6613e7468..01bbd39722c0 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -370,7 +370,7 @@ __uml_help(ubd_setup,
 "    useful when a unique number should be given to the device. Note when\n"
 "    specifying a label, the filename2 must be also presented. It can be\n"
 "    an empty string, in which case the backing file is not used:\n"
-"       ubd0=File,,Serial\n"
+"       ubd0=File,,Serial\n\n"
 );
 
 static int udb_setup(char *str)
diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index 15c342426489..47cd3d869fb2 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -38,5 +38,5 @@ static int __init uml_dtb_setup(char *line, int *add)
 
 __uml_setup("dtb=", uml_dtb_setup,
 "dtb=<file>\n"
-"    Boot the kernel with the devicetree blob from the specified file.\n"
+"    Boot the kernel with the devicetree blob from the specified file.\n\n"
 );
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index ae0fa2173778..cce5e3371e9f 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -1005,7 +1005,7 @@ __uml_help(setup_time_travel,
 "have more than one system simultaneously be on simulated time. The virtio\n"
 "driver code in UML knows about this so you can also simulate networks and\n"
 "devices using it, assuming the device has the right capabilities.\n"
-"The optional ID is a 64-bit integer that's sent to the central scheduler.\n");
+"The optional ID is a 64-bit integer that's sent to the central scheduler.\n\n");
 
 static int setup_time_travel_start(char *str)
 {
@@ -1023,7 +1023,8 @@ __setup("time-travel-start=", setup_time_travel_start);
 __uml_help(setup_time_travel_start,
 "time-travel-start=<nanoseconds>\n"
 "Configure the UML instance's wall clock to start at this value rather than\n"
-"the host's wall clock at the time of UML boot.\n");
+"the host's wall clock at the time of UML boot.\n\n");
+
 static struct kobject *bc_time_kobject;
 
 static ssize_t bc_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 78f48fa9db8b..0bc10cd4cbed 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -895,7 +895,7 @@ __uml_setup("noreboot", noreboot_cmd_param,
 "noreboot\n"
 "    Rather than rebooting, exit always, akin to QEMU's -no-reboot option.\n"
 "    This is useful if you're using CONFIG_PANIC_TIMEOUT in order to catch\n"
-"    crashes in CI\n");
+"    crashes in CI\n\n");
 
 void reboot_skas(void)
 {
-- 
2.34.1


