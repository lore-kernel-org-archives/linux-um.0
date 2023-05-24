Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17617C83003
	for <linux-um@archiver.kernel.org>; Wed, 24 May 2023 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8oau2q76kjZe58MJI/grSz7ejl429rf1O7+aO0URdGc=; b=PC+TbruvIwvb2N
	00I1l6AVbfi1HX8xpVvQjy8X1U67IeXOYTPWDFo2LxG8qpURqz3o5akmRPlHbxEqeD7+AzzylotT6
	ICUckNljyZEWF95atFHR0AEe23YFHby1eaCM3f9ARQnWs7gWqfzy9GfqgvxIaYKnO4KJbSFfMNsO7
	r0hILCzoU658E0qofEcBv0/kYj9k4BKaQBAnvl4pZvLBokxaVSUT0AMjuzf4yRTDMS2+QKNWD7Zyx
	W0lr0nvyDeZv4+z7tjPTkSRVDzH6plwOfsQ9rY9HPzNONa4qhSO8xm2GTTENfMmOa+084JRQE/w8H
	VqbpnovOG3qPmDorCgyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1pSI-00Dg1E-25;
	Wed, 24 May 2023 14:27:10 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1pSE-00Dfy0-13;
	Wed, 24 May 2023 14:27:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91B9522041;
	Wed, 24 May 2023 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1684938424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXGazCQJhB+4Gbe14ojDjDepmPElagpzQVjU1cq9coM=;
	b=CvxJjiwUfSN+kySKUn/EWA67pNGj3pzmDi1HbwCtE90AFBLWe7vv+d8M1Ij3FkSbIz4VTI
	gWvmGqepcrFlLCBiRAAf+FLKtDv7IxP6DOFYzfABdT3HuVDKFvuPv4HouAx5CI/XFNBevQ
	b0eo4MDqgOjEmRFkWmGBuHZT8lU/dcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1684938424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXGazCQJhB+4Gbe14ojDjDepmPElagpzQVjU1cq9coM=;
	b=pq5m/8gWb5XY3U0bzLALdtiUNBu4jqNs3ujyoKqIbmne//9yJpXq+qLIx07FO9Z84ILL6b
	c/7V1xSDO+g6aHAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1777E13425;
	Wed, 24 May 2023 14:27:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id VWz9BLgebmSqKAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Wed, 24 May 2023 14:27:04 +0000
Message-ID: <4f690e97-b26c-1705-51e7-0d7ebc77d819@suse.cz>
Date: Wed, 24 May 2023 16:27:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/slab: rename CONFIG_SLAB to CONFIG_SLAB_DEPRECATED
Content-Language: en-US
To: David Rientjes <rientjes@google.com>
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
 Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
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
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20230523091139.21449-1-vbabka@suse.cz>
 <be109b49-8510-5887-72ae-738db9945619@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <be109b49-8510-5887-72ae-738db9945619@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_072706_509900_AE2B184B 
X-CRM114-Status: GOOD (  15.85  )
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

Thanks.

> The Kconfig option says that SLAB will be removed in a few cycles.  I 
> think we should wait until at least the next LTS kernel is forked at the 
> end of the year so that users who upgrade to only the LTS releases can be 
> prompted for this change and surface any concerns.  Slab allocation is a 
> critical subsystem, so I presume this is the safest and most responsible 
> way to do the SLAB deprecation.  Hopefully that timeline works for 
> everybody.

Sure, and in fact looking at predicted release dates [1], if the deprecation
goes into 6.5 then 6.7 ("few" == 2) is already end of January 2024, anyway.

[1] https://hansen.beer/~dave/phb/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
