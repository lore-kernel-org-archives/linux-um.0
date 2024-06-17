Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42900C27C77
	for <linux-um@archiver.kernel.org>; Mon, 17 Jun 2024 07:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NZ/V/1Gje+lwAsaRU65iTiBQ7cKHOyN7OLZBZCTKqZ4=; b=HVl+HRb/+E2pWuotYXL7wt5zb+
	x4eFFxjyohQg1syXSOmLK9Kktkv94+J7t9rHprQvwdyZqu92o9EnUclZTEYu27S3cRg9APUnfuL/A
	GGIMPCsgrrKwTwRwfEfpK6l1S1T5nDXv/rlcrL6y65AaCiafpafZUcoFC3n2/jYUoCnSwTjNDH3Rv
	Cnp+c3XVGRMdZ77bvW9snMBae3SaF/7EXeJfJeckLmoBp2LzNMzJHt1rQqQC9GqtyvhmJxXU/duNw
	NRONZmO1/nZWyOwRNSpFWJL7pX8VgpOE5qzmheuzlq4c3dDJnJhf1RH342wlgoEGE+rJfGyMV5vbA
	eDqt1nAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ6bp-00000009afH-03C9;
	Mon, 17 Jun 2024 07:16:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5br-00000009NR9-2eg5;
	Mon, 17 Jun 2024 06:12:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=NZ/V/1Gje+lwAsaRU65iTiBQ7cKHOyN7OLZBZCTKqZ4=; b=j5ZYmG3ZujE3wne5TQpcYK3emm
	uO8zBNdejJ8m0N+zh4sX+bOQ8wYEQnTwAq7/6aLl1it2tkKSEkUB2QBFdv7YvGOfvCOCnkl6uGjw1
	A73MnbvF2/u8HBSoG0xESjinh+L0ylUD51UrIqFRZxS7k8eSyjWZTYbgsFWHHRCRPoZG79FWkALgm
	abLEd4cDzXRKukk4i1fRSnOCaYvum9AX5BTkvAs69DmXQf6pqmMPc3pokK4HKNO6+fy4VSC5vpG4e
	oroWmWi/XiePlCzha0ycCTew6h8j+VP5+vTd+3Fm2evQWqVhaUumHvWrrssMbdvdEIR7rRMb4t0Qq
	2J2y15dg==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5bn-00000001qCG-0hIA;
	Mon, 17 Jun 2024 06:12:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C4E92CE0FD5;
	Mon, 17 Jun 2024 06:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722E5C2BD10;
	Mon, 17 Jun 2024 06:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718604757;
	bh=LrLZKWXkRakpWI4/ueXizJXAwKTR991d/slvg583xhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nFz/S8PqJ0x5s3Ny5I2evBmJDaO2EaUIuiWjAdtRmCQ/A6QpvJbLmjC0Fw7IXR1VT
	 uSNeYADsaTVxJipaBcqAsdKPSVVmorISGDB8ghzkIoBVgWELX0vnHVqN5Xf3bgHIW/
	 Jd7IHk4xFBOBn5HxiZsiAifRO0y8cGSStiGE0NqqwYZj3htvKjZ9JxGjZyZWwJADfE
	 WIUuoyvXMEqafkiqyCnfGPuXY7GxfWhCoyjXAFv1xdeTp+IRRcD16/M5uHMReQAzrM
	 yLcLncP795V2wNVqCHkdUBLru1ejkUmD3WFgvqGfKNm1zjEea2esQdxNT2nTdM/0yi
	 xUG82No+arhQQ==
Message-ID: <e4ce83ca-160f-4dd9-984a-842b6cd2b5c0@kernel.org>
Date: Mon, 17 Jun 2024 15:12:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/26] sd: move zone limits setup out of
 sd_read_block_characteristics
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Richard Weinberger <richard@nod.at>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Josef Bacik <josef@toxicpanda.com>, Ming Lei <ming.lei@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org,
 drbd-dev@lists.linbit.com, nbd@other.debian.org,
 linuxppc-dev@lists.ozlabs.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
References: <20240617060532.127975-1-hch@lst.de>
 <20240617060532.127975-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240617060532.127975-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_071251_495535_E27826CB 
X-CRM114-Status: UNSURE (   6.75  )
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

On 6/17/24 15:04, Christoph Hellwig wrote:
> Move a bit of code that sets up the zone flag and the write granularity
> into sd_zbc_read_zones to be with the rest of the zoned limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


