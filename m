Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08292C54EBE
	for <linux-um@archiver.kernel.org>; Thu, 12 Jan 2023 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Subject:Cc:To:
	From:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=sPxgV6QSbiyaNA+fQVWOwuwh20PymDVMY7kc6H3S21I=; b=l+pHHy+8xRsSm2
	iBqu3fzR2Is5HloRt8tKqtzcqdUybPD05XYF/u80qQuPSmqzgK6N2LyzO8Fsr68/pYhpkkvRhgz0T
	p291MmUcseITOaY1HNy4j+pAJs6QZx7j8jqsG7Bbo2Bvsh4kJRXEuMhM3utfP6zwqUNCQyOeTPVsU
	j9lu85jLRtXQ5SiMTkzyZhkSJRCxLKNq4MEknu/c2bU1UoXBn6RnDE1aaqJ36p7yhfz1zsAjqABCO
	TvkFNO9SIeH3tMNr52kBoA1EImoJfyZKVVNHTSF5S7xNJKak64+98dRw3R07RDOdoL7S6OS/MD2Gz
	D8cRSm2sll0P+abCIUig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG5dR-00HJQW-D9; Thu, 12 Jan 2023 22:01:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG3hW-00Ggo5-N6; Thu, 12 Jan 2023 19:57:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=tM6S3oZ3zLjQ2zmmTNKitB7HqpfpXnjxYwChM2FqbVs=; b=BJ9XJoRA5PVXo6NmK1y1j4mgxX
	DGfe1Ta896F3qkk57KxqOit856Whx7pXr9WTIch0khohftRzZ6nkeSuCiqiAyMa3qg2JMRqTwkdcK
	SZHkiVrlqToqnjdTi1BQtMwas89d1b41aRk7eR9kktg5N/gi7TNwV9TPbfoKKOtW1UuX+e5CZ4VVW
	USTGfBuu27oryL5tL5ug+EeZMBWzLYDuLZxBl37/OJYoY11N2gX+VEM60a0w4sEUZTi5GdGd5oNiD
	v4tH8MxJ/EqxydLuQw6fRM3cmCP9pHy61QtCS2aoYs8Sik/mr9QPx70CAPy2SGTADTK3V7C39icf4
	nbFCLrEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG3hh-005Okk-PF; Thu, 12 Jan 2023 19:57:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B5C030346C;
	Thu, 12 Jan 2023 20:57:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
	id 573AE2CD066CC; Thu, 12 Jan 2023 20:57:08 +0100 (CET)
Message-ID: <20230112195541.906007455@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 12 Jan 2023 20:43:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: peterz@infradead.org
Cc: richard.henderson@linaro.org,
 ink@jurassic.park.msu.ru,
 mattst88@gmail.com,
 vgupta@kernel.org,
 linux@armlinux.org.uk,
 nsekhar@ti.com,
 brgl@bgdev.pl,
 ulli.kroll@googlemail.com,
 linus.walleij@linaro.org,
 shawnguo@kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 kernel@pengutronix.de,
 festevam@gmail.com,
 linux-imx@nxp.com,
 tony@atomide.com,
 khilman@kernel.org,
 krzysztof.kozlowski@linaro.org,
 alim.akhtar@samsung.com,
 catalin.marinas@arm.com,
 will@kernel.org,
 guoren@kernel.org,
 bcain@quicinc.com,
 chenhuacai@kernel.org,
 kernel@xen0n.name,
 geert@linux-m68k.org,
 sammy@sammy.net,
 monstr@monstr.eu,
 tsbogend@alpha.franken.de,
 dinguyen@kernel.org,
 jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi,
 shorne@gmail.com,
 James.Bottomley@HansenPartnership.com,
 deller@gmx.de,
 mpe@ellerman.id.au,
 npiggin@gmail.com,
 christophe.leroy@csgroup.eu,
 paul.walmsley@sifive.com,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 hca@linux.ibm.com,
 gor@linux.ibm.com,
 agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com,
 svens@linux.ibm.com,
 ysato@users.sourceforge.jp,
 dalias@libc.org,
 davem@davemloft.net,
 richard@nod.at,
 anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net,
 tglx@linutronix.de,
 mingo@redhat.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 x86@kernel.org,
 hpa@zytor.com,
 acme@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 namhyung@kernel.org,
 jgross@suse.com,
 srivatsa@csail.mit.edu,
 amakhalov@vmware.com,
 pv-drivers@vmware.com,
 boris.ostrovsky@oracle.com,
 chris@zankel.net,
 jcmvbkbc@gmail.com,
 rafael@kernel.org,
 lenb@kernel.org,
 pavel@ucw.cz,
 gregkh@linuxfoundation.org,
 mturquette@baylibre.com,
 sboyd@kernel.org,
 daniel.lezcano@linaro.org,
 lpieralisi@kernel.org,
 sudeep.holla@arm.com,
 agross@kernel.org,
 andersson@kernel.org,
 konrad.dybcio@linaro.org,
 anup@brainfault.org,
 thierry.reding@gmail.com,
 jonathanh@nvidia.com,
 jacob.jun.pan@linux.intel.com,
 atishp@atishpatra.org,
 Arnd Bergmann <arnd@arndb.de>,
 yury.norov@gmail.com,
 andriy.shevchenko@linux.intel.com,
 linux@rasmusvillemoes.dk,
 dennis@kernel.org,
 tj@kernel.org,
 cl@linux.com,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 frederic@kernel.org,
 paulmck@kernel.org,
 pmladek@suse.com,
 senozhatsky@chromium.org,
 john.ogness@linutronix.de,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 ryabinin.a.a@gmail.com,
 glider@google.com,
 andreyknvl@gmail.com,
 dvyukov@google.com,
 vincenzo.frascino@arm.com,
 Andrew Morton <akpm@linux-foundation.org>,
 jpoimboe@kernel.org,
 linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-omap@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,
 linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org,
 linux-perf-users@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 linux-xtensa@linux-xtensa.org,
 linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,
 linux-tegra@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 42/51] ubsan: Fix objtool UACCESS warns
References: <20230112194314.845371875@infradead.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 12 Jan 2023 14:00:44 -0800
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

clang-14 allyesconfig gives:

vmlinux.o: warning: objtool: emulator_cmpxchg_emulated+0x705: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
vmlinux.o: warning: objtool: paging64_update_accessed_dirty_bits+0x39e: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
vmlinux.o: warning: objtool: paging32_update_accessed_dirty_bits+0x390: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
vmlinux.o: warning: objtool: ept_update_accessed_dirty_bits+0x43f: call to __ubsan_handle_load_invalid_value() with UACCESS enabled

Add the required eflags save/restore and whitelist the thing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 lib/ubsan.c           |    5 ++++-
 tools/objtool/check.c |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -340,9 +340,10 @@ void __ubsan_handle_load_invalid_value(v
 {
 	struct invalid_value_data *data = _data;
 	char val_str[VALUE_LENGTH];
+	unsigned long ua_flags = user_access_save();
 
 	if (suppress_report(&data->location))
-		return;
+		goto out;
 
 	ubsan_prologue(&data->location, "invalid-load");
 
@@ -352,6 +353,8 @@ void __ubsan_handle_load_invalid_value(v
 		val_str, data->type->type_name);
 
 	ubsan_epilogue();
+out:
+	user_access_restore(ua_flags);
 }
 EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1068,6 +1068,7 @@ static const char *uaccess_safe_builtin[
 	"__ubsan_handle_type_mismatch",
 	"__ubsan_handle_type_mismatch_v1",
 	"__ubsan_handle_shift_out_of_bounds",
+	"__ubsan_handle_load_invalid_value",
 	/* misc */
 	"csum_partial_copy_generic",
 	"copy_mc_fragile",



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
