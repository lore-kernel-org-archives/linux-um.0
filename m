Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53825C5B552
	for <linux-um@archiver.kernel.org>; Mon,  2 Jun 2025 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wg+7CJ80bXnmYz8m8LaLQp816Yk+yAblH0z8mCujKYo=; b=kN90+66QjiHXD3uRHCFeCdzEb8
	gkgjxKoSwzkraTUsrMCsSmW8iAcTcI5OBWvyoHnhBkqUEI9h/EOLsqLbtgoIirb5agluFApk6udab
	hiY1W0B+tszach+8rr29y4Uq0ewUlK8BhEB7vjH5aaSB7fmC7RFvMxJ5E9KwykYmC/bCk/IxDA3jI
	CgyRcmQ7xtgFU5cqqekAGg9XSZrKLeKlI00KwXaNHRxr77z2B1mlo0FnOBEa2Ubhok94Wd8HWxOxA
	TfCSIg8q71Z+rNPFCg9qVVbmqPHh0UPRuCoaGAU757qazuJEG/UeX0e9nRdFHerWhbiBm2xzzsqBV
	AVTIrPkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM6yq-00000007kQR-3kwh;
	Mon, 02 Jun 2025 15:21:40 +0000
Received: from woodpecker.gentoo.org ([140.211.166.183] helo=smtp.gentoo.org)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM6tm-00000007jad-1a13;
	Mon, 02 Jun 2025 15:16:27 +0000
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id A5F393412DE;
	Mon, 02 Jun 2025 15:16:19 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  linmag7@gmail.com,  Al
 Viro <viro@ftp.linux.org.uk>,  arnd@arndb.de,  chris@zankel.net,
  dinguyen@kernel.org,  glaubitz@physik.fu-berlin.de,  ink@unseen.parts,
  jcmvbkbc@gmail.com,  kees@kernel.org,  linux-alpha@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-csky@vger.kernel.org,
  linux-hexagon@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-m68k@lists.linux-m68k.org,  linux-mips@vger.kernel.org,
  linux-openrisc@vger.kernel.org,  linux-parisc@vger.kernel.org,
  linux-riscv@lists.infradead.org,  linux-s390@vger.kernel.org,
  linux-sh@vger.kernel.org,  linux-snps-arc@lists.infradead.org,
  linux-um@lists.infradead.org,  linuxppc-dev@lists.ozlabs.org,
  loongarch@lists.linux.dev,  mattst88@gmail.com,  monstr@monstr.eu,
  richard.henderson@linaro.org,  sparclinux@vger.kernel.org,
  x86@kernel.org
Subject: Re: [PATCH v2 1/1] mm: pgtable: fix pte_swp_exclusive
In-Reply-To: <20250602041118.GA2675383@ZenIV>
Organization: Gentoo
References: <87cyfejafj.fsf@gentoo.org> <87v7rik020.fsf@gentoo.org>
	<20250602041118.GA2675383@ZenIV>
User-Agent: mu4e 1.12.9; emacs 31.0.50
Date: Mon, 02 Jun 2025 16:16:14 +0100
Message-ID: <878qma41j5.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_081626_434544_E2619285 
X-CRM114-Status: UNSURE (   9.28  )
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

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Sat, Apr 05, 2025 at 06:09:11PM +0100, Sam James wrote:
>> Sam James <sam@gentoo.org> writes:
>> 
>> > Lovely cleanup and a great suggestion from Al.
>> >
>> > Reviewed-by: Sam James <sam@gentoo.org>
>> >
>> > I'd suggest adding a:
>> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>> 
>> Al, were you planning on taking this through your tree?
>
> FWIW, I expected it to get sent to Linus as "please, run this
> sed script before -rc1" kind of thing, script being something
> like
>
> sed -i -e 's/int pte_swp_exclusive/bool pte_swp_exclusive/' \
> 	`git grep -l 'int pte_swp_exclusive'`
>
> with suggested commit message...  It's absolutely regular and
> that kind of tree-wide change is easier handled that way.

Ah, sorry. Both Magnus and I are new and irregular kernel contributors,
but I've seen that before and should've thought of it.

> [...]

cheers,
sam

