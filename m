Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AF6C3601A
	for <linux-um@archiver.kernel.org>; Fri,  4 Apr 2025 17:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CVpjpyZ90nxMR9O1nH7CdqvQxhWzU4ekajBODCtUhYQ=; b=au0UzDE6OQNVptU+hVl8ia0TL3
	3u+KL8LRS7D+DH0VUE8bdy+V0bb/ulVyWKCNHaOwCvOw749sOVjY4quAczDqzxOO5pQK/Aep+wE2r
	DHKzjDdR1yv5MCfxrrMhOBWwL03St6Vwfxne+YINY3PaWAyj9UU06lQ2GM4w076Sb6GInUjQGPtRf
	OB6+y0Tt2WP3rcNpAiZrgXsh1H+kXRuHFJUOWqN3XEGh5udt7tVDPZz2UUGA0i1v7EPxjo7y0t92t
	qFxBHwJBNcj2Tr+DZKtyvvz4+aIObJCg0K7vwl1vSIB5a8eU8kScQKc+fsAg4pAQCSJXANTGjmSeS
	DiZtsOow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0l51-0000000CRCJ-07O8;
	Fri, 04 Apr 2025 17:43:47 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0l4y-0000000CRBw-459I
	for linux-um@lists.infradead.org;
	Fri, 04 Apr 2025 17:43:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7641BA41702;
	Fri,  4 Apr 2025 17:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47B2C4CEDD;
	Fri,  4 Apr 2025 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743788622;
	bh=WJeqcUtnD+JvPCp95BzhzODUCYYMvFFmmq3rDIUcqSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4KPLgyY3xGfSNoxx05BGJCDtfOgYphVQM1ZoldOdeeso2SYhM1km51rPHKPwB/pQ
	 GJ06NvvjBNhsMQzJIvUMvXMETtTXsO0LWkcjP7CtqBfxJSSCZoye7qjPeoiOx1kiDt
	 ZWKMHiBmHZU27kWXOQI7fbYGkDq4pvMtkkRYR1VoVIR6ij5Gkg20gJVinnvxc+4Hln
	 0pLMb4KNxVCrO46a7TfFtjc086KPWG07DJC5spzimeJtmGzO94ULDmiHBAOlWDVvJp
	 ZHbUkDK/UYEW9K0mv7yvUZ5RZIpRiMCeq9pji34ELH1v5T9ZN5jyVg1V4+LWXJ2tCM
	 WVxxdgswoKZSw==
From: SeongJae Park <sj@kernel.org>
To: =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Vinod Koul <vkoul@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-iio@vger.kernel.org,
	netdev@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH] docs: Remove literal markup from Documentation/ paths
Date: Fri,  4 Apr 2025 10:43:39 -0700
Message-Id: <20250404174339.59650-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404-doc-paths-unliteral-v1-1-74718785444e@collabora.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_104345_080438_5A50DFA5 
X-CRM114-Status: GOOD (  10.30  )
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

On Fri, 04 Apr 2025 11:37:28 -0400 Nícolas F. R. A. Prado <nfraprado@collabora.com> wrote:

> Given that the automarkup Sphinx plugin cross-references
> "Documentation/*.rst" strings in the text to the corresponding
> documents, surrounding those strings with the literal markup (``) not
> only adds unnecessary markup in the source files, but actually prevents
> the automatic cross-referencing to happen (as it doesn't happen in
> literal blocks).
> 
> Remove all the occurrences of the literal markup in
> "Documentation/*.rst" paths, except when the actual source file is being
> referred. Also change the surrounding text when needed so it reads well
> both in the source and the web page (eg. 'see file Doc...' -> 'see
> Doc...').
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

