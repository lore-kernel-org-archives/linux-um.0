Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3786EE3F2F
	for <linux-um@archiver.kernel.org>; Fri, 15 Sep 2023 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gpQ5NKRaLnvKktrP+v+8Rs8pufDI57KzpcvEGBUBuqE=; b=S2H9dJ7alPBbbj
	p3o+i4YRqwVJFYrBc95FoHv5kn0qfuluPlHCnJxtRqPVjR22efe/e6TGrVo1mm9EQFVgNt6KaBkHb
	DodqoP1n69hgGYUE1Krl2bciorGP8wNA8wbQBV4VhpWbXVGheFkW46W35hYsoU/2ZYak2ANUUOSN+
	QGucr1dh91LF4ZR0rv5kMJEBJObH7DIa/DXdSogT86krgmDtIQcrWPK8U3mLxFnFBvYRB4anJ6Bw9
	wf3tQ7Rjzs6fywVfRit94U15wPdtT/t6AXDxzPnxls7WTM+TNrMTl7HU4GS2xlf8qwixUJVloXByd
	K+5tix/Ye0nYCh4i3SQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qhA3o-00AuPf-0F;
	Fri, 15 Sep 2023 14:44:44 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qhA3l-00AuP3-1z
	for linux-um@lists.infradead.org;
	Fri, 15 Sep 2023 14:44:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=H8PZLMZCU0PDXbXjCCzMXnQDN3Es4h4xOXOxp4F6e+E=;
	t=1694789081; x=1695998681; b=FcXBXo7TQkXbjJfg5fljfcl8UDxR6sSmHcXjn2/3BGlQK8b
	hf6Kck0KBwpGQ1rSJVXwoUS9sDcuvknzfsA9e8gjVokocVPeAKzE3vg50LiuTMaWES4+psOAYqQJO
	4tK9ma1YodGlVRd/HTM6ZNceI3AmcxiAv2JGQwivGVrbvHFUQ+c1pPT3Y8i0tqNYKrLSkoLFlVina
	UY5Y4fw1wrrjflb/lGH8YtHNrYOCsyPFZ7iNOmY25gd6Fx4Xbdm4Nbg8D+JQ/Aiu1+1x+yATn3EOd
	HdMNI19Nv15s6d4YTs9krJMYa7dxey1iTCowC+PmeNSAAMwU0TCFXNA3fvFGpkyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qhA39-001WIR-0N;
	Fri, 15 Sep 2023 16:44:03 +0200
Message-ID: <115822422e97aac5ccd651681d74a2a4ae3cff89.camel@sipsolutions.net>
Subject: Re: [PATCH v2] x86: Fix build of UML with KASAN
From: Johannes Berg <johannes@sipsolutions.net>
To: Ingo Molnar <mingo@kernel.org>, Vincent Whitchurch
	 <vincent.whitchurch@axis.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Frederic Weisbecker
 <frederic@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 linux-um@lists.infradead.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>,  kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, kernel@axis.com
Date: Fri, 15 Sep 2023 16:44:01 +0200
In-Reply-To: <ZQQkthfNuV3dOhZe@gmail.com>
References: <20230915-uml-kasan-v2-1-ef3f3ff4f144@axis.com>
	 <ZQQkthfNuV3dOhZe@gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230915_074441_656226_4073F733 
X-CRM114-Status: GOOD (  11.80  )
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

On Fri, 2023-09-15 at 11:32 +0200, Ingo Molnar wrote:
> 
> >  ld: mm/kasan/shadow.o: in function `memset':
> >  shadow.c:(.text+0x40): multiple definition of `memset';
> >  arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
> >  ld: mm/kasan/shadow.o: in function `memmove':
> >  shadow.c:(.text+0x90): multiple definition of `memmove';
> >  arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
> >  ld: mm/kasan/shadow.o: in function `memcpy':
> >  shadow.c:(.text+0x110): multiple definition of `memcpy';
> >  arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here
> 
> So the breakage was ~9 months ago, and apparently nobody build-tested UML?

Well, first of all, it's only with KASAN, and then I think we probably
all did and applied a similar fix or this one ... I have a in my tree
that simplies marks the three symbols as weak again, for instance,
dating back to March 27th. Didn't publish it at the time, it probably
got lost in the shuffle, don't remember.


Also, a variant of this patch has been around for three months too.

> Does UML boot with the fix?

Sure, works fine as long as the symbols are marked weak _somehow_.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
