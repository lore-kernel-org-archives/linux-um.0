Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8A2CD342F
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8Zb9AvGELcXZwsqbS3wNKONJRCCvILrQd2gTJgh18V8=; b=mGGp6CJrdv2DLXy3bilZyCeo7Q
	dds5kSVvL48LbbAW9R1l/+tDKNylRHXNqUC0Ekkhu/miejhAvST0FcKHCpa4/MJUvZavBZFw0TUUU
	YRGxmBHdaCMROr2FTQoyenMSXNpyVNas6QsF78+0n0REmQU6RIMuytH8OdzCXxODAxQoBH9U7YusB
	CBqeZtyLcK06NVK+sTg4JvbukxR+e1yIlPlCYZ90C+hVoZMrCWzYGFROjDpzwx3+pvGAxZaGoPo5V
	YsOZuQuCpmAJDh9Vo1FoxgO869RnfpezLwHSlVV8LNG1HFDNwQpdrvZzOhZ3B9EjArXfgN0inPfws
	7294puvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTGb-00000000In8-1nPc;
	Tue, 03 Sep 2024 13:08:17 +0000
Received: from smtpbguseast1.qq.com ([54.204.34.129])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTGX-00000000Ih1-1dRx
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 13:08:15 +0000
X-QQ-mid: bizesmtp88t1725368783t223hx0z
X-QQ-Originating-IP: qap3eIf9cahdFTsqlxew/Xldv5nVj7nlHj3Cnw0v890=
Received: from localhost.localdomain ( [203.119.160.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Sep 2024 21:06:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 186613237743599165
From: Zigit Zo <zig@iorw.io>
To: ojeda@kernel.org,
	bjorn3_gh@protonmail.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	gary@garyguo.net
Cc: zig@iorw.io,
	rust-for-linux@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rust: arch/um: Rust modules support for UML
Date: Tue,  3 Sep 2024 21:06:04 +0800
Message-ID: <62F5EEA0B866E9E0+20240903130606.292935-1-zig@iorw.io>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:iorw.io:qybglogicsvrgz:qybglogicsvrgz8a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_060813_944608_ACF03AAB 
X-CRM114-Status: UNSURE (   7.45  )
X-CRM114-Notice: Please train this message.
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

The series make Rust modules running under x86_64 UML, as a supplement
for the previous work:
- https://lore.kernel.org/rust-for-linux/20221217044436.4138642-1-davidgow@google.com/

The previous work by David (many thanks!) has made the Rust UML compiles,
and for the builtin modules, it works as expected. But for loadable
modules, the UML will complain

  'Unknown rela relocation: 9'

when we try to 'insmod rust_print.ko'. That's because the modules are
compiled against '-Crelocation-model=pie', makes the LLVM treat the
modules as PIE executables, but they are just static modules.

Besides, the Rust's code model for x86_64 UML is still 'kernel', leading
some relocations "overflowed", we keep it the same as 'KBUILD_CFLAGS'
set in UML ('large' here) to address it.

Now we can test our Rust modules in UML.

Regards,
-- Zigit

Zigit Zo (2):
  rust: arch/um: use 'static' relocation model for uml modules
  rust: arch/um: use 'large' code model for uml

 arch/um/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
-- 
2.46.0


