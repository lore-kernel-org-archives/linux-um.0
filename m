Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36C1C47E49
	for <linux-um@archiver.kernel.org>; Tue, 23 Jan 2024 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8spzwcmFRHC72Lgufce4/h4QXYK4NspzVLTysQU55Vo=; b=P++NOpzeCrXw1c2iBSK+7XXSYY
	DINTZZ3IpbHivLY9wnHCFsexcmTyllGgPbXRb4wamjEKYjbuafN3/pwcwAXrwEZGpOIuelHQnMltu
	JLjE5ra+Q97TxV3fbDfERg9QIfVEVSxstwDqqIgSQPikueFcB6RHA7O5Cn4gEUZHhnx8DW/yJ5CkX
	8ULvICwa/qq5gDEDsmqvtIF9Q6flwRF6UUD4odC180fAWsU9KLIUnDv6OpQGnht4gnB/omjmqzzBY
	JbyxGemEcRcQJQFu5OVpY4eGyi0clwg79rgpAocMj1YCWoFpT7bnj3U4YdaXH3LyBcg4Gr/m389n3
	T7Ay6JiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSPkh-000le0-33;
	Tue, 23 Jan 2024 23:00:19 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSPkc-000laA-1U
	for linux-um@lists.infradead.org;
	Tue, 23 Jan 2024 23:00:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 18F31CE3043;
	Tue, 23 Jan 2024 23:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FB9C43394;
	Tue, 23 Jan 2024 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706050809;
	bh=pqpVjk8HX7VL6g1Q9EMOtXMob1urEAYYXk6Z618rEPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jAoxWhCqM5qLtmyVk4cFQP+mwISnNe7n35p8T8gpypm9mTTinatigBB7ExR4Leip1
	 NlBgIXN/o57qF02Nlgzjhc9A4U29nI+WaBA2+106uaUNxOC/3peQfnK0SuPW1l5eQe
	 2jUZPdMPCWw0cdApKB0gFZfGIq/YDbuM64Kc5HYJqNnmtyaH2GMfZ2ktOk3hps396f
	 KswJ0c1mdynLwJtjI0aVlGgzhhNz2xfijdT96AxkTqrmVP2drGZphoapXsQ6uaigZV
	 CqluqWEP5y8HIwNOTWOVcKSlBaxnhiEljVPYj3UXiJxSxHwZObVdnOhGXKEoC3Zo3V
	 1mlJJfZ0m3Dqg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 23 Jan 2024 15:59:54 -0700
Subject: [PATCH 1/2] um: Fix adding '-no-pie' for clang
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-fix-uml-clang-18-v1-1-efc095519cf9@kernel.org>
References: <20240123-fix-uml-clang-18-v1-0-efc095519cf9@kernel.org>
In-Reply-To: <20240123-fix-uml-clang-18-v1-0-efc095519cf9@kernel.org>
To: richard@nod.at, anton.ivanov@cambridgegreys.com, 
 johannes@sipsolutions.net, masahiroy@kernel.org
Cc: nathan@kernel.org, nicolas@fjasle.eu, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, linux-um@lists.infradead.org, 
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 stable@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2539; i=nathan@kernel.org;
 h=from:subject:message-id; bh=pqpVjk8HX7VL6g1Q9EMOtXMob1urEAYYXk6Z618rEPA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKkbXL7XGN+6vvxLxcGMT3k7ljcENiwJYw3IvCTmpN86I
 aXyyepNHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAi8vmMDKvCe0V5P8XUOZQW
 83F9CenJOti0NvmYwTbR/1OnbHJ9cI+R4e25yU9n6x1e5bO/96HZW+fVgYtuXZ/ZmFjz6vmT3Zd
 cTzAAAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_150014_850139_5801F0CE 
X-CRM114-Status: GOOD (  13.77  )
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

The kernel builds with -fno-PIE, so commit 883354afbc10 ("um: link
vmlinux with -no-pie") added the compiler linker flag '-no-pie' via
cc-option because '-no-pie' was only supported in GCC 6.1.0 and newer.

While this works for GCC, this does not work for clang because cc-option
uses '-c', which stops the pipeline right before linking, so '-no-pie'
is unconsumed and clang warns, causing cc-option to fail just as it
would if the option was entirely unsupported:

  $ clang -Werror -no-pie -c -o /dev/null-x c /dev/null
  clang-16: error: argument unused during compilation: '-no-pie' [-Werror,-Wunused-command-line-argument]

A recent version of clang exposes this because it generates a relocation
under '-mcmodel=large' that is not supported in PIE mode:

  /usr/sbin/ld: init/main.o: relocation R_X86_64_32 against symbol `saved_command_line' can not be used when making a PIE object; recompile with -fPIE
  /usr/sbin/ld: failed to set dynamic section sizes: bad value
  clang: error: linker command failed with exit code 1 (use -v to see invocation)

Remove the cc-option check altogether. It is wasteful to invoke the
compiler to check for '-no-pie' because only one supported compiler
version does not support it, GCC 5.x (as it is supported with the
minimum version of clang and GCC 6.1.0+). Use a combination of the
gcc-min-version macro and CONFIG_CC_IS_CLANG to unconditionally add
'-no-pie' with CONFIG_LD_SCRIPT_DYN=y, so that it is enabled with all
compilers that support this. Furthermore, using gcc-min-version can help
turn this back into

  LINK-$(CONFIG_LD_SCRIPT_DYN) += -no-pie

when the minimum version of GCC is bumped past 6.1.0.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1982
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/um/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 82f05f250634..34957dcb88b9 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -115,7 +115,9 @@ archprepare:
 	$(Q)$(MAKE) $(build)=$(HOST_DIR)/um include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += $(call cc-option, -no-pie)
+ifdef CONFIG_LD_SCRIPT_DYN
+LINK-$(call gcc-min-version, 60100)$(CONFIG_CC_IS_CLANG) += -no-pie
+endif
 LINK-$(CONFIG_LD_SCRIPT_DYN_RPATH) += -Wl,-rpath,/lib
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \

-- 
2.43.0


