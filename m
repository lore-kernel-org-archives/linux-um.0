Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F671C98332
	for <linux-um@archiver.kernel.org>; Sat, 26 Sep 2026 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E31FkanMbaQ1+vpIZy6aCtCgHErmsnWwaF2nf7eFp48=; b=xUOB8NrDYYsLGlQP4d0JqJl5bv
	4aFF+D4gv6meui6x1oxAd873XX99iioXtuCRgTIUo8Zv/emVdZId/juG1gz2N0t7uZQQL/ZuwNr8x
	dfRobg3XoxpXlIr52CvueL7ON1fNK9Sj+qQ7qzF5RP9vPyAjRxqnKRy5HJ7M+TI0CXfKUQvGGXSYW
	bZ6sB2jZtaDCxSPKoQNW+XRHQkyePR+wU+4nQsnNsZ3dVNmi9L7JdTGRcOm+u8ObuU3nTqBs5vMtv
	QSJyJObhSL3ixlIUx9sZobDVEDYwUdC3G+BS4yWaKsyUY43nf1HJN9Id+2HWYRkMQ/utC1F80XtrF
	UibRSdYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xARNy-0000000FMzG-2cju;
	Sat, 26 Sep 2026 12:20:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xARNw-0000000FMya-3Rol
	for linux-um@lists.infradead.org;
	Sat, 26 Sep 2026 12:20:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790425206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E31FkanMbaQ1+vpIZy6aCtCgHErmsnWwaF2nf7eFp48=;
	b=DQpZnGqO91EgRMJwk+BcXKmEaLR5HDrKkfPTGx+DqfrseWVPsaOgdYsFhorv9fyCMl7PBa
	0RV4GR0c5dvq3vJBP2LisVj1jmNZc5JQGjE3+nYP3IMC2oHAdaprGS7cKK8ZBr52dQBgSB
	vOPVv5bZfSeM0YepSMsZVkJuVRExChM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-dhKzXkF0NC-wbTvPgHRU7w-1; Sat,
 26 Sep 2026 08:20:03 -0400
X-MC-Unique: dhKzXkF0NC-wbTvPgHRU7w-1
X-Mimecast-MFC-AGG-ID: dhKzXkF0NC-wbTvPgHRU7w_1790425201
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDBD4195394B;
	Sat, 26 Sep 2026 12:19:59 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6410C30001A2;
	Sat, 26 Sep 2026 12:19:53 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 26 Sep 2026 14:19:59 +0200 (CEST)
Date: Sat, 26 Sep 2026 14:19:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86: uapi: ptrace: guard register offset macros with
 __ASSEMBLER__ or __FRAME_OFFSETS
Message-ID: <are4aAD2ckM4FMT3@redhat.com>
References: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
MIME-Version: 1.0
In-Reply-To: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 6DLRl_k2neUSkc5fJPsREs9Q-jTaDixm_w2BZabBeUw_1790425201
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_052008_939720_F08F3F46 
X-CRM114-Status: GOOD (  12.97  )
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

On 08/21, Nick Desaulniers wrote:
>
> The register offset macros in <asm/ptrace-abi.h> are guarded by
> `defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)` for 64-bit, but
> were left unguarded for 32-bit. This causes havoc for userspace that
> happens to use identifiers colliding with these short macro names
> (e.g., EBX, ECX, EAX, DS, ES, FS, GS, CS, SS). Without this guard,
> userspace is forced to be super extra careful with include ordering to
> minimize the chance of collision.
>
> Wrap both the 32-bit and 64-bit register definitions under
> `#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)`, and ensure
> User-Mode Linux (UML) defines `__FRAME_OFFSETS` for 32-bit as well.
>
> Assisted-by: Gemini
> Link: https://github.com/llvm/llvm-project/issues/217413
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/x86/include/uapi/asm/ptrace-abi.h | 4 ++--
>  arch/x86/um/asm/ptrace.h               | 4 +---
>  arch/x86/um/ptrace_32.c                | 1 +
>  3 files changed, 4 insertions(+), 5 deletions(-)

Acked-by: Oleg Nesterov <oleg@redhat.com>


