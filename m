Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30CACA0FED
	for <linux-um@archiver.kernel.org>; Wed, 27 Aug 2025 00:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fIq57wQ3Io9fkaq+le9rM2AmFRNmlsP5QTERI0e54Ww=; b=yeLhjNeVvl995VN0+a0l3vQdSO
	F+o/rU5/96cBq4P71am/SId9j7Q/EDOfrjAtJDJehzl7CNBrdUdd4R3UeADq6Ww5n/FKqt9lGrE5Z
	1Lcr/fcb69yR56R819X4jCywDNHFtzpDvPYrAu7rO5xZzU3Afeec8eTRID2VxL93eoxeTLgR7WwKI
	KLiLlyMNEKNBwrjiyW+l3fX5F4FbcW4m1l+3lQ5nHjZ0XQqtx5gDLrowX4E5AOH7qSC+gVFaMbNBH
	0DUOxV9D3A1wAOhqxfdvhBLbmxsULz/az3vR7SZpJs+FjAtHWh+744m77gtEibfSIbIUk/7JKOCAa
	rfIkVzvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4Tq-0000000DTPO-2UeC;
	Wed, 27 Aug 2025 00:57:38 +0000
Received: from out-174.mta1.migadu.com ([95.215.58.174])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur4Tp-0000000DTOc-0B4a
	for linux-um@lists.infradead.org;
	Wed, 27 Aug 2025 00:57:38 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756256255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fIq57wQ3Io9fkaq+le9rM2AmFRNmlsP5QTERI0e54Ww=;
	b=fvnWGAM2+xi+Xg4TX99Gt1pQqLHjXMVEtAp2Vsp1O3hLdt5xaYit9udRxUyZl0qnnnIEl1
	t0dPxUFWIJRxudyKOIohYp/nTFWZBNENhw68O+/eb4UWB1nZ/z0nQYw6NVoQDfCgSNKGQw
	+gMvxzluHDTvSL+2W1zkKWgsiy1PfOU=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v2 4/7] um: Indent time-travel help messages
Date: Wed, 27 Aug 2025 08:57:00 +0800
Message-Id: <20250827005703.3847636-5-tiwei.bie@linux.dev>
In-Reply-To: <20250827005703.3847636-1-tiwei.bie@linux.dev>
References: <20250827005703.3847636-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_175737_219988_31FBD4E9 
X-CRM114-Status: GOOD (  11.99  )
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

Indent the help messages for time-travel to make them consistent
with the format of other help messages.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/time.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index cce5e3371e9f..17da0a870650 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -986,26 +986,26 @@ static int setup_time_travel(char *str)
 __setup("time-travel", setup_time_travel);
 __uml_help(setup_time_travel,
 "time-travel\n"
-"This option just enables basic time travel mode, in which the clock/timers\n"
-"inside the UML instance skip forward when there's nothing to do, rather than\n"
-"waiting for real time to elapse. However, instance CPU speed is limited by\n"
-"the real CPU speed, so e.g. a 10ms timer will always fire after ~10ms wall\n"
-"clock (but quicker when there's nothing to do).\n"
+"    This option just enables basic time travel mode, in which the clock/timers\n"
+"    inside the UML instance skip forward when there's nothing to do, rather than\n"
+"    waiting for real time to elapse. However, instance CPU speed is limited by\n"
+"    the real CPU speed, so e.g. a 10ms timer will always fire after ~10ms wall\n"
+"    clock (but quicker when there's nothing to do).\n"
 "\n"
 "time-travel=inf-cpu\n"
-"This enables time travel mode with infinite processing power, in which there\n"
-"are no wall clock timers, and any CPU processing happens - as seen from the\n"
-"guest - instantly. This can be useful for accurate simulation regardless of\n"
-"debug overhead, physical CPU speed, etc. but is somewhat dangerous as it can\n"
-"easily lead to getting stuck (e.g. if anything in the system busy loops).\n"
+"    This enables time travel mode with infinite processing power, in which there\n"
+"    are no wall clock timers, and any CPU processing happens - as seen from the\n"
+"    guest - instantly. This can be useful for accurate simulation regardless of\n"
+"    debug overhead, physical CPU speed, etc. but is somewhat dangerous as it can\n"
+"    easily lead to getting stuck (e.g. if anything in the system busy loops).\n"
 "\n"
 "time-travel=ext:[ID:]/path/to/socket\n"
-"This enables time travel mode similar to =inf-cpu, except the system will\n"
-"use the given socket to coordinate with a central scheduler, in order to\n"
-"have more than one system simultaneously be on simulated time. The virtio\n"
-"driver code in UML knows about this so you can also simulate networks and\n"
-"devices using it, assuming the device has the right capabilities.\n"
-"The optional ID is a 64-bit integer that's sent to the central scheduler.\n\n");
+"    This enables time travel mode similar to =inf-cpu, except the system will\n"
+"    use the given socket to coordinate with a central scheduler, in order to\n"
+"    have more than one system simultaneously be on simulated time. The virtio\n"
+"    driver code in UML knows about this so you can also simulate networks and\n"
+"    devices using it, assuming the device has the right capabilities.\n"
+"    The optional ID is a 64-bit integer that's sent to the central scheduler.\n\n");
 
 static int setup_time_travel_start(char *str)
 {
@@ -1022,8 +1022,8 @@ static int setup_time_travel_start(char *str)
 __setup("time-travel-start=", setup_time_travel_start);
 __uml_help(setup_time_travel_start,
 "time-travel-start=<nanoseconds>\n"
-"Configure the UML instance's wall clock to start at this value rather than\n"
-"the host's wall clock at the time of UML boot.\n\n");
+"    Configure the UML instance's wall clock to start at this value rather than\n"
+"    the host's wall clock at the time of UML boot.\n\n");
 
 static struct kobject *bc_time_kobject;
 
-- 
2.34.1


