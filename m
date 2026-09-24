Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF08BC9830E
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 14:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N1WNg5JHUPqQIIGQ25bIiCEbs9M7MmOQ1D2fjs9reqk=; b=kgeC9+WmB7Wl4X2Fk8SGfXb4wG
	NRxZkqx1KCCGzSrerm2865bKlrV0TAX/w4UxogyY9noM2bexZNee4F1ScSgsDXAq8T1mYRXtN4C1W
	EzqMcUvpurIauoQxpkkiYfn7+Fxp2Z+36WEhsfdqfwcJbiszTCsctWTd16hrBW07GnHXMGOxZ8Sfb
	yUJ3w49V6E+x7xKiVrZ0R2pjPEM/d0oUnyrhyLvnX/klk/V1OANvmReEiEvUlxrKc/CnOBJXKLQac
	ZmVjD5hV9CV6bi5YHv+tFgdGrmAQ/QGymGOAtV+cuO7DsdbeUhgeEKSWDw1kjw0n0n6uLkZTGQy23
	8eJQPh0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9kqY-0000000BJWs-0pqH;
	Thu, 24 Sep 2026 14:54:50 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9kqW-0000000BJVn-1iOZ
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 14:54:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=N1WNg5JHUPqQIIGQ25bIiCEbs9M7MmOQ1D2fjs9reqk=;
	t=1790261688; x=1791471288; b=IC3ZOoa7+MlwX9sQoJLmOlmlPOOmmAnCwqYrahM2orMB1nm
	1dOxSC1N/Q5ipYz2J2eCJO92NDDFihYrebSmb8l8kI4qRWoqJQlKwuxBQL51ERqc9eSS++vOo3H7M
	Y0jtpn4qpEgLxPD/RYYPsEh8rcC+JwB885auFKL2IBztNTAlkcPMo6uppwmakUo/sdTs3qoPv2NLK
	I/oVVc6AAVV/29oPrE69GycPCemBoo16yvPW5Tsdu4FVvK/4eXZkbTUrFFUnxxWNMRvwcLmxmZf2E
	u1UDQ0Uw+icl4QzRJFEeTEH9CgW9YkNsw3iYrccymkgpc38eZ1bYxUoQLHOO2I1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9kqH-000000096mJ-2ehS;
	Thu, 24 Sep 2026 16:54:33 +0200
Message-ID: <e801211b4c71ddd919fa5d7b9c859b86addf3fb7.camel@sipsolutions.net>
Subject: Re: [PATCH] x86: uapi: ptrace: guard register offset macros with
 __ASSEMBLER__ or __FRAME_OFFSETS
From: Johannes Berg <johannes@sipsolutions.net>
To: Nick Desaulniers <ndesaulniers@google.com>, Thomas Gleixner	
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, Oleg Nesterov	
 <oleg@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling	
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	llvm@lists.linux.dev
Date: Thu, 24 Sep 2026 16:54:32 +0200
In-Reply-To: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
References: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_075448_454940_968B7F9A 
X-CRM114-Status: UNSURE (   7.54  )
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

On Fri, 2026-08-21 at 15:45 -0700, Nick Desaulniers wrote:
>=20
>  arch/x86/um/asm/ptrace.h               | 4 +---
>  arch/x86/um/ptrace_32.c                | 1 +

This seems like a simple adjustment for what you need to do in x86, so
that's OK, but I don't think we'll take this through the UML tree.

But for UML you can have my

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

