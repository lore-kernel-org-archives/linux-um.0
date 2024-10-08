Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED6ECED274
	for <linux-um@archiver.kernel.org>; Tue,  8 Oct 2024 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3HLSPTPFPl4JHmlxfANPp3i77QSJovILHZdFbYUFp7Q=; b=oqn3xSr5lVM0ZlWyHJ1EIdIHdz
	uBFcjXxho2wDJ6930cd+BszzudFHKvWWy9YR7bAeZkwnXDqrev4oe2U3FgYYxnDXp8GluQWS1y51R
	GoQ/MKI7zpJeXoqkBSrzEiON36MPqZfov2w7Zb0vO/H4eedWcXan8EgW83MZfGzuSFHvBdyQBXODg
	26aKl81mfE+qeMUoPc88R2Fu2AeFpFCVeC4dwpqyNwuF76JySV/1QM4TKADOk5k6rys4o9tlS2n7Q
	3+O0O8uFkdClq1x1ASeF3b0eOOos7g4ETqt72LRiOnrF459xvp6gPHMasrjV7rYG27kKd80RgbeIA
	iywKJfiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy5Yg-000000051oy-1use;
	Tue, 08 Oct 2024 08:27:06 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy5Nw-00000004yae-1wNh;
	Tue, 08 Oct 2024 08:16:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 224AF21A21;
	Tue,  8 Oct 2024 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728375357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3HLSPTPFPl4JHmlxfANPp3i77QSJovILHZdFbYUFp7Q=;
	b=MHkADYXc2+D2goxdzm7wzWveFN4vvvN/L+1Zm0UvmnLuJ0AbkL8b4K3JQ7itjD1mxwM+zm
	F7bARxwffL1ghA279FW268ng6qIZcMphj7qZQD40gXdPYxzhfw3uElubQA+a0cqJ0y/Lbn
	qmS9pTYCVXNxrDFRlS4nfouaru3Kc4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728375357;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3HLSPTPFPl4JHmlxfANPp3i77QSJovILHZdFbYUFp7Q=;
	b=V/U2fsX/TOYl6A27Fp+iOycqXu0yPxIf356cOV+gFVJZguaVkgBcxATfwz8yuPmntidiXT
	G0wInHb6Es4K+bBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1nVYAKpC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/aBSaAny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728375356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3HLSPTPFPl4JHmlxfANPp3i77QSJovILHZdFbYUFp7Q=;
	b=1nVYAKpCfTW9yzkEP2bqhnuozIrTnA+rUyCfaFURPWUHx/DnxXHz3ge1G84bJfMZo74ReB
	1DsSbu8EBvxXrLU2Kh9/PQX3AuXOctVLJX5ghqJ8dQs3qDzVeHqVSGzsEOKTgQZeP3W9Ih
	GN38j+a0+8Ejt0keBE+XBkeTkwBSQNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728375356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3HLSPTPFPl4JHmlxfANPp3i77QSJovILHZdFbYUFp7Q=;
	b=/aBSaAnygMw5K+Wj8fSmcTiDg64EoVC/sBf9RU9CM7B9mNZbJyh8eFmIQIbUzAdYdPQTJP
	uizbYKad5+RPZzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3E271340C;
	Tue,  8 Oct 2024 08:15:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9F9lMjrqBGeEHgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 08 Oct 2024 08:15:54 +0000
Date: Tue, 08 Oct 2024 10:16:50 +0200
Message-ID: <87iku3vwjx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Julian Vetter <jvetter@kalrayinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG
 Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert
 Uytterhoeven <geert@linux-m68k.org>,
	Richard Henderson
 <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	"James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Richard Weinberger
 <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes
 Berg <johannes@sipsolutions.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy
 <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan
 Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily
 Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle
 <svens@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Miquel Raynal
 <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav
 Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-alpha@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-sound@vger.kernel.org,
	Yann Sionneau
 <ysionneau@kalrayinc.com>
Subject: Re: [PATCH v8 14/14] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML
In-Reply-To: <20241008075023.3052370-15-jvetter@kalrayinc.com>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
	<20241008075023.3052370-15-jvetter@kalrayinc.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 224AF21A21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux-foundation.org,linux-m68k.org,linaro.org,jurassic.park.msu.ru,gmail.com,hansenpartnership.com,gmx.de,users.sourceforge.jp,libc.org,physik.fu-berlin.de,nod.at,cambridgegreys.com,sipsolutions.net,ellerman.id.au,csgroup.eu,linux.ibm.com,bootlin.com,ti.com,perex.cz,suse.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.linux-m68k.org,lists.ozlabs.org,kalrayinc.com];
	R_RATELIMIT(0.00)[to_ip_from(RL7rz6n1sdsaw5gxxy5soxc6on)];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_011601_049622_5906ABFC 
X-CRM114-Status: GOOD (  20.42  )
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

On Tue, 08 Oct 2024 09:50:22 +0200,
Julian Vetter wrote:
> 
> When building for the UM arch and neither INDIRECT_IOMEM=y, nor
> HAS_IOMEM=y is selected, the build fails because the memcpy_fromio and
> memcpy_toio functions are not defined. Fix it here by depending on
> HAS_IOMEM or INDIRECT_IOMEM.
> 
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v8:
> - New patch
> ---
>  sound/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/Kconfig b/sound/Kconfig
> index 4c036a9a420a..8b40205394fe 100644
> --- a/sound/Kconfig
> +++ b/sound/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig SOUND
>  	tristate "Sound card support"
> -	depends on HAS_IOMEM || UML
> +	depends on HAS_IOMEM || INDIRECT_IOMEM
>  	help
>  	  If you have a sound card in your computer, i.e. if it can say more
>  	  than an occasional beep, say Y.

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

