Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC0CCA5FFC
	for <linux-um@archiver.kernel.org>; Tue,  6 Oct 2026 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:Message-Id:To:From:Date:MIME-Version:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nrpoUjeGhXa3Jx6nQrwBvc6YjkiO96rVglBerQeILKs=; b=fwWPKAhgCmWFSMfG80ZR0EOoYJ
	soWCJDvieb/U59/Pw6kyahazz5aU0DZSTKLfCRJXjrmZ3AyjJm/c6FsTxybThx5MlP9Xmxqn8jyKe
	2HUlw4O67qrgf2AyWnxZqSCmzobPt+w8CdTVx9tAbweuMYWrAlHaghjYznOf5MQrM1I5rbuSL/5Im
	l6H+A7eoMPB5uAaL2servYycbcKSItrDsKBfmwnE7J2HQyr5q4qp0ZVuQv7EVK0Bhn4vs6FKzFYNp
	oJlncaHCwz+GuEw5elDIR7KCUd0tVGkB/vEaoDQI0A0TnDOgHyiKQLjhrljZohGo+y1BX/B6tXtIU
	/k+amtSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE6sb-000000011BE-1SZf;
	Tue, 06 Oct 2026 15:14:57 +0000
Received: from flow-b5-smtp.messagingengine.com ([202.12.124.140])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xE6sY-000000011AR-3Srz
	for linux-um@lists.infradead.org;
	Tue, 06 Oct 2026 15:14:56 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id D5C79130098C
	for <linux-um@lists.infradead.org>; Tue,  6 Oct 2026 11:14:51 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-03.internal (MEProxy); Tue, 06 Oct 2026 11:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolber.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1791299686; x=1791306886; bh=nrpoUjeGhX
	a3Jx6nQrwBvc6YjkiO96rVglBerQeILKs=; b=es/4M4p7L48TZi0rOQK7DCLqAx
	e3t+pJ6IcbLmok1HFzqJd9V/IuujTjl0yuWJQnEOztg1g+YiK2Aux9u1Rr5eo85g
	hnVIZZmehyGgvygArQ+AHG132EYKfX0xAjLc2URwnrFcQFABk217tgheCWNePor8
	hDMl/FhKo7Yv+FUx7LZkC/lw8WPEZw8LmLKCRHOK6GlNdE1c10lz8sgGTIR5nRf6
	DydIzFbzq5j91W6qvnr6wuLiHNRhQu0DIEe38HF9YD27gc0Pll9PkRqoZ4MArChf
	hcRI0Tb7D2jVJwGoFEZMXivfX5tJer4kDr3cOpOYlI0bjCKyURs36T9e7SXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791299686; x=1791306886; bh=nrpoUjeGhXa3Jx6nQrwBvc6YjkiO96rVglB
	erQeILKs=; b=kYzDHpf3THRnM2zfN5O/hsIaFhd402s5TeiYovsBwwF7PWege5M
	LyEhlazPavsDx56AlvU2tD3uONqYdqif6rRwyQgGMTIEeVgjH8ycsokYER9PkpGa
	F90xTjStRDUUv8HK26TeefwT2gkA28Htnh12Xyr2X3r+0t2Ah0GbQvSltI5DnUDw
	1wXCE/LSPx59wOzbTi3QRjDgs9r4064KA9qmjibGopLEWKAzIgxWGBqIcdiIrK14
	/Qtmg3i/KQ8PEK+XuTG11xweUDQCxxcWkJ1NNkyyPvhVgA6GSlC9xxU/Dl7JgeoU
	wzUb0+vXHcojbrUl8K7I+OB2ATbD37P3QIw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=wolber.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791299686; d=wolber.net;
	mf=PGNodWNrQHdvbGJlci5uZXQ+;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm3:rsa-sha256:YvU9/ydDvPXO5lnhNOsi/pM2DbOBJpn8E+6eJeDn/g3uU4E
	lM5LpF8AvLveAJCdHgyrSf7AUFPRyJLVlJWnRDVtYWW9BMIQ8TWZjq/Zpevf+qp2
	4oWRHceusAUEe6xokseciaNN3KXMo3tUklsyy5wFVtSHdVFwcuOs0OTjUTLCnh5B
	RNaYqrHKxbZU/oNcZMMC2FQVYfNqkDpi94rDiIiqyC35bNZ0NDPBPJe/NOoUoAxj
	hcpgC9VfVtFt770TFVX1lWat1+O3D6Kaob7fhWnSHDA+RtNk0aopl4HwgKAjnjFc
	Dj8DrLdff7JgDMv1ONZVrVW3D97btJdJl+owMMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:WChpd7i0wHWsLYVItBldyt7OGlmrwUkdH5bDeWvy/MI=:nrpoUjeGhXa3Jx6nQrwBvc6YjkiO96rVglBerQeILKs=;
X-ME-Sender: <xms:YxDFatoBAj23ZS8XTzksOuL38eDSs8mFdmEukrGIudgVPEvOaTa69g>
    <xme:YxDFaqd5C2Ql363Q-q5IqMaRrgHfxzmU17k1_8PV6_hl3qHRss3vvrJlpE_Ma6lBP
    r3PZK8wS4MAXYGLiZWF1EFOdNizLt29VJo_e8cpsBfPQ7g5YvIOqZZu>
X-ME-Proxy-Cause: dmFkZTFy8oI7AfTvE04zGVwLG2tUuj9jaUQLHwirElC4ORN1NUE3+pb2NAW9hifkaPD49+
    eBAKpjh7FWCdul/sTjKKD1DMtJwrmP7oEb2aeN9euV0usbkhzB+gW0OZUSaU1UoOE63K2W
    2A5GHMDlYXtC9ffCGK4i5sZ8go7hdnVmEpB50EmhywySR3j2zlBvpv/TICjGdUK8iDRMhc
    IFOWmsVE4QTzmLt70dv/inbEdSr7GZnbfM5EsufFPTZt9PYMnsi8oXvlUFTnYBnI67aNyc
    1FMRHLLaI2EjmOZ58qhHuA4DYVOdrcgUX8JsgRJSiioxtIWZHxgic5kc/iX7fgA/0y5DHY
    3s9LU2iPyM3WvY/K3YlTYQcOX/Cf548eNMR7pyTwiKKSbAzb5zTJuWPRYcpdTW9Z7l+WNv
    +C0S9saqoSn/GRNrFysG673VPazpNCpEhMENIimWbccBR8IjNJprlfRHtdpKsiQYs9a1lT
    TO31/Fru5z60I2pUWx9M48KGp4mv5Z9Rrwns3//zqAFU2Tt7x00yD9XgyvDWtfXD99agfC
    7gqEzHj3czAvT7aklQCCEYdlKaYO1mAFYGNWVbpTjoS+6LhmFL31LxBE3fOZjt4tX+4TyA
    LZdWz6uPxkM/yJTfp+Sqa8TOYpRhFNn/Xvl3qZt5m5RDV2ZSndKUlp0XC9cQ
X-ME-Proxy: <xmx:YxDFanzlpFSU09mL-fr1Xsr4D0B7gJrPmAGWBKA-e8tqECSxiVUZaw>
    <xmx:YxDFagw6eggw4BhdTV9snjA_9TCnMxK-ZuPVXH1BPDt7zBKd-ggL0Q>
    <xmx:YxDFap8NWgxE1yZY2NrowQzN0-3Aw96xR_1o5UrAP4E7TeVTO7P9Cw>
    <xmx:YxDFaji5geDStHerljuenqt1kmVRnyNiPIzks_DqiI7Ko5j0nK2GBA>
    <xmx:ZhDFagkMfsZ0OZvmIUTBeTItShUtN5SnOoEpMLpcKbkJqKrkBr8cSAuS>
Feedback-ID: i5cf64821:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B59CB18E0071; Tue,  6 Oct 2026 11:14:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A8p1gvDKPv03
Date: Tue, 06 Oct 2026 15:14:23 +0000
From: "Chuck Wolber" <chuck@wolber.net>
To: kasan-dev@googlegroups.com, nathan@kernel.org, akpm@linux-foundation.org,
 anton.ivanov@cambridgegreys.com, oberpar@linux.ibm.com, ardb@kernel.org,
 arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 dave.hansen@linux.intel.com, dvyukov@google.com, hpa@zytor.com,
 jinghao7@illinois.edu, johannes@sipsolutions.net, jpoimboe@kernel.org,
 justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
 linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
 masahiroy@kernel.org, maskray@google.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
 ndesaulniers@google.com, paulmck@kernel.org, richard@nod.at,
 rostedt@goodmis.org, samitolvanen@google.com, tglx@linutronix.de,
 tingxur@illinois.edu, tyxu@illinois.edu, wentaoz5@illinois.edu,
 x86@kernel.org, peterz@infradead.org, sashal@kernel.org,
 elver@google.com
Message-Id: <00ed0b57-ad05-4c5d-b152-7c81df94b23a@app.fastmail.com>
Subject: [PROPOSAL] Replace gcov and kcov with llvm-cov
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_081455_169573_8A9529DF 
X-CRM114-Status: UNSURE (   6.52  )
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


Stemming from some hallway track conversations with maintainers at LPC
2026, I propose replacing gcov and kcov in the kernel with llvm-cov.

llvm-cov instruments at the AST which enables precise mapping back to
source code regardless of optimization level.

We have a set of patches [1] that implements kernel based llvm-cov. They
need to be updated and some additional patches are required to address
some stubs that are missing noinstr annotation. But otherwise I should
be able to send a full set of patches (including taking on the
maintainer role) to remove gcov and kcov and replace it with llvm-cov in
fairly short order.

If there is a desire to take this in pieces or implement other
intermediate steps, let me know. Otherwise I can generate a monolithic
set all at once.

[1] https://lore.kernel.org/lkml/20240905043245.1389509-1-wentaoz5@illinois.edu/

Thank you,

..Ch:W..

