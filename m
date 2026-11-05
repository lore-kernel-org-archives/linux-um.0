Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105DC606A31B
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=znmOGJ0O;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=JKIouKsk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pzsXUak+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=X2aYRrHL7qbg/XALkK2v5ZXHTLqXj3eD/VI76jmz5hw=; b=znmOGJ0OgltMDh
	AdbPX2XuY1E0iy9gqwKEL2o7wgwk+ghHmqTvBTFMQJqADt3NYVD9JGOEeLi78zKkSTwojlmTVHZEG
	4f1QMG6jLdaqniO0CszA9o/YlweifPIiVLvng0E7rarfmHC4d2pG+bgOUID+Pdm1xRxouZiOfiytd
	CP2I8Piuoe5SomEcqtn4yqjTb0jitQP6zULYYvPOyGDO6BMGLpQ5S+OHcsk/gC2s8hgZ/1YUaN8Tk
	czpXl9fysoz52kA6kNc7Ls3kkpLxKsmsoykI8eJaf1AN912hj4EF+tBDAKWjcUUemy/3l4lCOPFii
	rGz0DJMlup9QN1l8qOXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP5XZ-0000000AmKs-1jk7;
	Thu, 05 Nov 2026 22:02:37 +0000
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP5XS-0000000AmK3-2u3y
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 22:02:35 +0000
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id F2527EC02A0
	for <linux-um@lists.infradead.org>; Thu,  5 Nov 2026 17:02:28 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 05 Nov 2026 17:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793916141;
	 x=1794002541; bh=X2aYRrHL7qbg/XALkK2v5ZXHTLqXj3eD/VI76jmz5hw=; b=
	JKIouKskvwCeTT8s+QDa6Y/zlMGM0gfjHgls5bb7p2FGqppfS7d/HwWay4nnODCh
	kC1QcXF6pYldA52WfS5/3lUFFNO9e6gZtZ0Gntv3RuTyzjWDWzrPPV61Rb5/3nOy
	ppBTTx1pDrvuWScZ6RhV/hmv9h30TQvkPGTp5Aza4C1EkZ6ifpEtyRfdZA6MuxLu
	oIXW2Mx80RBKM/4jAe+X421HcD565LWvIVGlnef2ZSMdO/aqyi6qYH40sZTe/ytn
	uMnAOuZ/S2ZgncNVGbjWCaOzFDkfGnV0YONnrTUEK3GbMjzQ2kE61CokNqb0lNsT
	wRUhsNNyctzynaJFnGoDYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793916141; x=
	1794002541; bh=X2aYRrHL7qbg/XALkK2v5ZXHTLqXj3eD/VI76jmz5hw=; b=p
	zsXUak+EIPczbDUmnrAq4ROcKgjYiKgRk7LJonWMQngBSlNUgw1EypdSx9iwYYPv
	gbxxi6oFq6yH56kInM3sE/UvejqL3Ejw+IsjoqsTOer8hhpX+WWM4Mf+K9Vo775d
	tnmxqHUker/5l5Zkl/2pew3Zbl672Rybnc7by0P+FVC6E8WQPipSE4RWdmDWcjH2
	f/Oekh3J7xBtyDKguYVPX53VoUXFfhYlLA1jPVNzC8LVpGjqAiAbMwrB03NysSpD
	IGw1MqwRh2fkBt+1CybOxOrCA2J+x5xtNz0+tXyYY3lAif+4W9euLbMRgjRiJLbe
	TB0GD9drnm2gs3kWtbBNg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793916141; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm2:rsa-sha256:jQy2fGTWJuUW9OAJu+yX+ir+iHFijm2xSy42LBJORAJP1M9
	5Ns03oVAgu1uYaIY9Dh5R85jZZxWlbsu9mWGfpFlh9/9NbC/4gcNDgSqEOfVN5Vz
	Jfn1EnI7Mxv8BDh/KN6vNmyVym7YFhJjK7wiNBIdskg10aQex3cJHnQbZbIXVNNn
	fPf7+x0GZsU8zacI0q2e+v2X+i1FqktOz3oH5woJavW/nlG6vtfYwXnbjhh0lVER
	ZY/kqyszQUqfHy/xv9DIfL3BnI+KjqoeVrWhIc+bUyUkOSbu3+yrAL4sg0v9tY/d
	kqxbhvsOVCXr7e/hnrMBAf/6N6VyRSp2D34EQ7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LHIhWoqGgJiYSGZsWsN9ancd/JKDeF47cMKwEAPJtwI=:ovSr3EF5mRYLI8zy5US9qElvX5Tf+k0dfewUYQSAkEI=;
X-ME-Sender: <xms:4vzsaoXcMBah8YBasTBuSUnKfO_T7ah4mJewGm6nFcKcQ87KC_or6A>
    <xme:4vzsanY2GNUpXftxEoDQ4Hdn-bQTRbCE_8PQx85xc1ANMYHXrVhDu4uR0IKqSKUu4
    ThOzVswxt-Sgd-9ksMP_OIdWJyflP3Wb3AIOAfDn-SHxLWsHh-dClYG>
X-ME-Proxy-Cause: dmFkZTFMGrZFmFz4k3x/TKEqPAvc0obtORkHb3Lye6BcaqE3n9XN0ufTVNES3XAY/fnKS1
    yjrAj6+9GgOGvbni7iWz9f4EIlde0LsLuUaGliwvaPSAFN6T637TVp898IfqWZ6iaBVUJw
    FTP595qHl0RK0CE3LGfOZmJteobzwS7XnJWASvPi1LHqIf9PD87mFH183YsaZut4+0Y4q/
    uhDPsmBAqKBjp+msB8hCGWy7Jlu3J84lascqk0wCD8y6PoQlKOxnUCiiSS+PS0ONixY8L+
    FbvKfM0HaZOQEB908qSlPClGOlSnUHdlmxggjGSokhPqyR4v2IB/QngGVZ6SQUdLLmjTo1
    b18Z1H3rNcE6+3bAr/FGdobDWtAN9v5e6Dru7WLY9MVGH9U5KogWgySkVcOB208LzjTSR5
    +w+Z7OOz9qohH5/SVmorT4NRSyV/FM1DakDnO7QxJTW3BOtHriWAKC2Rm/QCV8IVSE8ioV
    KxwGQjFDWp27h0OIsLSfNd1lkUL0wENNVcewdPwX7b6hSX8HJTpp9ooKUSCm8u0fXkYaIO
    OEladBe45/R69xL2iN3ZWrD6ty6HJ3OVHa4TrwW9CLiBFP+2WTCDKP/pdyYoNjCvtl6GXW
    tUvUsBU1xlV720sGoHibmPOsYIv0c5UUiLCqDlOXl8pnOlKEG+ZGM2iQOW4g
X-ME-Proxy: <xmx:5vzsavGcgmS5fKV9ANSEE0UO7WdKV1RkivZBap4KGXA_80dmNwsYSQ>
    <xmx:5vzsaswfNuxMAfAcuCfsbb3R40nqCD8orrm5fhHSdyQVYaJo8Qfy3w>
    <xmx:5vzsamkVa0CX7Bezw6feVtFajX8y1faS0wFCgRXTG9XHFHY4tHu8aw>
    <xmx:5vzsarDK2INCBU4T0-_D3EphxApx5tV3I_9K1736vl1gWaKNxW1RFg>
    <xmx:7fzsaqeVgad7S-zv4Dn1HHCFWKubhat8XC_NKFXGpTjQVPc8ss4SJmOX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 990F432A0097; Thu,  5 Nov 2026 17:02:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2yf0_aOlh3-
Date: Thu, 05 Nov 2026 23:01:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>
Cc: "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Will Deacon" <will@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
 "Alexander Usyskin" <alexander.usyskin@intel.com>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Message-Id: <eaeec453-892d-4ddb-9d42-0510db8b9c88@app.fastmail.com>
In-Reply-To: <4207CA81-6023-4DFC-8FBF-2C5C8C036CCC@zytor.com>
References: <20261105163440.2381661-1-arnd@kernel.org>
 <20261105163440.2381661-8-arnd@kernel.org>
 <4207CA81-6023-4DFC-8FBF-2C5C8C036CCC@zytor.com>
Subject: Re: [PATCH 7/7] x86: simplify 32-bit instruction set selection
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_140233_603084_D69233E0 
X-CRM114-Status: GOOD (  17.06  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026, at 21:17, H. Peter Anvin wrote:
> On November 5, 2026 8:34:38 AM PST, Arnd Bergmann <arnd@kernel.org> wrote:
>>From: Arnd Bergmann <arnd@arndb.de>
>>
>>The -march= compiler flags select both instruction set and tuning for
>>a particular CPU, which works well when building a kernel that can only
>>run on this one type, but has some counterintuitive effects because it
>>is not always clear which models are compatible.
>>
>>E.g. building for Geode LX results in a kernel that can work on all on
>>all 686-class CPUs but crashes on CPUs without the CMOV instructions.
>>Building a kernel for 686 could work on Geode LX and Crusoe but fails
>>because of the CPU generation check that detects these as 585-class.
...
>
> Crusoe (TM3xxx/TM5xxx) do have a handful of compiler/user space visible 
> items that are missing from i686, as I recall notably the long nop 
> instructions and *possibly* fcomi (I *think* we caught that one, but 
> I'm not 100% sure.)
>
> As a result, it reports correctly as family 5.

I don't know about fcomi, but the P6 long NOP hasn't been used
in 32-bit kernels since your 2008 commit 14469a8dd236 ("x86:
disable static NOPLs on 32 bits"). From that point, I believe
we effectively treated Geode LX and Crusoe as 686-compatible.

binutils apparently uses the same definition and emits long
nops for -march=pentiumpro but not for -march=i686 in modern
versions.

You are of course correct that this remains inconsistent:
a kernel with CONFIG_MCRUSOE is still built with -march=i686
and CONFIG_X86_MINIMUM_CPU_FAMILY=5, so it will fail to run
on 586-class CPUs without CMOV.

I'll fold in this patch to make a MCRUSOE kernel actually compatible
with all i586-class CPUs, unless you have a better idea:

diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index 1735a5f95d33..9a3a1b1c2452 100644
--- a/arch/x86/Makefile_32.cpu
+++ b/arch/x86/Makefile_32.cpu
@@ -21,7 +21,7 @@ cflags-$(CONFIG_MK6)		+= -march=i586 $(call tune,k6)
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
 cflags-$(CONFIG_MK7)		+= -march=i686 $(call tune,athlon)
-cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)
+cflags-$(CONFIG_MCRUSOE)	+= -march=i586 $(call tune,i686) $(align)
 cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call tune,pentium3) $(align)
 cflags-$(CONFIG_MCYRIXIII)	+= -march=i586 $(call tune,i486) $(align)
 cflags-$(CONFIG_MVIAC3_2)	+= -march=i686

     Arnd

