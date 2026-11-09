Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E2606A31C
	for <linux-um@archiver.kernel.org>; Mon,  9 Nov 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eNlSHGi4;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=O4tfkQ6A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a8E3/iR/a7duyeOibRsBSGVysFs99fc4KMcpjzN9cYk=; b=eNlSHGi4S3Z6B6oaQzIUs17UnD
	kJ1+2dbsJ+WxshqB9E6XN/qszCNf0nWHwY0nZOYXiJXvDN8q3pLQBUOBPMLU+6uyybMQSYfBTmlEj
	yliBFMISrM38AmmyOLkj0RhgxDc4fbnbGNFKA6QsAXG6SXURDfpy1U8UkVKE1kzFnvmTrLu63e7HR
	wK9orNjUQBIIEcKc+vrgLIDQPCqYALJcl+iDPdsvcqw14p2Tz5Xft7OlImal/fHETVEovej+X2KNe
	/6L7bd7OT0sxXKOl6t9GHvnrfOxextcoda5TqqJpPaijIMTFO+Vql0ixmIQClGYX/1C3+G984i4+O
	3Y3QU6fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOUu-00000000gNJ-0nCg;
	Mon, 09 Nov 2026 12:29:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOUs-00000000gN2-1zt8
	for linux-um@bombadil.infradead.org;
	Mon, 09 Nov 2026 12:29:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=a8E3/iR/a7duyeOibRsBSGVysFs99fc4KMcpjzN9cYk=; b=O4tfkQ6AbDAzvKyE5zaAjBHE6n
	jTJOZEc5PTA7g0izZDHyZ4TgazCd42btIlSVcCRjSsw7v6qOS1c7jxbmpZX/TF3GzJZwz+jwAt61q
	qzlkeO7IHtMybsm6Ut5RgUPR2z8n/wQjTG4+evvl5CyIBaCY+AXr6xFnqNMVKrCZJcK9v0RN9eCoB
	a8z9jhqb/w7OLBuXXscrYQ9yeqExpaqmeYQy8c96E3JsSh1oWRJSaVbOjocXJqJczDxZ/Q/p6NmUf
	4a5moEyEQOqv23e3ldCeGGQ/Mb8EaiCVwU91/c389n37CE4/JkG5AZr7sz5pKbulPmmK6pS49D5mu
	X6JrMfaw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOUn-0000000EJ1J-3fw0;
	Mon, 09 Nov 2026 12:29:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 68D7A300910; Mon, 09 Nov 2026 13:29:08 +0100 (CET)
Date: Mon, 9 Nov 2026 13:29:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-um@lists.infradead.org
Subject: Re: Some observations regarding the ongoing x86-32 CPU configuration
 cleanups
Message-ID: <20261109122908.GU2668804@noisy.programming.kicks-ass.net>
References: <CAEzXK1pdhEyOgQ4owkeRmyEP6Pyfhk=OsMHdzU4xwNMCmCsd6g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1pdhEyOgQ4owkeRmyEP6Pyfhk=OsMHdzU4xwNMCmCsd6g@mail.gmail.com>
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
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 10:34:54AM +0000, Luís Mendes wrote:
> Hi everyone,
> 
> First of all i would like to say that i both admire and appreciate all
> your hard work with this lovely OS. I do understand that maintaining
> some systems can cause additional burden on maintenance, but there are
> some aspects that i would like you to reconsider.
> 
> I am writing because I  believe that some aspects have not been taking
> into consideration regarding the removal of the 80486 32-bit support
> from the kernel, namely:
> - There is this active Linux distribution:https://tinycorelinnux.net/
> and the Damn Smal Linux DSL (https://damnsmalllinux.org).
> - There are also these CPUs: https://www.vortex86.com/products/Vortex86EX
> - There may be only a few vintage 486 systems still working, but there
> are also other new x86 CPUs systems, especially in FPGAs like the
> https://github.com/MiSTer-devel/ao486_MiSTer which is a 486SX core
> that operates at 90MHz and can use up to 256MB RAM memory. There are
> plans to update this CPU IP core to become a full 486DX core, by
> adding a FPU unit to it and would turn this into a usable Desktop
> system with tineycorelinux. There is a considerable retro-computing
> community that utilizes the AO486 core on the MiSTer FPGA platform.
> There is even a Voodoo 3dfx accelerator card:
> https://github.com/victor-fisyuk/voodoo-fpga-public.
> 
> Overall i just want to inform you that some new x86 32-bit systems are
> still being sold brand new and can be utilized with Linux. I would
> like that you consider this with regard to how much 80486 support
> should be removed from Linux.
> 
> Personally i do have plans to extend the AO486 core to have the FPU
> and would like to be able to run a modern Linux on it. It would have
> entertainment and educational applications. With tinycoreinux it can
> have a usable desktop.

I don't realistically see 486 support coming back -- the thing doesn't
even have TSC. Getting rid of all the horrible (and completely untested)
code for no-tsc alone was worth deleting 486 support for.

The other option is you actually implementing RDTSC, CPUID (and possibly
CMPXCHG8B) on your FPGA.  I'm sure that's actually a *LOT* simpler than
doing i487 support.

Just add whatever instructions are required to get the bare minimal
32bit build working.

