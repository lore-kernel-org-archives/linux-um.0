Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4D0C4332F
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 15:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DxyzuJllLQKsIKo8/VHETsV6Zk6a8JoqIAGLRvwenIY=; b=t89tWUl21QH0Dl
	YT/Ur0zI57a4apxiXOH7cB9yPUdPF1xSj7Zi+k9QyxehJRsxQwJpspz6b98oVaZ2ha1NVh+ejg+mG
	YeynFFKa2PQC/uEk17ZpRSZknTd80m0OHTVtChJwao01q4F5pDLPnEX+i7PawmzK3XRdxs1ecKbY1
	mhSZLUhkywWsx457ACd4G8FPRE5OTio+Gibpm51+qyq6XdWyRiNN6omgj0TCRmrxBOg9XhucShYMx
	c2IhfDMWF2uxmVSqcqevr4gpgHJFYlBhzxEwLYCyRVarzny22Oh9xbN74gIlx/m0pqgWuOMe6W+OW
	1mEUngdZJ9/dbQ3DYUPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxUlx-00A9XY-I0; Tue, 22 Nov 2022 15:01:17 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxUlT-00A9Fw-05
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 15:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+NFpLSd8ScOHEVd4DHTztoyZ+UkB3J/9rUIzBb7GyY0=;
	t=1669129242; x=1670338842; b=LLOXZC/WUtVrh6/Y6FGJmyJ6I6clOuJODtMKY6WvNc/8Zpt
	TF92eweJ+AzQaTvn+9WA1RUU61gQpKSlD4FnNMrAHAIxMrj/H9ygKTYm/QT1qx6c4TX+LgJ3/qjM/
	Rj+QPjaXacB0DtDFf16FC3PYCDjpjg+Gh8HzCWguZRaXTpZEwxrq+5XInXIMsm8hsAU3laSslnObK
	HhrQ2IS5axUeTVCkmlsWWPHabcFqnZg/rEKUQ5hwGJjhgVyD8WyKhcVnfJeFUGvQE3THbFkRZ4X1Q
	JkwmmMVm1sZvOueWP4AvawVJLO4CHkuEShsi+cRpdqeNDt8waJKKrDzF2Zt8w9uA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1oxUlH-006Ngc-2Z;
	Tue, 22 Nov 2022 16:00:35 +0100
Message-ID: <021efb6c9295402cf05406bb319c441c0b0229b3.camel@sipsolutions.net>
Subject: Re: Build regressions/improvements in v6.1-rc6
From: Johannes Berg <johannes@sipsolutions.net>
To: Alex Deucher <alexdeucher@gmail.com>, Geert Uytterhoeven
	 <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-um@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Date: Tue, 22 Nov 2022 16:00:34 +0100
In-Reply-To: <CADnq5_PvouSKugXxJXqkVeZf+kbP8+hhUKFgVALSO=MOW3jzvA@mail.gmail.com>
References: 	<CAHk-=wjKJyzfJmOzBdEOqCFRc8Fh-rdGM4tvMXfW0WXbbHwV0w@mail.gmail.com>
	 <20221122105054.4062213-1-geert@linux-m68k.org>
	 <alpine.DEB.2.22.394.2211221154280.284524@ramsan.of.borg>
	 <CADnq5_PvouSKugXxJXqkVeZf+kbP8+hhUKFgVALSO=MOW3jzvA@mail.gmail.com>
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_070047_066591_E0E68CAE 
X-CRM114-Status: UNSURE (   8.10  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, 2022-11-22 at 08:55 -0500, Alex Deucher wrote:
> > 
> >    + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer:  => 94:18
> >    + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]:  => 1934:1
> > 
> > um-x86_64/um-all{mod,yes}config (in kfd_cpumask_to_apic_id())
> 
> Presumably cpu_data is not defined on um-x86_64?  Does it even make
> sense to build drivers on um-x86_64?

Drivers in general yes ;-)

This driver, probably not.

But the issue is that a lot of drivers "depends on X86_64" or such,
where only "X86" is the arch symbol. You could add "X86 && X86_64" to
really build on x86 64-bit only.

I didn't check this driver, but this has mostly popped up since UM got
PCI support some time ago (which I added.)

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
