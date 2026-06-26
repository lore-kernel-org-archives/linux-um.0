Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E85C43458
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CkLfNfssIEW0SW6igjjDLzI26xT1AWB7xGjnkz3o0pk=; b=z4ysEH070KTT1VcipNaJZaL3gh
	9cNrq7lFkwWxvT66BzSuaEBlFdoMW+PgghvjHucxEmYlgihsNLZE10CcAvjv9tsSALXxQEabmpMQa
	R2p0vYyrqxPgNoHEQeC6j4AvBAxv+L0BgPI43lInxdPVg+vNR1IjFj9Seydsw0CbBRombQd25X/cX
	0D8E3/BiACQNEizNAR2TtneAUcHQQiFrCPjx5d31zc0N/hMWUL2GCp0n5bjpGGY6xdV/xkekZ3VjJ
	Iqi/Daow8L79UdbJjXXTdsqAcx1xlU4WqoJq8SFkYsCKO/xqBFxo0xjszzVt6m/eXqaQDBDEf+DmA
	GvJMvryA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdEB7-0000000BuBf-38Bq;
	Fri, 26 Jun 2026 21:33:37 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdEB4-0000000BuBJ-3sAY
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 21:33:36 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4926ee9e8d9so4840675e9.0
        for <linux-um@lists.infradead.org>; Fri, 26 Jun 2026 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782509613; x=1783114413; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkLfNfssIEW0SW6igjjDLzI26xT1AWB7xGjnkz3o0pk=;
        b=Vz58v9Ge+rkv5FaswWGjV4tADiVPlT9HHti2uyPZ0wj71aw9+UXbKJvQF/ZU5Rm/qI
         oZtMCznqfksg6kn+RQLgIB4TF9iifD+r3dx5GMuiiwALrMBT6GzsPyXCvmKMQDI2LZxv
         /jFUPmkbhdGIggX4gSI4pCB90mNR5OaWxX61lMzmcsrQWmjjJUdG8m752PnERqlTO1MD
         E3HoP6djz7TvIvIf2RTpnDqRgWwryzatxJPE+CB9wq4BTJ670MD8wL2qG2rbK92Y+ZRi
         JjNcL9RcNQQwRf0ikIYnJbHTiLMj5nOP60ObMJz9UDV6HXA3oF6rW5AzFzm4dPdk5v3p
         VrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509613; x=1783114413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CkLfNfssIEW0SW6igjjDLzI26xT1AWB7xGjnkz3o0pk=;
        b=oIa2AoMwige/VEIcvUjl3wGEdsMqciLZ5/ZaULcqZ9ncmrR4fMCkts6YiwJgWnuDN1
         zssHHhSQjqCAQcV8i6lNO3Vkl9y0SH0gnSdH6a4E68BVd3Vs5mDsbp6iS+K5Kg7P0HTt
         5Y1m3nrRDuC7KNDQRspWWgB5O7DB5cKRkhSrDsHUSWHE9BHqni7qaVgalKsnb1/47R6e
         sC0R+64o/CGbrc5j3S/mw0X277ttj9zCiSkVQ3VAbYnWJ1iILXWsg4loG2wCx8T/Lae4
         oDbY+W78A5YrHMgS47qiCWLZrrZE/uTbnqD8kQ+Psh3ua/7Ltzyviom9qdqLc0Y73rpq
         /Uqg==
X-Forwarded-Encrypted: i=1; AFNElJ+TlDbdf/7Nu10K0G9uh8J2TBtd6wG3gFDnzJFRe5uE5TEip39jYzTzi6InHY4lpyUwJ1Fa5iXB0A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxw3LPqSijM35qeJhX0UwLXAoMUp1ySVKOVXdypNoX/AhyCBN/1
	r+wN3GSP6oDryrscoDZti92jkYTBmzL5AIRocWKzqOsfB55mTw7Xnj0AGhcsBhLC
X-Gm-Gg: AfdE7cnVZ6gdfDeWZAmAOCjLUHt21ziWxPkqqd47eIklX7ruz+NQqtXPmsNEaUWnyiI
	XFij8AzlKFq+ftySEVCknDq+LUwl5xUrSonvNSe/FwdKtp1QITvNNvZd2UbKMg7qKkCwb4NO0wp
	TEuyLaVHxp7haR02LyHR6Zzu6IpcAXDEwdZdyRMIRZnTGlAyfm1NDnCLM2kBdKIPK/WqgIL0C7M
	2YMN01QZp3MWPqqZJXFJrcasHoapwezWmUtr+SmjFgOEFw0B0w6RGDVl+zJdbyz1RHlWwX3tvw/
	QnYCLleUeesvCjhA/HwNO/M1zWVwNoU6HAzao2PBuFumdwJhZusySukNLI1m2Cm4BLHHEqsUiA0
	i0soO7c6d5GNuCUQANexPD4rzdD+krKZOhvAbI9B/453tTdHYrrcB+bC1HHaZU2xn6XSB1Axm4o
	b1n5VgIG4JN7WD58hoYp7Pr1snAX5VsTnhOI64OuHJd+vi2CZbMQ==
X-Received: by 2002:a05:600c:3b25:b0:490:5000:917 with SMTP id 5b1f17b1804b1-492663d6d67mr113592695e9.1.1782509612976;
        Fri, 26 Jun 2026 14:33:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269002511sm104108085e9.8.2026.06.26.14.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:33:32 -0700 (PDT)
Date: Fri, 26 Jun 2026 22:33:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, x86@kernel.org,
 linux-um@lists.infradead.org, linux-raid@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/8] um: Check for missing AVX and AVX-512 xstate bits
Message-ID: <20260626223331.3451c11b@pumpkin>
In-Reply-To: <20260626205544.GB2368695@google.com>
References: <20260626043731.319287-1-ebiggers@kernel.org>
	<20260626043731.319287-3-ebiggers@kernel.org>
	<20260626084113.42eae31c@pumpkin>
	<6a20b442-b97f-4cae-9168-30201d5ef82c@cambridgegreys.com>
	<20260626114957.1a2b7e5b@pumpkin>
	<20260626205544.GB2368695@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_143335_088380_7BECD9D8 
X-CRM114-Status: GOOD (  19.69  )
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

On Fri, 26 Jun 2026 20:55:44 +0000
Eric Biggers <ebiggers@kernel.org> wrote:

> On Fri, Jun 26, 2026 at 11:49:57AM +0100, David Laight wrote:
> > > UML is just another userland application from this perspective, so
> > > there is no reason for it to behave any different from the rest of
> > > the userland.  
> 
> Which is why it should do the XCR0 check that the vast majority of
> userspace programs do, right?  It has always been part of the documented
> way to detect AVX and AVX-512 support.

That and looking at the other 'cpuid' registers rather than reading
/proc/cpuinfo.
If you want to run 'um' on (say) NetBSD you'd need to do it differently.

> (I think this helps explain why LLMs notice this too.  They've been
> trained on lots of code that does it correctly.)
> 
> That being said, it does seem likely that it's basically obsolete now.
> So maybe we could take a shortcut and omit it.

It would need the linux kernel to report a cpu feature that needed
kernel support, but that the kernel didn't support.

But for things like popcnt um should probably check the relevant cpuid bit
rather than scanning /proc/cpuinfo.

> 
> The important thing is really that we make a definitive decision *once*
> for each of UML and native x86.  The status quo is that the decision is
> instead punted to every individual AVX optimized function in the kernel,
> which isn't working well.

Indeed.

	David

> 
> - Eric


