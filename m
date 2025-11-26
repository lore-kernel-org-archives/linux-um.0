Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8413D10F50
	for <linux-um@archiver.kernel.org>; Wed, 26 Nov 2025 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0f4JQ430d3gYxGe5A4S7xjaYOrTUOg5SC/fVmpakeBc=; b=ddIpJMUdpHBj8HgHVsDwq4/GsB
	8ekwh9InEcHlq/soEPAzza3qEx9jBhOffjdQVf6MbZBN7FkVlNLrpCAuykjD/ymbLpq02FqRfmc6R
	+1WYgXS5MxpHs7QmWltx1nKxG/ZOw8MrVRT6ZY3c98/wJXbEHCKnz92cGfYn9qNl4LgDilTyHKKuC
	5WGrBqfQGSHhwjUz+CLNGXTd9P6oDcGj0KO5SeOq2Yx5NKcBA6cF1sQTJ78qrmnjXjjXNoqoYrM/p
	LaYgfxYYMvZAyExIWziVMKEIMCMCx7WqNI5MfShNQI07SWkeB4iHqyiMMoD+qD4In2i+KhUobgQ8O
	9RCK4OCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOFW6-0000000F2ST-3mbj;
	Wed, 26 Nov 2025 13:25:06 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOFW3-0000000F2SA-3QYc
	for linux-um@lists.infradead.org;
	Wed, 26 Nov 2025 13:25:05 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-42b38693c4dso2943294f8f.3
        for <linux-um@lists.infradead.org>; Wed, 26 Nov 2025 05:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764163502; x=1764768302; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0f4JQ430d3gYxGe5A4S7xjaYOrTUOg5SC/fVmpakeBc=;
        b=YrbUbUThKh0xbO8p1i1/edX7svrzqN15PW6XZ1nO1ThbW9Xz1xSlw1+jZC6cRLBAB1
         gP7GJvlI1hF5+t66f1TxUQofqNqDAC+eyrmdUbDCm9NaY1be38bD8teiXYRhNopCkaX8
         bvBQWVjoxb7Xjl9KuPhqOqCBdMod4x1rBI7Iq1ae/iKWsAT4cxsHH2jnqCFLO9tSaA5k
         2uCvtDm4oKO2ZRNF2pa7p02KuA5kDUMKpIFrJz50ITn5XeIDchPpPXxIV5X9vFwI3GUD
         7coF2srs2rGaVM7aPbgIDeJdsDCKwQu8AC5HWiANUUlFiEgXTvnTzrV6o7ln7+b4f8tt
         UGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764163502; x=1764768302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f4JQ430d3gYxGe5A4S7xjaYOrTUOg5SC/fVmpakeBc=;
        b=K2aVHT23eAKw3KtBoYbzgNd9rZCck2Y+6FeWeXOAfQbakinGPwL05wvSqg5uzjs8up
         8NE4bsEqsUJWwrS/6Om7ptwy5TsYnkcRV/xtGNLmPmiO3vIQ0HZj9B6zum+7Yu8CFlv5
         LcD/7vkmpVkVWCFwaWe0vLMlphQQilwRwy4/Sj01DFTW3CBkJfBcAG0RLsYL7UfCSkAj
         Z16NWHV46WKaRnSmtZn6QWp2gpE3WvJPAokAkesCawBf+yI6k1e0RFU3qzK5NDyJQZHN
         h5qaV48I+sbnuqZ+HJnu/VV2nByYF69YzEkjhjKmD/l4eTIcBHwRsv3xVWUbklxC33Dn
         jF/A==
X-Forwarded-Encrypted: i=1; AJvYcCUo/bBRvirahQgkWfaM0mEeIAHPPeZbaHLb06gA2sjeTToAMBWvhl2Wb0jU+NI+kyS1Dsj8vaKlOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzFlXAoO1trFgB1Ve4sc+PUXL1Oq5IiZI4Z6R2p7xi0lPXRXvZR
	lTGUhZXmPVFmYtcV/73/4QjHe1y6TOC4C9GZBbxk/naWaskNR1QUeEHrgxomq6a7tBQ=
X-Gm-Gg: ASbGncsA/2HRsyJ76JZ/hwoNViuOLgDTjOWdnN9L7nwTBNvgY3q7dq3ZK4KL2SbOYpB
	7kfurbsNfIOhYlfU9r7wkdyAhXr1O6GX6dtSTw/EaIhSP+58Dj/JF9dKIbdRl7QLDGKtDGSo8f4
	xBVSatR/UfVEzKuNdzPhpLQ1VxnJYI0At/i1Z+3ak9mJmojjSeukm4m0BLTZG5OdJw6XzU75htU
	4+cPL4DLYfUtVy8oYVzakVKuIvLXZKHw2IIzQdvQGL9997caJM2ae6XWd/zLpOJ3nsECuvqh+Sd
	xn9HW8GSYX3J3ER6QszqGBtQKjdwZl9qNTs4ZhHs6WzokedREo4nFdd5spMsaF67U71bDwj/gOo
	YFG0pGYTDYOxQhCD0x4e3lSB2JGlT6UIzRRD9h87UrYcTP70px/pJBJW1B1Q0w2r/ukeyktKk1i
	UbJVHuPrqUG6G0bA==
X-Google-Smtp-Source: AGHT+IGt6B18Cfsh2aUtNnKQ/GdUe6r5HR9xnqzEThLvWMbBGO0PZDF86prVk/ruzgDmDAMG5bRFMQ==
X-Received: by 2002:a05:6000:310a:b0:429:bb21:94dd with SMTP id ffacd0b85a97d-42e0f35024amr7000231f8f.46.1764163501920;
        Wed, 26 Nov 2025 05:25:01 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8a29sm41169883f8f.30.2025.11.26.05.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 05:25:01 -0800 (PST)
Date: Wed, 26 Nov 2025 14:24:58 +0100
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
Subject: Re: [PATCH v2 3/4] printk: Use console_is_usable on console_unblank
Message-ID: <aSb_qmjfNc1seDzb@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <20251121-printk-cleanup-part2-v2-3-57b8b78647f4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-printk-cleanup-part2-v2-3-57b8b78647f4@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_052503_893063_2BCED5A8 
X-CRM114-Status: UNSURE (   8.88  )
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

On Fri 2025-11-21 15:50:35, Marcos Paulo de Souza wrote:
> The macro for_each_console_srcu iterates over all registered consoles. It's
> implied that all registered consoles have CON_ENABLED flag set, making
> the check for the flag unnecessary. Call console_is_usable function to
> fully verify if the given console is usable before calling the ->unblank
> callback.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

