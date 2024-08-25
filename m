Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDF8C5320E
	for <linux-um@archiver.kernel.org>; Sun, 25 Aug 2024 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asbg7BYlj4ZFgiVrwgb1Wswlv6diZDiLLgBcqea48xc=; b=dZwyMmH+gSbWD+fliKXD1Me+fp
	LUWZre9m62cMdRXapCK/keFDQVtc2b9qQ9CuM5Uo6TlzzMC53RBpo5V5f6D6xPlQXhTgfqN+quPQ3
	VicMvwar5dBd+YmRZobjsQW9IEUB3xF9MgFsE7VxqS0wnEjVUPfBAfDuYyyFDzAUUwjvr5jI5KeL6
	MaerLlliYLUAar4uZpNC15zOG2LcARuU5zKJrS9Eshn1SZv5qD5YKtrc8KKfIONkmXiTLNt8z1I31
	nlj+ggZUf3fW0me/NGEq8sPOZAiWGNhI1J38PkOl5nMjjeX0O1vTuWHzOZam8AUdYqKQPLfrjRRtm
	FaolT+Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siC6l-00000004G4x-1xBe;
	Sun, 25 Aug 2024 12:12:35 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siC6g-00000004G3L-0FV5
	for linux-um@lists.infradead.org;
	Sun, 25 Aug 2024 12:12:33 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724587948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=asbg7BYlj4ZFgiVrwgb1Wswlv6diZDiLLgBcqea48xc=;
	b=RriSFBj2vDDUs2J9MepRaX1WU4HV5T31ItjTQdAPICrFKbnSbJKqI6ghRbD9nepkX0MQTp
	B8MVoOiYVT9zlJS9xBNMdvBUimnGoQkuPqkCtfWVVzOchRNU9SMDupjEjOexXpol0/tbnH
	G06poRLAw9E5XsaxTg34bKYKBPSCh4Q5AE/85Hg2vxlVUCvhHcwtE4t0Uhopt1k1CIFkRf
	ceQibitytHaEPhbMJxnrIvpeQC07fgsyLoOYvRwcyKZdvsE2WTuNcWbe17QvxXCG4E3ZCk
	UQsoIqX+Hl350cnsNW4Gsu4MpoA61jdwQWsILSel4Ttv7wEY9j24TWETTpcDLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724587948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=asbg7BYlj4ZFgiVrwgb1Wswlv6diZDiLLgBcqea48xc=;
	b=CMp1ks+TWlx6LMjmObNiYxsYpvfW1kxsSLXGKg6bqsPEM0EA/xzXuJ7hDSi56zSOsJgCmE
	JubKYVxuspFiVbAA==
To: Wentao Zhang <wentaoz5@illinois.edu>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org
Cc: wentaoz5@illinois.edu, marinov@illinois.edu, tyxu@illinois.edu,
 jinghao7@illinois.edu, tingxur@illinois.edu,
 steven.h.vanderleest@boeing.com, chuck.wolber@boeing.com,
 matthew.l.weber3@boeing.com, Matt.Kelly2@boeing.com,
 andrew.j.oppelt@boeing.com, samuel.sarkisian@boeing.com, morbo@google.com,
 samitolvanen@google.com, masahiroy@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, luto@kernel.org,
 ardb@kernel.org, richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, arnd@arndb.de, rostedt@goodmis.org,
 mhiramat@kernel.org, oberpar@linux.ibm.com, akpm@linux-foundation.org,
 paulmck@kernel.org, bhelgaas@google.com, kees@kernel.org,
 jpoimboe@kernel.org, peterz@infradead.org, kent.overstreet@linux.dev,
 nathan@kernel.org, hpa@zytor.com, mathieu.desnoyers@efficios.com,
 ndesaulniers@google.com, justinstitt@google.com, maskray@google.com,
 dvyukov@google.com
Subject: Re: [RFC PATCH 2/3] kbuild, llvm-cov: disable instrumentation in
 odd or sensitive code
In-Reply-To: <20240824230641.385839-3-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240824230641.385839-3-wentaoz5@illinois.edu>
Date: Sun, 25 Aug 2024 14:12:27 +0200
Message-ID: <878qwkg5sk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_051230_266268_3FA4EB5C 
X-CRM114-Status: UNSURE (   8.89  )
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

On Sat, Aug 24 2024 at 18:06, Wentao Zhang wrote:

The subject line is really not useful. What's 'odd' code?

> Disable instrumentation in the same areas that were disabled for
> kernel/gcov/

> Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
> Signed-off-by: Chuck Wolber <chuck.wolber@boeing.com>

This Signed-off-by chain is broken. See Documentation/process/

> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 9cc0ff6e9067..2cc2c55af305 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -57,6 +57,7 @@ KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
>  KBUILD_CFLAGS	+= $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
> +LLVM_COV_PROFILE := n

See 7f7f6f7ad654 ("Makefile: remove redundant tool coverage variables")

Also a 'git grep GCOV_PROFILE' shows way more places. Can't LLVM_COV
just use the already existing GCOV_PROFILE annotations or is LLVM_COV
suitable for all the files which have been excluded for GCOV?

GCOV has GCOV_PROFILE_obj.o, GCOV_PROFILE and CONFIG_GCOV_PROFILE_ALL
for a reason, no?

Thanks,

        tglx

