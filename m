Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A31C3601A
	for <linux-um@archiver.kernel.org>; Thu,  3 Apr 2025 20:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gLHvTlsS+s3jhc0v07AaO/IvSIJovAXmGpHhTOc1o5I=; b=peG2LNuX5gqxmmjoLnU7iEY6P1
	fpdnoEb4T0Iufhz5hvvc/FTHhutW3fkaI/xq2QTLBZ9If/HA249ZujkEGCCyWACzy1VBSRBYGzmV8
	f1Jv8G+MpuwnPST/DsbwsC5yDM71c5FvzqbdFEUA1TADMrzRJiRiv8szkmOI+BWnGhKlNMpjjAXw7
	0/copnJ5g/EquD36zrJqUObuR+/nAWtx5n80NgDXendEy9aXNpfQBnr4fqkKqgtrSxxystup5Z8QM
	lWfqulVn04/m0XIciUsrQBF5MKtA9fmpeatlhCoBxMVrfCZHlF9j48ZS4z4zrIKHEgCY6uEWMwl7K
	QBgO/W3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Rb3-0000000A39v-0e3b;
	Thu, 03 Apr 2025 20:55:33 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0RTV-0000000A1Yd-1ebb
	for linux-um@lists.infradead.org;
	Thu, 03 Apr 2025 20:47:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gLHvTlsS+s3jhc0v07AaO/IvSIJovAXmGpHhTOc1o5I=;
	t=1743713263; x=1744922863; b=g4gzB5uNfoK4ANEyhGXshDb8qZ9evnZa6nBYY5DT1oRNnN5
	MYElGvyvSM33S8jtNGVWdKY/IqF0RSVqrDo/eUVbzsJZlUA+dn3Oa+W4lyoNcAUKe21uk02wQFfNq
	H+aGhXkEGOeLAx4V6PtQSk/2U115sWeYvoFstkSXH5rlFz8JFESR716J+T/irpSOoduajsAgIfrRL
	2jLpH63IiWiAoAAVGtTbt/iL9DcY89VwFg5PT3XQNFiziwbjo72wD/PUGuiRMCh9q0UmP/XTW2oK4
	K+50RG/i7cAB14v9gU9+Oe9BF09FfL9ARbtuRMjj8YSzEvmA3NV1P9lqVag2N7Hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u0RTQ-0000000FOb6-0742;
	Thu, 03 Apr 2025 22:47:40 +0200
Message-ID: <5c8f9b27e77c793295c2f6a0c3a3794ec4c05c3c.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] um: mark rodata read-only and implement _nofault
 accesses
From: Johannes Berg <johannes@sipsolutions.net>
To: Nathan Chancellor <nathan@kernel.org>, Benjamin Berg
	 <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, llvm@lists.linux.dev
Date: Thu, 03 Apr 2025 22:47:39 +0200
In-Reply-To: <20250403191910.GA3085607@ax162>
References: <20250210160926.420133-1-benjamin@sipsolutions.net>
	 <20250210160926.420133-2-benjamin@sipsolutions.net>
	 <20250402221254.GA384@ax162>
	 <413669a192e65d67059245d38c03828f85d20717.camel@sipsolutions.net>
	 <20250403191910.GA3085607@ax162>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_134745_715697_F9D0DC19 
X-CRM114-Status: UNSURE (   7.55  )
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

On Thu, 2025-04-03 at 12:19 -0700, Nathan Chancellor wrote:
>=20
> Thanks, I applied that change, which shows a slightly different crash
> message now:

Pretty sure it's all just a bug in my inline assembly, and clang
allocates registers differently:

#define ___backtrack_faulted(_faulted)                                  \
        asm volatile (                                                  \
                "mov $0, %0\n"                                          \
                "movq $__get_kernel_nofault_faulted_%=3D,%1\n"            \
                "jmp _end_%=3D\n"                                         \
                "__get_kernel_nofault_faulted_%=3D:\n"                    \
                "mov $1, %0;"                                           \
                "_end_%=3D:"                                              \
                : "=3Dr" (_faulted),                                      \
                  "=3Dm" (current->thread.segv_continue) ::               \
        )


It _looks_ as though both %0 and %1 are output only, but clang compiles
it to:

  51:   48 83 fb 08             cmp    $0x8,%rbx
  55:   72 44                   jb     9b <_end_0+0x2a>
  57:   48 8b 01                mov    (%rcx),%rax

// start inline assembly ---vvv--- //
  5a:   b8 00 00 00 00          mov    $0x0,%eax
  5f:   48 c7 80 90 07 00 00    movq   $0x0,0x790(%rax)       // crash
  66:   00 00 00 00=20
                        66: R_X86_64_32S        .text+0x6c
  6a:   eb 05                   jmp    71 <_end_0>

000000000000006c <__get_kernel_nofault_faulted_0>:
  6c:   b8 01 00 00 00          mov    $0x1,%eax
// end inline assembly ---^^^--- //

0000000000000071 <_end_0>:
  71:   85 c0                   test   %eax,%eax
  73:   75 56                   jne    cb <_end_1+0x10>


which clearly cannot work? I must be missing something. Switching the
first two instructions fixes it, of course, but right now I can't see
what I forgot in terms of constraints to make the compiler not do that.
Probably trivial to someone more familiar with inline assembly.
Modifying the _faulted to be +r instead of =3Dr also fixes it.

johannes

