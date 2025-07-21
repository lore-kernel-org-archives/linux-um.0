Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE40C83F1A
	for <linux-um@archiver.kernel.org>; Mon, 21 Jul 2025 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uzo8U06w7Rz73mhF+wlvGbEWuZuIpHFTo5zQ50j8Qgs=; b=i2l9HfZC5i5rgHf2DxDXEKhpk2
	jCnhX8alOQ9FI3vjvDf2XU4eUhTMXZmijyAyAQ+taCz7b8SCnbZjhXwh0nPDPNpmd+DncK6Pfz1mh
	D/HHi/9Ds9s1w5ly7Z7N3aymiefcMa9THuRF2elmDidSYh5Bz1EPtTPj5RqnAGdr8xiTxOIfO/bcu
	0Hh0YdSsuhu0Kvzq1PyLUhhK/3TkR71F+8C+7uixZc7dsWQfvv4GmwsQexCG4w6vQRR4YK+fRncey
	NQseQC87m/6CvBkv/DwBDgGGNofD/LFV2X0F41kHsxLQ80nBJU9E82g40qWd0+oNrYB4okyLaVPpb
	XYxTOr7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udxLt-00000000exP-00CG;
	Mon, 21 Jul 2025 20:43:13 +0000
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udwx3-00000000bQO-1xwT;
	Mon, 21 Jul 2025 20:17:33 +0000
Message-ID: <70458c86-597a-4346-b18c-1fbd9a833a55@infradead.org>
Date: Mon, 21 Jul 2025 13:17:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 21 [drivers/gpu/drm/xe/xe.ko]
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 intel-xe@lists.freedesktop.org,
 Linux DRI Development <dri-devel@lists.freedesktop.org>
References: <20250721174126.75106f39@canb.auug.org.au>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250721174126.75106f39@canb.auug.org.au>
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



On 7/21/25 12:41 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20250718:
> 

on ARCH=um SUBARCH=i386, when
# CONFIG_DEBUG_FS is not set

ERROR: modpost: "gt_reset_failure" [drivers/gpu/drm/xe/xe.ko] undefined!

-- 
~Randy


