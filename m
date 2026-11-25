Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A377606A321
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yq0L2pu/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uYCVL3RS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NSMLR6o7mSTpUDIhmxU/RxFIM3/A8VrEBsLCPmJ8qJg=; b=yq0L2pu/M80FEqZxt4MsvylZTd
	mxvLUOJ/6us/LROy/0WMGA5lmren2iUnb7k0L1v33Xh/nQ1neYzTKIivtgLDOmZBXIdjMgGiQ/XjK
	5A4B5nigiU9Kx33ZA3pWs1vYzLnYwAZAPYrzS25mPffTMZqphBoRDbUfGr9v1hBBtWT9sDWZKsksK
	8qyG8OK/wdyVdp5ImANdl1Ujty/qoX0+v8ds8g41iJpbrmP237Nb3DEy9qN4zSbaZgRNWPsrwz2DD
	uSU+e2VVX1B/k6zsuWNJvmNtUQXWhmeuFbNbAmqTH9pzrbmAglG6MnBKTPll6Ty4z8bYeSCy0jXrm
	jr+O//4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9Rx-00000009Klf-01QK;
	Wed, 25 Nov 2026 09:38:01 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9Rk-00000009KgQ-3YjL
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 09:37:56 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-536717a4d83so45619721cf.2
        for <linux-um@lists.infradead.org>; Wed, 25 Nov 2026 01:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795599467; cv=none;
        d=google.com; s=arc-20260327;
        b=iJXER0fc6l5J8iD/flf/fG8qPOhMFmmC6rjjPWwj0CSZhhpfdouHzD35pEGUgYdwjn
         d1/snehhMT1vEKhLVKhm1SeLGu2/K/0lSFewDXlYWS1IFho6UXaeckjhngRDof/q6bLs
         usxyUYE6hVhkSDWbSBdQ4zVNJTijXyWSIDDMDYgZBqFUjGjbjc43ELoWa6TJ3t54BkRx
         qP7d4ImXimeRrsW1D1qiFuQiP8zuddPQVDhCJ3rdNetXJvpVeLMK55+PpmYeH8+YQXSV
         xIANzZRbfxTLQ9c3mhEnSevF5SkhDeu9eHExXNk7q4K/5ozQU3nwiTTF2ju+dLDq2HyJ
         d8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NSMLR6o7mSTpUDIhmxU/RxFIM3/A8VrEBsLCPmJ8qJg=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=Fgo4WTC+Vhbg2HL9R7TJ/GjXohllR4onJRaIqRCBylRwjwGoqfpsnsAaLiV4i2jZXG
         fIThXbZ+47TXmqLNi4GFzDw3d0d7+VlSH1YM816eWorx0+i/mQ5HQ/MvCwzIakXIWXYL
         kbGvmDKQ6phJYDqSx6lFBawCjWFaod/Tv84yh6oPWAsPZK2HsjO7+jdvUGE9lqEQMWIn
         s5G+JP2t3/CNXIeFyCNMVVtUkPnvWldrqu2L2HOhbfnw8QrzmJWbulHOf6B17EgQhsA8
         vrX8a82UwFoUup7/AbhDaKs9w5nOWlpRSjjOoEc8VoNe93KT9QXyNSP077L7ErwDZ4Nn
         LDZQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599467; x=1796204267; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSMLR6o7mSTpUDIhmxU/RxFIM3/A8VrEBsLCPmJ8qJg=;
        b=uYCVL3RSqTC7KsbxV4QhPJLd5FPaH9JKKv3cAWpPj0KD0cO8Oqb3VN3ml/fcUoup5t
         RyENY76FmVqfdKYBo0LfbcZwYVCyEN7Ctb920McXAmZDaRc0WYUccry8dGroBvolsOCs
         F03WvZC1q9SPDmgxSO/DZ4MO1HBn1Dsr49aMH+AGH7wroKkw7G7b6ZMZTUc8jM7QsOtI
         Q5IbF7gjkxiNxE8BrwCuNu/a31x46oJQXtCplApUzSeTNuNgUCxpT3GPsSMFNcb7+r95
         +9KJC7pRSPAzicrgQQZvatXksr/jP0akzuUwWVEhJ4Y4lsKPJ3PS+W8sPGmWNbStu9YR
         7J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599467; x=1796204267;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSMLR6o7mSTpUDIhmxU/RxFIM3/A8VrEBsLCPmJ8qJg=;
        b=H0BQHcxjAoNX5hHzRNe0362W6OpOFvJLL1nskswotfvwpBKiG+bd6Guis1pKNb5WFY
         2X2dDj3K0waHknkTcRZFwzbUZAQP16Ih7No8/UfLFevGzIDmV11nLhcZ1VkKv/3zrdl9
         MszvS1+xFAJsS1JL1V4o3IBDoxSEC9Le5MVl5qEjeItcODP3hZuZYSyf6zleWUBVnJPI
         eJB0IaSm4Apx7u6lyv/4wGxV4Ng7FU6gamxGTXJqI5gpKszTLWjrkFNqY60slZpEbIyP
         JQLFJq3yHkpQfuWkf52xj5tjyaP8VfcUj8k14BXiTYvGjkuWxD8uk4aHw0Hfnt0RZPdi
         A6dQ==
X-Gm-Message-State: APuU4Z9X627h5AZlv2kf++JS3K0R+R0Yh48LFYVLdTwNmSrT+9I3pM9f
	Z2a9k7ZM9zwPR/Z719kC+TPQ3gvsGyQcs/Kb3jPaRiIpS5+sL8uI8p7ovPZ6ZN3hHQNcsNrYHcf
	tHg8TtZiEXsC6AQukoXWG0NxdPAZsxSMxpG1b
X-Gm-Gg: AZFdTZfWNv4YEB4m80tQbxQ9oik0PK7VD+2sX9/9MlJo609tAub7SN69jEhXouIQ3AC
	5wSYa6Hm8NU2oYEVjnLNhmr8oY14T5EUZJa0nzotZ01oXMv0I1yP4PGyXcPMx2jYejE7OYufh11
	pLeC4xRe88Sp6XANnPAUZBvWKtYwl0Uy+epzmIPiu9zSfpMqDyZDVMlMJG4Yh5f7EL4riDoI6mx
	wPNKrRHHZa3MSZ6PlAeDTkieRvFLTkkN8ZKfFoaNBnd7P/nkXShksAb768vU82bO+dcwgCvO2iD
	m84SJW+sTo3TjZ/IUpisI1LOZeBsrA4f7D/ZoaRZ9cvc0ppQ9H6+qwt87eWMPKHLizT6+wclxNY
	sSD4By55NosAQQIFjhjmKrc8OQF2qctrM3q0CGPDOg4AAs7gLqOywWII=
X-Received: by 2002:ac8:59cd:0:b0:533:91bb:b81e with SMTP id
 d75a77b69052e-55d76a6284cmr308531931cf.31.1795599467513; Wed, 25 Nov 2026
 01:37:47 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Nov 2026 04:37:45 -0500
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
In-Reply-To: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
References: <CAB2K5aCdEWKvsCUWeHWR0FDVqQ2263PaDQX8VWnma5pF4HwG8Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 04:37:45 -0500
X-Gm-Features: Aa3M54rSURH__On8Pd19BagzPHmiSj2K5FLZGVNIP6Xutq4nA3L1LWWaGGaqtYA
Message-ID: <CAB2K5aARq-n7ouL7gJ0HjTZ_1hXFou79LTAiBJ61=-gVaDY-+w@mail.gmail.com>
Subject: [PATCH v2 2/5] um: Kconfig: select generic vDSO options for UML (MMU only)
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_013755_105924_5D0F344F 
X-CRM114-Status: UNSURE (   7.49  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Select GENERIC_GETTIMEOFDAY and GENERIC_VDSO_OVERFLOW_PROTECT
so UML can use the generic vDSO framework (lib/vdso) instead of
its hand-written syscall-shim vDSO. This is the Kconfig half of
the generic-vDSO conversion; the code half follows in the next
patches.

The selects are gated on MMU: GENERIC_GETTIMEOFDAY pulls in
VDSO_DATASTORE and TIME_NS_VDSO, whose code calls MMU-only
functions (_install_special_mapping, vma_is_special_mapping,
zap_vma_range) and therefore breaks the NOMMU build at link time.
NOMMU UML keeps the old shim vDSO (um_vdso.c), which needs none of
this. This follows the existing pattern in arch/riscv/Kconfig,
which selects GENERIC_GETTIMEOFDAY only "if MMU && 64BIT".

Signed-off-by: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
---
 arch/um/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 7245e3ada..faf4b197c 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -33,6 +33,8 @@ config UML
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_GETTIMEOFDAY if MMU
+	select GENERIC_VDSO_OVERFLOW_PROTECT if MMU
 	select HAVE_GCC_PLUGINS
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
-- 
2.43.0

