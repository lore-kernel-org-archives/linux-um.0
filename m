Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC94CEACEF
	for <linux-um@archiver.kernel.org>; Fri, 14 Nov 2025 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cle4/vff5SB1IWD4HNItwK0bPh/1KZ1BFPh6rOzhPmI=; b=qJH7UPDR1V58gbDgnodw9sw7x4
	jABIVLUaw4ESBkDsyJHe27bivT174PLoQ8/sZ4/7fnNkVpWiNQ2CLWU0z4Yga6ncfuHgZm3c+q39y
	tP+6RXueCqOlB8rL+XBleLKd6hYyuGT6vdQDeRkl8BGOvWfu6XFh1e00j77fqjVWLiHCe0n5mCTVi
	fXQXGFobgRBD2V7luo5BRV7Q734BckGdb1fcR/OjF/MWqjuI4+ZkGdtFCxgY/mVkE0DIOpHhHkHdl
	xEaSvF4i6jLgnrYZK894oiZyTEGX9VRD6OLL1wnR/zcH10jfLDnG0RC20GSAZHoJCzWa4zJikDEym
	Wfur3yOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK2vf-0000000DCOx-4A0I;
	Fri, 14 Nov 2025 23:10:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK2vd-0000000DCO0-3P2K;
	Fri, 14 Nov 2025 23:10:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ED0676022B;
	Fri, 14 Nov 2025 23:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FC2C4CEF5;
	Fri, 14 Nov 2025 23:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763161804;
	bh=Cle4/vff5SB1IWD4HNItwK0bPh/1KZ1BFPh6rOzhPmI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I9KMTt6rN59cZwQZpJIKV4NcU+T4pQVdUxYGYDSFDoq7S5hRKvRZDbqdzueDrp/2D
	 QnsIdVuF0CyJUp98esb2rOB3xt20JSx5c0+UvujPCDuRpfeGcXI4HLpJG9QHtg9Hha
	 kvbE3L7wMltT6S63DUUofMNuw3uQxX+UwDdNoZOH/px2oXTMrbWdSHaAhdoc/5tUux
	 m9uiBlPSPcXa5xCffROA/hh7TIjTSNpmFmGOwzAgLGNXGj1zG9v9zbpOnBca44bXoP
	 ByQEpbj+AReGYeuDeLb3RpcJj2vRBfaG0zsHCZKGPdmCjpiMthlrU5NxNtxLBPuNxp
	 AiwGco9rLD9GA==
Message-ID: <4e120357-6fa3-436a-8474-b07b473381b6@kernel.org>
Date: Fri, 14 Nov 2025 15:10:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] arc: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, david@redhat.com, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <6a4192f5cef3049f123f08cb04ef5cd0179c3281.1763117269.git.zhengqi.arch@bytedance.com>
 <5199c367-aabb-43e7-951e-452657dcdddc@linux.dev>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <5199c367-aabb-43e7-951e-452657dcdddc@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/14/25 03:20, Qi Zheng wrote:
> Strangely, it seems that only ARC does not define CONFIG_64BIT?
>
> Does the ARC architecture support 64-bit? Did I miss something?

ARC is 32-bit only !

-Vineet

