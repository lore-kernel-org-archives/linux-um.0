Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF51C6FD1C
	for <linux-um@archiver.kernel.org>; Fri, 10 Mar 2023 07:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4jr0vM8MtDTETSJMWrgW8itl1Wwl6B33XHUF/UsxLOI=; b=qMjyzLk5EZeB4U
	IU2lfi75xBprnDF5i0mL/FEqhzXt4GKuCm025JMcuqmp7xZxP4/SbixaMru1mjvhLi9F+FDvOEF2E
	TyjowS/FTDhmgqoD4LWVB+3lifnR3LulEKvZG3mQyqs8vD69zUyzMdml6kHSBjE2PeG3D0tae5We8
	bNCB3+0feyko975805g0YfH6xlxMpkArLT+z9KeXB5gFpi2ftIDAJBvCihQWQBxzMdEOsD4ArHYrU
	pePs9g9VvBkJyQD+a7n/26kwalfQZQm7vawUnpFE9jRxhYpzW93Kd+0/OgdrXk/rUB/eQIYmp/vvd
	PWqi53JbcDYB7PtQuEGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paXb7-00DUIx-II; Fri, 10 Mar 2023 07:55:29 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paXb5-00DUHJ-4r
	for linux-um@lists.infradead.org; Fri, 10 Mar 2023 07:55:28 +0000
Received: by mail-wr1-x436.google.com with SMTP id bx12so4172548wrb.11
        for <linux-um@lists.infradead.org>; Thu, 09 Mar 2023 23:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678434922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg8gm9UXcuofNWv7bFMURJvZUDWceYZ+g4VoqacHVTs=;
        b=XcSpm5S1c3LTIpRC/qSv/wD4Phhsa4jCsOLrRowE6+YdUtdlMT2Koo4r4ka6wFxa4s
         mtmwQTOSxubEKjDOJHdMhFnLsJGYGswUw+sr1KNk2NKS2T3JoyJ4tC2yQ7YMYIa1d3Mt
         rHkS/x1f4mBTfXxgRjQzy3tmceUijtRWfxMuKBwmqxZWRKc7Z53+obu/JywSWMi4tQEc
         vz5tAeb/V/iMQ9/rY/c15TPEilikvL592wkSLIgZUx2SfyPHnWmM/7/g3imS6vKW19yI
         ym6Zc3ZpQIlu8g5Hy7T8VPCgf5PMVTYE/XTZxI225FdRPvGAKhPftedSSGQ2tCGKfR3b
         I7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678434922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hg8gm9UXcuofNWv7bFMURJvZUDWceYZ+g4VoqacHVTs=;
        b=2h9wolDEpgyurOgN/v2O+5bbu9de4mtKAxwmvHOPO3XRfF9ZDUraxOXXCEEDxoy/mF
         rZ6VlMfLq4O8JWUgJFYPHbwbjUwA8fAeAkXn3C5JClQhyqcNVO1rYKsaSBsh5McqNlQh
         edQELy/M3Q9W8RkmXsl51zOlAIpnweFCAgYXTbRJEB8D8Rxdz8IhTvuBjawJaK0Eks7Z
         Jsu99gmm1aofFgcWR5xlH+wRq4zWaoelDWnNIhEg11IVQHiP9FRhwP5Nek2QEaBgYpZv
         hc3pqkmalX0cbq8eoWZtjFoAPxMXE3XTUeTNZckgFMneuhR//wXTnAf7RrCw6A3U5HrV
         KYFQ==
X-Gm-Message-State: AO0yUKXf1utmey8jMixeSbNJUArQfJwgYiE0+AADOEC8HwVvDTrdc7A7
	MuWfE4CMh4JTNa/ID0xwoMdYY86gpCew8YHEwCmt1A==
X-Google-Smtp-Source: AK7set8YJqVZRqtut+bMEQTqwl6r469KIAYC+a6PXbytDy5dL9Ft02+G7BXUCv4WmitzpSAnNx588vSN5VKBNG4uKa8=
X-Received: by 2002:adf:fc0d:0:b0:2c5:8377:3eaf with SMTP id
 i13-20020adffc0d000000b002c583773eafmr4846173wrr.2.1678434921777; Thu, 09 Mar
 2023 23:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-2-sboyd@kernel.org>
 <CABVgOSkxOxpaHVtq1YpvNEshTZ3nic1p7NjV5DPdz066=tiS-A@mail.gmail.com> <377046f369227a11fbf9e67c3c122d79.sboyd@kernel.org>
In-Reply-To: <377046f369227a11fbf9e67c3c122d79.sboyd@kernel.org>
From: David Gow <davidgow@google.com>
Date: Fri, 10 Mar 2023 15:55:09 +0800
Message-ID: <CABVgOSm_yRjqKYegZeFkObkS9cgXaDfD2CTeoE1s7RRLo=RuEg@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: Add linux,kunit binding
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	Brendan Higgins <brendan.higgins@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_235527_211319_20C55696 
X-CRM114-Status: GOOD (  18.30  )
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

On Fri, 10 Mar 2023 at 07:12, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting David Gow (2023-03-02 23:14:55)
> > On Thu, 2 Mar 2023 at 09:38, Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Document the linux,kunit board compatible string. This board is loaded
> > > into the Linux kernel when KUnit is testing devicetree dependent code.
> >
> > As with the series as a whole, this might need to change a little bit
> > if we want to either use devicetree overlays and/or other
> > architectures.
> >
> > That being said, I'm okay with having this until then: the only real
> > topic for bikeshedding is the name.
> > - Is KUnit best as a board name, or part of the vendor name?
> > - Do we want to include the architecture in the name?
> > Should it be "linux,kunit", "linux-kunit,uml", "linux,kunit-uml", etc?
>
> I think I will drop this patch. I have overlays working. I hijacked
> of_core_init() to load the testcase data from drivers/of/unittest-data
> and made a container node for kunit overlays to apply to.

Makes sense to me, thanks!

Looking forward to seeing how the overlays work in practice!

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
