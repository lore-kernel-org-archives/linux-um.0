Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DFA606A32C
	for <linux-um@archiver.kernel.org>; Fri,  6 Nov 2026 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HzSxsGoX;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVtOZoHl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BVgc+AzhfIkWn3XFbykm8OIvXrj/6LpWvdi1FoSSDjc=; b=HzSxsGoXIX2Idq
	eVJm8VNTbG6E9AUECG/fuuzAN3hVORRK2AZYDQwaAD5ivomAHobPqwjCKAFfvyO8VEwoyU4hqRnJu
	XCRE3VTh4+aXXanJrCkPP5gLn8WIMKtjmQXWl2iRSyW/8eLDjQgCqH5rSwAi6HEzqpsB9Ts+uJWdT
	3MbjPcgZxgdx5Jt1+T5n4c4nYRrW9ir1ZBavzz3CqJCh6wa0utD60ftKlhDFcg1T1Yd7PZAg0Lnbu
	Fl7pFHHC8SUxiQJEyIAgYgRh7wavJpVF+kzm36zsGya0UsrumSCsTBd4oa6Y9P3U6BcUqVwBknyFg
	8+D4zKOT4crRiq6ES+9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP8ON-0000000AxT6-1fqt;
	Fri, 06 Nov 2026 01:05:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP8OL-0000000AxSt-2gxM
	for linux-um@lists.infradead.org;
	Fri, 06 Nov 2026 01:05:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CBAFB605DC;
	Fri,  6 Nov 2026 01:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B2C1F0089F;
	Fri,  6 Nov 2026 01:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793927116;
	bh=BVgc+AzhfIkWn3XFbykm8OIvXrj/6LpWvdi1FoSSDjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TVtOZoHlI6hCOwoFtnb5qhDpwAK0a5Plk//VfLhhH2lY+RegXuCbeexltBAJnrUJj
	 GMJbPTzbm5DwX4B9ohk3ep+c8ZWRmL9L67gOZyalcncjEUtxQ8bRzEyPFlDqH6l5bt
	 bvA4tNM/LOPp4RkUTGWrSirFXFAq4mvflA4D7zMJSD+Oy8M7GoR1UbWXbV8Y7CqLgX
	 9p4fryCb3DoF1wHm8Y8DJilz6vJw3zIkuDFUW0fH/F/LpNCBq4Y2x2nC4lViGmnPcR
	 0Tr6+XHjsmpwb5BUngBvD3Vd/uFOV0lsWws/0srVyUlIw6ALDN4xBSaH7D0DZhDsQ/
	 AW6KTDiI5FrKw==
From: Sasha Levin <sashal@kernel.org>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Chuck Wolber <chuck@wolber.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	linux-kbuild@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	Marco Elver <elver@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nsc@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Thomas Gleixner <tglx@kernel.org>,
	x86@kernel.org
Subject: Re: [PATCH v2 19/20] gcov: add MC/DC condition coverage support
Date: Thu,  5 Nov 2026 20:05:12 -0500
Message-ID: <20261106010512.3647568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <dd2b2658-cb4a-4ba9-b69c-470d433a0ef5@linux.ibm.com>
References: <20261103015238.3780910-1-sashal@kernel.org> <20261103015238.3780910-20-sashal@kernel.org> <dd2b2658-cb4a-4ba9-b69c-470d433a0ef5@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 06:56:10PM +0100, Peter Oberparleiter wrote:
>> +	depends on LLVM_COV_KERNEL || (GCOV_KERNEL && CC_HAS_CONDITION_COVERAGE)
>> +	depends on !LLVM_COV_KERNEL || CLANG_VERSION >= 220000 || !WERROR
>
>Would it make sense to transform this for readability, i.e.
>
>depends on !(LLVM_COV_KERNEL && CLANG_VERSION < 220000 && WERROR)

Yes, that reads better. I'll switch to it in v3, thanks.

-- 
Thanks,
Sasha

