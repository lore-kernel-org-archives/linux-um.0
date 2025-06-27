Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FE5C77B7F
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rfFwdmy9/JdTfjNSfvft15w/tPyM52XZ4lS0hDHawKI=; b=aiB7+1ft/rWDkUnTdLfhVo/8kI
	Q7byTGwzB2Wf6Tmg2jzsz//Xvo+5omDM/DraHu+BfJUQxaQh44XeY1CcjvjfqT4q0SV4tOEQzKQEU
	MI24HSUMo2I1oo/IgnKRfqPTCeCcxNY4l1N5v1OVU4ROYr4UAlzLZ+MtTZlApbeHBMTl8lWe8VHpt
	lAFjh3rHRT1my37pSJeuymdUAHWIxf74U1OmHIGGaIpHOVMi7rCDJlASSNq6yvH8p+wM5iXJW1n8F
	zf14FthAb1QRU29Sb6vQsr2HPQPku8udXY7FKp6NWDNQam4OesuWfPy9ySDtwsRTSLKhkaoOkj2Ji
	NNh9Nm4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV5KV-0000000E6u4-1RHy;
	Fri, 27 Jun 2025 09:25:07 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV5IS-0000000E6W4-38Zv
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 09:23:02 +0000
Date: Fri, 27 Jun 2025 11:22:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751016179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfFwdmy9/JdTfjNSfvft15w/tPyM52XZ4lS0hDHawKI=;
	b=Wkwa4rAnaASdGiyqFB0bxnzM8NWxvwsTBCLTHTwEwvWH9P57McHntt0GuLTPhnXZsHuD71
	ymK/RwGeCDeN8HrCdXyhUNcWIMRf+svPWGIhX6jZvqQzArIxiPrdV26/yzQSyIeC2zdm1Y
	vO4xpxG88YauAUTg3aTHpL2vyjCohkxGJCBJ7n52Xn8B00mvvxq0z7+ah5DXI1emRJ4oMA
	peyyueBfyLggyPqMuijrlgkYMNiYliHc41pXAeD0VYJ8lcJuTfavdhGcDqpsAs63cn+q4r
	+nP7etAIOK/suV+ft8aOovL1vQR8brUMoX6VaHqrLG8MNu0tQIKLD+LXLct3Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751016179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfFwdmy9/JdTfjNSfvft15w/tPyM52XZ4lS0hDHawKI=;
	b=T7S31f2JKAhqkxPJUfVqW6Tcwcp+y0SJDt0Aw1x/gsyX8hJPmfSiaWIAD34/JZ5Vt5InMT
	nMkNQzjzzToJDRCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: kunit-dev@googlegroups.com, linux-um@lists.infradead.org
Subject: Re: [RFC 0/2] Experimental kunit test for signal context handling
Message-ID: <20250627111257-53a9219c-af39-4596-aaca-9b8806302ee4@linutronix.de>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
 <20250627062337-a67a262d-5957-42cf-8bc0-69388f4ae078@linutronix.de>
 <4e5a205eee41abf84c3d3340275833c20b7d7050.camel@sipsolutions.net>
 <20250627103520-c7f8d4cd-9c85-4e87-b7de-b6d9fb1310e3@linutronix.de>
 <89cbc0bdb9b4894ca073dac56406b02eeee3ece5.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89cbc0bdb9b4894ca073dac56406b02eeee3ece5.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_022300_927137_1D4EA6EC 
X-CRM114-Status: GOOD (  40.64  )
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

On Fri, Jun 27, 2025 at 10:48:30AM +0200, Benjamin Berg wrote:
> Hi,
> 
> On Fri, 2025-06-27 at 10:43 +0200, Thomas Weißschuh wrote:
> > On Fri, Jun 27, 2025 at 09:29:12AM +0200, Benjamin Berg wrote:
> > > On Fri, 2025-06-27 at 06:33 +0200, Thomas Weißschuh wrote:
> > > > On Thu, Jun 26, 2025 at 09:57:12PM +0200, Benjamin Berg wrote:
> > > > > so I saw the UAPI testing framework patches and wondered whether I could
> > > > > hack up a kunit test for userspace signal mcontext handling. I already
> > > > > had some code, but never knew where to include it. Having it as a kunit
> > > > > test in this way seems nice as it makes running the test really simple.
> > > > 
> > > > Nice to hear that you find it useful.
> > > > 
> > > > > This is a very rough attempt with an extra patch to add sigaction
> > > > > support as that is needed by the test.
> > > > > 
> > > > > Note that this type of test could possibly be shared with the x86
> > > > > architecture (though UM does not support all features).
> > > > 
> > > > Can the expected feature detection be performed at runtime?
> > > > If so I would write the test as x86 kselftest in tools/testing/kselftests/x86/
> > > > and then also hook it up for kunit on UML and x86.
> > > > This gives you the advantages of all worlds.
> > > > 
> > > > For an example see [0]. That is still based on an old version of the framework,
> > > > so can't be used as-is. But you should get the idea.
> > > 
> > > That looks nice, and you do support both x86 and um there!
> > > 
> > > Many of those checks should be simple as syscalls will return an error
> > > (modify_ldt should return -ENOSYS for example). For more arcane things
> > > one could e.g. add "(um)" into AT_PLATFORM or just disable the kunit
> > > test for the um architecture.
> > 
> > Sounds good.
> > 
> > > This is a nice development, I absolutely expect to find some bugs in um
> > > this way.
> > 
> > I do so, too :-)
> > 
> > https://lore.kernel.org/lkml/20250617-uml-tick-timer-v1-1-01aab312f56b@linutronix.de/
> 
> Ah, yes, that one :-)
> 
> > To be honest if there are going to be a bunch of issues on UML,
> > I'd prefer to drop the UML bits from my submissions.
> > I'm not familiar with UML and can't really fix the fallout.
> > Then you can wire up the tests with a few lines and handle the fallout at
> > your convenience.
> > 
> > Or we gate the testcases behind BROKEN/EXPORT on UML in the beginning.
> > 
> > Does this sound reasonable?
> 
> Not sure how to gate them, but I do like the idea of being able to
> enable them using only minor modifications or even a Kconfig option to
> see what happens on UM.

With my WIP x86 enablement commit as example [0].


Possibility 1, I *drop* these two hunks, you can readd them:

diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 986045d5e63854..f2aeaf1e8e6d9a 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -3,6 +3,7 @@
 menu "Host processor type and features"
 
 source "arch/x86/Kconfig.cpu"
+source "arch/x86/tests/Kconfig"
 
 endmenu
 
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index b42c31cd2390cb..e71bb244afac9d 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -13,7 +13,7 @@ obj-y = bugs_$(BITS).o delay.o fault.o \
 	ptrace.o ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
-	mem_$(BITS).o subarch.o os-Linux/
+	mem_$(BITS).o subarch.o os-Linux/ ../tests/
 
 ifeq ($(CONFIG_X86_32),y)


Possibility 2, the kconfig looks like this:

config X86_UAPI_TEST
        tristate "x86 UAPI tests" if !KUNIT_ALL_TESTS
        depends on KUNIT_UAPI
	depends on !UML || BROKEN
        default KUNIT_ALL_TESTS

You enable CONFIG_BROKEN and can run the tests.

Of course as soon as all tests work on UML, this all goes away and they
stay enabled.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git/commit/?h=kunit-kselftests-integration&id=14bf93f09eaa328a18e9190f46fa4ee697378617

