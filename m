Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F757CCF9E3
	for <linux-um@archiver.kernel.org>; Mon, 10 Nov 2025 12:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oBxOc5qfBcOJZDqRmzm+wULwya9/QGtOyJO7/xhluLo=; b=ZnK4IbLO/35qlG+G86IqTm1Ccy
	en3ojGco8CYXPsHEhI3MxFUC4LUfRGQn/FyPaU6TqS1lJjcJJexVkATrC3hK7zhdXy/WUHk4j3gUR
	mTu/b2QwFAA7sRLtqt436h0xGBp9MHj1AvuOVdsOZF0BBb0cjK4IWk1IuvlSjT/Y5d+6zmD4639ed
	Adp1s9E0XiHKcgtdwLGf0jWbuKCZQ7VNYnRh3qdvZxMmCyJgifF1TJKU0DtPEu7xJtrZnW7YuGTaE
	am9+VeErBHSwhXYuEhKm4lD1owrCJamAYSFNvZcJGUyHrU+Aql9UqZTc1gww8ipCsmQfDzkTrIEIk
	LacD/gKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIQqd-00000005Oa7-2Udd;
	Mon, 10 Nov 2025 12:18:15 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIQqZ-00000005OZg-1Nuv
	for linux-um@lists.infradead.org;
	Mon, 10 Nov 2025 12:18:13 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-ba599137cf7so2182501a12.0
        for <linux-um@lists.infradead.org>; Mon, 10 Nov 2025 04:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762777090; x=1763381890; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBxOc5qfBcOJZDqRmzm+wULwya9/QGtOyJO7/xhluLo=;
        b=WBgmxhAKA8Mcg8stvJmBhj8qPbzIQp5NDhQJjHCXyKOixHBiiICXWQL6W9G7mLDaUv
         I6D6BUBpRLhVfahZh6A5pp4Ijr7WjJxac5lNphfI6+XH4zkNfLiRgfcxniFvWGyIrxb+
         KEzCim87NQA34L4BQrWf+YobBresFSIiFFT7oCrrpr6ev/60AafswVIVdu/8ytu66oQh
         bES+Ed1Lok0dPCkIoWqqb+RPrWjd57so6iM644lqrnVDB5D5KtmD88gNPFCaj7mDaeX/
         ukWFDa74iC0r5ddU6IoQYTHH8GWLwzDiGC6IreQ2htKCQ5mxAfEbjBeIZctZ0i/99v8Q
         aLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777090; x=1763381890;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBxOc5qfBcOJZDqRmzm+wULwya9/QGtOyJO7/xhluLo=;
        b=l7Mse3fJiRmwZmqEwNipyu9LwSQhzfUwQAyZfgXngLGjujwcq0TSSx1sdSxjYgWqq4
         kFNxm0XpqcpG29TQHyMW1tcaRMD9uvAOFE045PaWrv2jhlHxg7TpxgI1IFolAr7Pe6Pk
         wexM2oIlNHmi+zA5FUZHX4v36LRbRvtJhKe70q5BFW56z1uKJ6XYsoNx6RsYvFwtMGB1
         vyzNw868daPx2mj1A6uEE3w9y0/sthya0jhLEX815B6yC+QMxXXiJ4ALiDFZMDmXNrSJ
         ssT2xqLyCdYxBsKsanfPAS5MNj8aOKqbKNFUbVPwaub8skCtR/GkTVWNuyJHvAsoVHXF
         aEVA==
X-Gm-Message-State: AOJu0YwfHqTJDoIJ5Ez0hOpMNkqZzrz0MBHcdM+oKX2kWGfFqn7rF6+Z
	1vk1ua8ztzvvPiGF6VJXAGGUzLgWBKsG6JezfjW6GeUrsMNx6m/GEiZJ
X-Gm-Gg: ASbGncs8cGVR5zvOado5aYQYa82n5afYBSrVqW21OgmlmU8d1lDtsq6wFQIVAlolZCs
	5ardN57pq/vWNh/nyKVBdkBVerxsYc1KFJ0rp0zPR32670JI6obdRxAhIsmTteQ6Q3fxy6J9c9X
	1VYjLQfJ6qBN6e7r8w0x+o7mXpDygXB//0NpG6QGbo4qR6m0QPxIibiJLGzHJ0mtIvhrsJCzray
	KYR+2yR1xNV4IFTHIaSqeZggSOro2sZGf9gq4/esocIMwGOewMgmO2mSl0xY7oA5QMU3SyTFhWG
	fZ57v/Ustar8mlOOpKS6OfkFzwiraL0Q6fSp7LSgoD1/CikpuoVjQcSrmDaEgjHCvetahA1g3yq
	aWlis4oLz3/wYOp6Dg+Pgj7c18qLmsgUMbyf5PmdoD9DNcMIU2JiVeNs8j64saNumQX95jKCuF0
	2xhsWUqQVyVyMoYRaartv3CE1yyGk+y+eHmhcwdyLRzhhHkDR+1pECmUOSOKj1s4T0T1OJcD2VB
	64xWq4UF189zugd/fhwKw==
X-Google-Smtp-Source: AGHT+IHHASQUV9QkdfBzJ80+YLK4VSdlwhzAh7FRSiwznuCW7X2R7SNuVB0qK7gA4LbbzwDOGQTcdA==
X-Received: by 2002:a17:903:40cf:b0:296:ec5:ab3d with SMTP id d9443c01a7336-297e570a922mr108833405ad.61.1762777090029;
        Mon, 10 Nov 2025 04:18:10 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509682casm144137395ad.22.2025.11.10.04.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:18:09 -0800 (PST)
Date: Mon, 10 Nov 2025 21:18:05 +0900
Message-ID: <m2framxerm.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: hch@infradead.org
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/13] nommu UML
In-Reply-To: <aRGs8lPjH22NqMZc@infradead.org>
References: <cover.1762588860.git.thehajime@gmail.com>
	<aRGs8lPjH22NqMZc@infradead.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251110_041811_371021_B3FAAE9B 
X-CRM114-Status: GOOD (  15.79  )
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


Hello,

On Mon, 10 Nov 2025 18:14:26 +0900,
Christoph Hellwig wrote:
> 
> On Sat, Nov 08, 2025 at 05:05:35PM +0900, Hajime Tazaki wrote:
> > This patchset is another spin of nommu mode addition to UML.  It would
> > be nice to hear about your opinions on that.
> 
> I've not seen any explanation of the use case and/or benefits anywhere
> in this cover letter or the patches.  Without that it's usually pretty
> hard to get maintainers and reviewers excited.

thank you for the comment.  I tried to include this explanation in the
document patch [12/13], which I copied from the text below.

  What is it for ?
  ================
  
  - Alleviate syscall hook overhead implemented with ptrace(2)
  - To exercises nommu code over UML (and over KUnit)
  - Less dependency to host facilities

the first item is for speed up, the second item is for more testing,
the last item is for more extensibility in the future.

Early version of this patchset included this information as well as
the whole documentation, but I removed it as the versions grow.  But I
can revert it to the cover letter if it helps.

-- Hajime


