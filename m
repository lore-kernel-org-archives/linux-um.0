Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA55E10A88C4
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1vOiFYL2/2gauah1MO2J0SrthHCAYelycFB7wMm2FBc=; b=AbJx9P7vXH0wa2AXIcmLA+epSP
	IowutBOxcMbLjttd8WI5cm5KzQB5Euu9/JTVfE1NcEugUmvQ4xFd4xMOgHj4uLK7TvjV9paVCX6Xq
	zq7Trf5hHZmze5TgMqrUhNHuFEhl3Q1Lj6xO/lV0Go//GC2fOK7CcATyB05SXz8BIVBMu07ILEpB2
	5eaOegkzsDnktPQiRYxZW6RcTr66vocDa68oP1UC9gvW738O5rtcTe9USz43lctr1YL0w70Sud+jp
	99yazYZayM/y2FZPpnwHRViO4mUz5M8cknZXTLpFxMjAgj2j5E2AzPwCeaes/MYGIsPAciBNlj2rt
	MIlIXfpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5mTk-00000005jO4-2a5t;
	Thu, 26 Mar 2026 15:18:36 +0000
Received: from pandora.armlinux.org.uk ([2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5mTh-00000005jNO-3T4C;
	Thu, 26 Mar 2026 15:18:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1vOiFYL2/2gauah1MO2J0SrthHCAYelycFB7wMm2FBc=; b=D26skTX5ljpAkNaHIlMIJtyMXA
	iuIGQ5XwwypR4BJdeLJLVDrC+G8tMEFZ5P4tqFmMjvoI6AOG6PIGOYJ85eGHPeAxV6gRfx+n68+yA
	Z6Dx/Y4Gh1bEmBoiL199z+7bIHDUJX8pt+YRZ3g5KB5wjXksBBQ7eBwENc+99IFKclwJ/lK53Pjir
	PcYACczVKeLDRVOEKCWwE4d6xmObv4geC0gR07wywRb3JWhj2yDBMxHaFvNVJJPEA+2cOalvqqiaA
	4k8w4+HXDBOVmRXqj/u7croVsR0r2ZAHcvW2tmFLlVzNz55dyKB4kAZ54aQDsDWoJgqZAgnfjOQ71
	P2yYBqiA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58812)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5mTM-000000004wB-0dxj;
	Thu, 26 Mar 2026 15:18:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5mTH-0000000077v-1ifh;
	Thu, 26 Mar 2026 15:18:07 +0000
Date: Thu, 26 Mar 2026 15:18:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Ard Biesheuvel <ardb@kernel.org>,
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org,
	acourbot@nvidia.com, akpm@linux-foundation.org,
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, dakr@kernel.org, david@davidgow.net,
	gary@garyguo.net, johannes@sipsolutions.net, justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-um@lists.infradead.org, llvm@lists.linux.dev,
	lossin@kernel.org, mark.rutland@arm.com, mmaurer@google.com,
	morbo@google.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev,
	nsc@kernel.org, peterz@infradead.org, richard@nod.at,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, urezki@gmail.com
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
Message-ID: <acVOL5Psz6kHlhq2@shell.armlinux.org.uk>
References: <20260322192159.88138-1-ojeda@kernel.org>
 <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk>
 <acUGAsjYvNvTEO92@google.com>
 <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com>
 <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_081833_889431_7C11A879 
X-CRM114-Status: GOOD (  21.04  )
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

On Thu, Mar 26, 2026 at 03:31:26PM +0100, Christian Schrefl wrote:
> Hi Miguel,
> 
> On 3/26/26 2:47 PM, Miguel Ojeda wrote:
> > On Thu, Mar 26, 2026 at 11:10 AM Alice Ryhl <aliceryhl@google.com> wrote:
> >>
> >> I noticed that the Makefile currently uses the arm-unknown-linux-gnueabi
> >> target. It should probably not be -linux target to avoid this? Probably
> >> it should just be armv7a-none-eabi, right? We gate HAVE_RUST on
> >> CPU_32v7, so we should not need to consider the other variants.
> > 
> > I think Christian tried several targets back then and eventually
> > picked that one.
> > 
> > Christian: what was the reason to pick the `-linux-` one? e.g. was
> > there something you wanted to rely on that target spec that you
> > couldn't enable or disable via `rustc` flags or similar?
> 
> It should probably be fine to use armv7a-none-eabi. I've mostly used
> arm-unknown-linux-gnueabi

I'm not sure if this is still true, but I believe it used to be the case
that the -linux-gnueabi target has one behaviour for enums (fixed size)
whereas -none-eabi, the size of the type depends on the range of values
included in the enum.

Certianly, when Arm Ltd were proposing EABI, EABI had the latter
behaviour, and I think there were cases where Linux used "enum" in
its UAPI.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

