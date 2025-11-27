Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23373D116E2
	for <linux-um@archiver.kernel.org>; Thu, 27 Nov 2025 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B8l5BzR1mRAYzIMvpm2Ko/o8KqU+gsOnJSeaJXaAzPk=; b=L3KNEGbJO3P8io0p1l9rGlsa/c
	51Szx3LkJi8BfgcNYJS+A7PkCaGIzWf9ufG/bPh/MPXk2UXHqMATN8yeJ3j9nCj+bLbPgneNdHGlW
	EP9Zf7wJoZ2Tmkc29jja0zQaYScpHXKwwnQd9wHnQwMI9GSeWOrUYdo3W0c7LmjDz4Ok/CjX1mtiy
	0xaBXJQWoDeqSlNUo/rtCT3X9CafAp8MQqWMalh3qyqZTCV0xjxyUFcs2En9BPqmY4LnR+xgYFIbV
	Y6bkwvNIxPfmBb32+AQ3DNfKrphu8JkDYiEJMQ2Dvq8lhRNOvTawOgAkBShRMGguTInlcazR0Ydop
	h/wZsYxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdlg-0000000Gq0N-201W;
	Thu, 27 Nov 2025 15:18:48 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdle-0000000Gpzp-1pZQ
	for linux-um@lists.infradead.org;
	Thu, 27 Nov 2025 15:18:47 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-477aa218f20so5882655e9.0
        for <linux-um@lists.infradead.org>; Thu, 27 Nov 2025 07:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764256724; x=1764861524; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8l5BzR1mRAYzIMvpm2Ko/o8KqU+gsOnJSeaJXaAzPk=;
        b=VVJKtKPEtbj3+V6gxQuBXIBYBtbF7zoBl//ttVQ6XjKaECG5KAqFHO3k9G2yWvO4fk
         w2duNyW8SzCmmdUfcdMjD++dIRAg6lAdcabu4TbvEq/xuYXLZJZsyllpg7LcW6FRL3ZG
         0yxdnIMC8Hv+zGUJFHvPgQymJ79qMO2VSleCDtR2et713OQR6CsZJVjDb8geXCbg7lQG
         AI42j18tqL54pOHyrupqVFImPSBX5RQ06t9IY8/1IrF7ojeTUAsZJyED32x8TH85wGEY
         X714pbNEokBLD03OK2lZy369QtFirFrXB3doiMXIuPNb1T76U+Nn+jAXX3Yczdm6Yy5S
         vNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256724; x=1764861524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8l5BzR1mRAYzIMvpm2Ko/o8KqU+gsOnJSeaJXaAzPk=;
        b=p+MnnPmLxlLvJIdnxM7QDKZW1T+9jQFC5Dbm3pzZLAMiUVDPThOgamyB5N5oS+64lv
         TPkjOSn25xZ1zgq4pHKCzKbvs0DHACEeHJhVw9uCSzt8cCSNzY6rV77REk6PMhnaKHii
         rn8MVca1VfHwjlV/MPUqjW+mxLTvxqF85UcIvywoyoydLJ6QZD7sZXdtHnKJg/uDJgsk
         2jtj99/7m0+isje3St32sSkAt6zcXp5buWCD1R/yHVj/g3QYxmjGhcdBv2pLUErMXsjU
         yIsjjR4M/kRPnmQVn/i8AUGLHa5cehxcQDGIjbwx+T2hjgKDah+4Hcb42PrGxkAZ+9Ly
         LdTw==
X-Forwarded-Encrypted: i=1; AJvYcCWATiZigmqKrE9pXivbabOMQpI6Xlaqutxwcx7sQHs+jIG+g8/3kwKMFzKE7ic2uF4tXt+Q2n00eA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwfNmw1EXXRwH+4jDFCNaotF6eOi551xyyrUCEvMxEklSuD7s1x
	9GcR69iTybHc1nFMcuebA6eIhcFK+DuU+0tGdpTtcS6NqocySSh+KHcvSYvtogxe5SM=
X-Gm-Gg: ASbGnctRaOuH7OStA3Z3dnyc6Yaobvvj4sgj7mVr8X/4D8xdpjSryMdqfCRZLrDMkis
	382+n0E9nOOftEArevFEo0gfeo/MotE5Y6p+c1A01+TwIYYf0LR8U7/wL4pqT3/5LCV0FDwPEud
	Qrjqox2Y6bjL3K6U/zFvdUaxlUwoHnHyGZ9gr6zWPwrUwNJEQhFIvy8E8Cy5hJUw9fOLm7/PltD
	47J4JEyEkeBdskbQ7ahSq2t4ctYfIZRyk6N377kWmIKh+zSqEKmXxSkE2wiq5/jb7Ff+f6z4gj3
	x0429DPpHGjArVAc0P/rhtiIGaJItjCnTKBCVxc6TAwScphQJfAinTfDH9jdyqxkikRKOSAVAYk
	aTNMjwfzBrQiG27wLz+fTB318bLB9uXnk/kZb/0v0cOoxlkxrT0FeQpEYWJDQAz/lScU8SER2hF
	CXpFSwb1lB9FySPK4Tn9uzl9Wz
X-Google-Smtp-Source: AGHT+IE1ABJky03kTdd0RIp7HhLXOcrkFMBT0s/CBFZhAw1YYwvym+Cxf0cLbK7YSjhHltd5yp0qEw==
X-Received: by 2002:a05:600c:1f94:b0:477:7725:c16a with SMTP id 5b1f17b1804b1-477c0170de8mr221559015e9.10.1764256723867;
        Thu, 27 Nov 2025 07:18:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47911143a16sm36586915e9.1.2025.11.27.07.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:18:43 -0800 (PST)
Date: Thu, 27 Nov 2025 16:18:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 0/4] printk cleanup - part 2
Message-ID: <aShr0DZRmpDnL0nz@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_071846_484656_F4085F39 
X-CRM114-Status: GOOD (  12.52  )
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

On Fri 2025-11-21 15:50:32, Marcos Paulo de Souza wrote:
> The first part can be found here[1]. The proposed changes do not
> change the functionality of printk, but were suggestions made by
> Petr Mladek. I already have more patches for a part 3 ,but I would like
> to see these ones merged first.
> 
> I did the testing with VMs, checking suspend and resume cycles, and it worked
> as expected.
> 
> Thanks for reviewing!

> Marcos Paulo de Souza (4):
>       drivers: serial: kgdboc: Drop checks for CON_ENABLED and CON_BOOT
>       arch: um: kmsg_dump: Use console_is_usable
>       printk: Use console_is_usable on console_unblank

These three patches were simple, straightforward, and ready for linux
next.

I have comitted them into printk/linux.git, branch rework/nbcon-in-kdb.
I am going to push them for 6.19.

>       printk: Make console_{suspend,resume} handle CON_SUSPENDED

This patch still need some love and v3.

Best Regards,
Petr

