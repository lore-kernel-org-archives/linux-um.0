Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B793DD37E31
	for <linux-um@archiver.kernel.org>; Wed, 14 Jan 2026 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=; b=YT/xjtUGlXBX4PEUihCo6lnihN
	xEAGojRr2Xk0qiwZpeMF9LgKtlRlSP1BA0xzZGFs6OZRIbufor3Jjs6gzUWrDLNQZauQtPq/9UMnB
	Dga80KyZPNex8Ib3c5BidJGf1liJnngTd3c8WLmu7fB33anYwx9TWfTzkyr62RYaJHk86On+2Gx4Z
	EA3WuhbEdipAYdYxUR6sNEtMADzlhNl/yTKYscVo3KrbaNMvVbB9Vgc4mwgfz9zjJzMnhfTlZEORl
	CG3JCL+VPTvkZn71Dr2yocXrFD1HdVXIW1S/oXkZRWzPFAK7JoKXsqJSEAex2UdcZkTvX0HK3vLqJ
	QazwFflw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg0nO-00000009J9i-0Zgo;
	Wed, 14 Jan 2026 13:20:22 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg0nL-00000009J8R-2JKY
	for linux-um@lists.infradead.org;
	Wed, 14 Jan 2026 13:20:21 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-4327790c4e9so4608546f8f.2
        for <linux-um@lists.infradead.org>; Wed, 14 Jan 2026 05:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768396817; x=1769001617; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=;
        b=b572ExB/x727A9YqtI/1tYNHeNm3xL1U7aChGC7H5nyLA2CNd+Yu+90rB5bzVLfxI3
         ymaODXT2y8ceZGDUcKWo7AX38k8reGQod6dYiwDXd3GRjtBH1Ahln/nqCz3Sn79+R6ZK
         7NATuUaUOlUKWdAzN2gXK7spbAGjAnwNpJ1xERsq4f6ElcvPpSrnlKRZpgeDU2FOAclq
         yXDvuS7aKAP6iw77FZdYrHBYe6uWuCz0iD/A8Jzu+4KxB0/dxnwlo73YFL7XBupKsyTv
         RBffnuxrCrjctZMBvcU0F9fXGiBzdFwCJf7vMASljT6cIqSp15S6h5pmXubxKznNmorC
         htsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396817; x=1769001617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=;
        b=teyWOaXnNZ5djwDIGGga378qpD0NyEHtp7L79Yj7o6HFtMVDOEyDGVAxSxF4TAcj+N
         G0uKSiM7f2OzaO+Ibe8QLoQ8zqKIPTVvvbOk4VdHN2ZuXXIDEOpa9mTJjo1+fUE4qIAT
         NwijYzR1Gs+Hior4TxzPJYng4dVdCV7bbSCOh4Zm96gcSBE9ynpKfBAAxrOdcj3w43Gv
         vtCVxrzNOLVq3+RebxQL0n+xa7ZRnK6rHaP7I0eeQL5EPodq8kSBihoSPiSGxiRW8UnH
         gnPclF0HvpatpxEgARvR/gr1cTJ9hvK5p09V5HQJ/j5a8wCnai9jpHBjf3rb72Ymf8EG
         3LvA==
X-Forwarded-Encrypted: i=1; AJvYcCVecnfdEOi9a0NwPJrPf4njC5TEOKAsEERe8syT4G5XVt92G+66CEdap8aXM2Xosit2OTOym8n5xg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyeYqj5EWX1hvPTEDZ82DoZNabucoQ15UcL2xztwkMGYkw9iQ+K
	W1UAPFDezcvQHOR3cWdcFfUdNYj4/TAWqDMNipH75WwLg2QTQP4pP8F6tAWJrs7h7o0=
X-Gm-Gg: AY/fxX7dGF7ymdRo6V7+zSVPSsGCoEe7lQj4Z79S8/jcZFPlj4TLn9jARYTxmWpXR7y
	+Q76Y2hmYxmZUeILl6hvW9MItciRE8Iwt6z6jw299Tx+vFCl4nHck09azm1QSR0cSJ79znimg6D
	FlB5kQWACLVYdbKl9+Wb7odRgtdJI60HmvpONLwr87u5bO+sDHAd2m63HsYTn63qKBlfrJgeSGa
	t1ZhD+n5J2gnaQF0vI8xy6qaRw/F6hHA7IdSBjc3fZ3LoD0sk6X6ngtjcf5kBvmPBSsuCZpjCN/
	NIHcHW6g6+fiHb8S/euqatlA20GUi6NbOANYPm2Zk3hb6xkU8lNyFAMhtUIiHxvctWy8V6a3A2U
	+FVLerc8zA4f2Cl2fs8VOc8WDP7TOenDdFNMbAe9+Bc0GD+bZTEy/zQJ0x/tHKW03TmJaF6mceQ
	W2p6E7ZIHmf0836w==
X-Received: by 2002:a05:6000:2511:b0:431:9b2:61c0 with SMTP id ffacd0b85a97d-4342d5b2ab9mr2581603f8f.24.1768396817421;
        Wed, 14 Jan 2026 05:20:17 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm49153435f8f.4.2026.01.14.05.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:20:16 -0800 (PST)
Date: Wed, 14 Jan 2026 14:20:14 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/19] printk: Add more context to suspend/resume
 functions
Message-ID: <aWeYDoMsdBNkJEqO@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_052019_607644_809AFB9A 
X-CRM114-Status: GOOD (  10.21  )
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

On Sat 2025-12-27 09:16:12, Marcos Paulo de Souza wrote:
> The new comments clarifies from where the functions are supposed to be
> called.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

The improved comments would have helped to understand the previous patch.
I would either merge it into the previous patch or switch the
ordering.

If this stays as a separate patch, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

