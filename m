Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E2DD10F4F
	for <linux-um@archiver.kernel.org>; Wed, 26 Nov 2025 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+mhDkufW6jQ5YRScCzzhwHbJH9j3fMQKiq5R61ePjI=; b=x+JvsiNLN6IMf2QVsL9vgDIoCW
	Yas23ewXWjX5a9hj9cOXxdkFeZRGeIurUQp/51LVVM0AotmkvORn/TC0djoLjB9Mmvcrq0hpx2Qsn
	u8J8V8EShWNMNL6vmGxc+GKLdWPKlyYmvBrXbYqs2KnZ9dPrzrpS4SnufbCr3mbRSKLI8vYhk29PS
	MgFZ1HGDJ8ZL+/eSyRkJC8FvPiiyNSfZ8vvxehN64nFpZIsWbH7U1J/hVVvp5NOJMhdhWPOqVSLO6
	U5xc5yniOR5QYIGn8ZQTjWLc6G5iU0OOL2l8GR62941V0ZP5w2GuBdOd9MtqcCyl3TcTB3gt8vA17
	c/GprU4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOFTy-0000000F2Ok-1eJn;
	Wed, 26 Nov 2025 13:22:54 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOFTt-0000000F2O1-2cW9
	for linux-um@lists.infradead.org;
	Wed, 26 Nov 2025 13:22:51 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-42bb288c1bfso3945697f8f.2
        for <linux-um@lists.infradead.org>; Wed, 26 Nov 2025 05:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764163368; x=1764768168; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+mhDkufW6jQ5YRScCzzhwHbJH9j3fMQKiq5R61ePjI=;
        b=BZ6Ymv/0u1F61nhU+juuCuQJJ160ykgq0qJuJfUK4MtS9GoIlkebh7nJIxBmLWlSRi
         5STUA18Pxp85ey61NjTLSKaE+N3XhAX5nTUS9OWyQKnHzhc1fETqO2Tc4UXdJ9sQV/5s
         BIOfbxhroXBlIOKl4t74nvZuIUS+B/PkbN6C6xEPCyPOiqc57jfD4KiEqtGb+OJ5WoTC
         bkT2O3VvolHmnLoOL0wJZkRtIasGyncbiSbmlL/Q8q5zEEhOWMNAJPlL4J/NoFrD24wU
         34e/CBUTU7f/QaNNiDmJc4Km1iDNgJteR4P3gLlitHNJm9BtxcEuDYpOIId79e2fiH1i
         YiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764163368; x=1764768168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+mhDkufW6jQ5YRScCzzhwHbJH9j3fMQKiq5R61ePjI=;
        b=ht2O8Umsvnvl+fguB10WoJDlo9TRzF72VeKm44dMKSHs+mNJioo3qLLLxhQW5tRtjh
         FdWWaz1WZae1eR4gofiJCiMbaSxi8dHzeb1PeTycMoO72DJU8JGNghQScdU/DHFMIhHE
         hReKtWn7jOQZDKpycRbU24ElBJ57o9UK9IzQqGZd+/1HzOz8BM4R5RLsRBi9Fn0pL8zt
         DsVjhpdilUxTiO9zlfm1ACvWWhU9vd5wbBeMkal+MNsR7CIMNI0uP+vNvFSF54dQuxNc
         DO4OReDWD0Duxi+fUTSroMUKFc9aSMFu2kYfgHq1Fu4LbtGe1CnF6k5zJMlY2FRP5x4G
         vWNg==
X-Forwarded-Encrypted: i=1; AJvYcCV0cFTzfY5QcgWB5/lDuDOdQuVHanSeLsCpWdg1Y3cA+QlPyoxVNIxHaTVIMtap/J8TAaQonGxlsQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YynxcZjE1mcgFS+k/vcFbXcy9SpsocCdVdzmGTdyD/HFuyxMHB7
	ARuLUZcm7eIcFAjaxxgjEJv8BKlRs42ep++Nz8qWBO3h30Pd+aNW5zi08+WO0g4o35c=
X-Gm-Gg: ASbGncs/JmEVYDtBen4dCO78zPzaIbIwWxQqbxzcMWGK3vdxXPymqXPJFdUb7KuTnmA
	a5XXDixkcy2gZd7I5AI/ClvtXnOgidwnk33eiyhxQij3CDahptH7Xb55AtOfiyUrp8LFCpY61Td
	2ycAPVxbr1UQNrHfXPWODXob5NwAmnYa4U9aeBmKq6W/In3o+EkXE3vOVxpuxA0rx/5amzQm0k1
	bb4BDCZCQuolYYsMd2XtQB0c8fAVOFH38S+db0txsOB57NrztG+xhzi4mOVWlzBw2WxV455IRBN
	WGL/wv67wEr+ySl1o6+b5p5gFUDDGYv0YOWaLeoKcpajkBiI6ORMkV7f8BNs5mNIhE3TlOmcsfS
	GAzA4rJYFEXiXNDT6OO25Btf1Q0tFOjR/bC5DR/nRw2bbgjkTdBmJu/dzoYw3pBSVKZZQUhJ7qO
	Xds6yTkEiknIS97A==
X-Google-Smtp-Source: AGHT+IGJcihhcxfNfd8mIQtL0Z/0hLrPGwpypQO8Ri9oGZbHR7NXbvwNhm6TwKmffccOm4pb+YONkw==
X-Received: by 2002:a05:6000:2288:b0:429:c4bb:fbbb with SMTP id ffacd0b85a97d-42e0f2129cemr6983138f8f.13.1764163367783;
        Wed, 26 Nov 2025 05:22:47 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a81sm41314165f8f.26.2025.11.26.05.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:22:47 -0800 (PST)
Date: Wed, 26 Nov 2025 14:22:44 +0100
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
Subject: Re: [PATCH v2 2/4] arch: um: kmsg_dump: Use console_is_usable
Message-ID: <aSb_JDBBX9Yh0jCM@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <20251121-printk-cleanup-part2-v2-2-57b8b78647f4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-printk-cleanup-part2-v2-2-57b8b78647f4@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_052250_319002_AD87D5D9 
X-CRM114-Status: UNSURE (   9.11  )
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

On Fri 2025-11-21 15:50:34, Marcos Paulo de Souza wrote:
> All consoles found on for_each_console are registered, meaning that all
> of them have the CON_ENABLED flag set. Since NBCON was introduced it's
> important to check if a given console also implements the NBCON callbacks.
> The function console_is_usable does exactly that.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

