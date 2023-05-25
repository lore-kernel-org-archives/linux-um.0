Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34BFC77B7A
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Erzvdz9lurmREhxU37qw0WhNZ1xZbKgf1rIkoihANM=; b=Y4QolHR4cF/eTB
	EaZMJOmGaTVOXIRheB2PZy2utouf8CfKKVq4YSCkk/GtFHQkpCRHGe7j0pP1yLBc/sex3dNCFH87X
	2qiWrSSkXGkPMZt0M4zWZLymL3o5KgTeWOj3yw2jEvnmwC3BAOxFZyLfVWFbxgkR2pTG0/EmYrsF3
	zGOlF6hg20Gag9hc6mVvnZg2VLKM/YaUk5EtOlkPkVU8KDUkrjVvOeOrfwWoiH7vYVtOEpSjO/HZr
	P6CJP9RXwWB3XVZb/MvkxCAtESIKJSLL9Ccg0mlYW0ZeRbiS7imbpxuhezVAYQRijCYO7k2F11iF1
	dps1uvYtbkh2Izw51MmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FX3-00HMmg-1Y;
	Thu, 25 May 2023 18:17:49 +0000
Received: from mout.gmx.net ([212.227.15.15])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FWz-00HMkg-2r;
	Thu, 25 May 2023 18:17:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1685038584; i=deller@gmx.de;
	bh=K2LpqUproNVaEYfciKE2xUVes3IFu6inT1ojIZWxRK0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=opM6ZycxGEnfKtweb5YWEWAN530UjohDS09mCOh47Kc3Snfr/ROPCfIOylBQndoe0
	 ZLTz1BjU2i+TZdc+BU0Vd8M8Wn96D0zdWLphkPmTjGKyUODaFFapwbEBfZpLnQWf0d
	 dDNTogpfAaB7eMI+zlKffM1IsnD9yA9fQ0FHEdBH+OCQx/CffzuPXvfzk6u5LnAuUt
	 M067+FohpOaj7qFR3mAh+CzlDbYZH+jOmfokYU4AbodaT2hf0dXJVQ7hiMqViMf2tP
	 X5HK8oTI4EYl71gYwno969NU7xlpu9Y0wSDTgqCs8agQDFU6yDz7gbf40EgYGT/v/B
	 FHSBhye0W50Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.157.173]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1qPBBj3Htk-00lXgN; Thu, 25
 May 2023 20:16:23 +0200
Message-ID: <dda2616a-f4d0-fca0-5c5c-7a0f49f947e3@gmx.de>
Date: Thu, 25 May 2023 20:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm/slab: rename CONFIG_SLAB to CONFIG_SLAB_DEPRECATED
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Tony Lindgren <tony@atomide.com>, Qin Jian <qinjian@cqplus1.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-mm@kvack.org, David Rientjes <rientjes@google.com>
References: <20230523091139.21449-1-vbabka@suse.cz>
 <be109b49-8510-5887-72ae-738db9945619@google.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <be109b49-8510-5887-72ae-738db9945619@google.com>
X-Provags-ID: V03:K1:K1zdwa4g6OWygvqnRQK3gXolaxN9hnmaCD/sfFOygFxv5gAj6ei
 THk+aQNQMiH0oWH34qhfh7vFSX4rOi68z08hA0sfnE3E8jQpgoB8aCeQFBdovw6CWb27TGJ
 akSe+X2hZ+TCagNXuXGocolM7BrEtSmVXxnNOhc988TLQvzcbu0JUSnRiyxetx0lbRk6hr6
 RCFXL34mSj82AxaBd7hHw==
UI-OutboundReport: notjunk:1;M01:P0:yGqLH3vcUq4=;IeBJUDWQ4H8EmLJY7QSDptEyjrX
 /7ngAukTu5+WessWpw6c7f8qrRpW4JGSC7nPNRjj+Y5miQDY0dsuPzsAcCL6qd/PR5VCMHBPS
 E8JgPITjt58RQW+LXkgbHua0lJgufsN2sZTZLtGxRxzIcjbZzYGkvgfhxHpgnt1Qc4bI1F2jH
 IlNjipVfrrLZ9EknTVNXHpIbNmuaggtQUROs1GNscWNeOXuTbRtIElWCD3lG/2SaGCh2bJZ0H
 4daYHz9js01cfK0Y+vipU98eZ+G9vFObXuVLs5A3ULpfabkfcqLBZBw47hiC7xjVhjH7LOQkC
 dgWx2wGHzp3Uf6q3Kt/Ea3Ycn9D/fCFtoYWAXLQh48dMj9o8wz7g8bC7D5QYUlEygTpq8uBVG
 UFrzmA5nd/gCh75Ei+6B1JKixUNOmUNdJZ++9RhNrF4FX0zlIuzQH/PcKIrCoZRsURDQt8ZuO
 wQkku4i+G0xieBvC3yyOQImF2uBxMLYG8UTDEWH+4+T+JUp9BWFsxXeAwg56xS7I7McvJrLLz
 tUA5Hn6e2vx6UPn4nvHeA6JSXM/5pOX7X7Kw5IGoWspGzdY+X1OI9nDxRatfMk0dBppo9VdoD
 LsvM4IGmGM9hJZJKrBm1b+lfQwisdHfAjHTHjE9g8ZrflyBl4SP2kv+7cQBSyjCzWpKHDt+OE
 PvlYbD52GIneTph324pRyi2niQIt6l7SOhAz7514Iox403svHi9vqbyrQWNteeRl8zG3kL3FN
 U6AGRE18ei2676TvUjU+wckhBVDKBIKQhctOycQFMN3fBiyv3XJQGOJlofBh6wSrv2FEmF678
 2NOdbX/20joBRFq4wL6mUlvDxvkNv/7q5ukMbQ9BdHyNMmcbfWCFUx4p+LIcsJ/taNp/x4e3S
 3D9bXJ7icV9nFtl0BFX9I8mT1bHrL1rslN/dCd4iHansWfGb+Pursh6OC6oYejd2RljJ8UM/1
 WDrEhvOseS9Yb+a/0lFfWeAlRuI=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_111746_231683_BAB88928 
X-CRM114-Status: UNSURE (   9.41  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 5/24/23 02:29, David Rientjes wrote:
> On Tue, 23 May 2023, Vlastimil Babka wrote:
>
>> As discussed at LSF/MM [1] [2] and with no objections raised there,
>> deprecate the SLAB allocator. Rename the user-visible option so that
>> users with CONFIG_SLAB=y get a new prompt with explanation during make
>> oldconfig, while make olddefconfig will just switch to SLUB.
>>
>> In all defconfigs with CONFIG_SLAB=y remove the line so those also
>> switch to SLUB. Regressions due to the switch should be reported to
>> linux-mm and slab maintainers.
>>
>> [1] https://lore.kernel.org/all/4b9fc9c6-b48c-198f-5f80-811a44737e5f@suse.cz/
>> [2] https://lwn.net/Articles/932201/
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>
> Acked-by: David Rientjes <rientjes@google.com>

I did tested SLUB on parisc with 32- and 64-bit kernel, so you may add:

Acked-by: Helge Deller <deller@gmx.de> # parisc

Helge

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
