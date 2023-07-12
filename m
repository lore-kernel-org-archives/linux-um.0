Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC35EB64DD
	for <linux-um@archiver.kernel.org>; Wed, 12 Jul 2023 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sn1/KW7jP5OIFyc208SWo43VD3MtrIGXntluSy2MkQU=; b=O0PTV9wW1zzWis
	g6jv3q/MLdn1mcD+IuYwgiuAtk1gaLuKyb323DdVyuGscPHHZDpbbCrplvlJaizp+f0hAWhE6Qtj7
	3uo0KY9qxchcfQ0E5Rn+iIrDkHoHpxeJab0dUpeXkIBpQpVIjQXL8zhEuZ1Izxu61Oq4sGSdqVgFn
	qt/zd93u10mu1DDHknsl2pmXAUDNrQTfrc/ICNjwtSqvOMGQ4yOMmcYyovkY9eBecOqjHlLyqEIbn
	Ux43jyQ3sCx+FKxTfvzq7T40rLOL1dhy71xbdtEjzum7MSY/m9rvF8C42YmbLhKOCHYlFxkxmXEQy
	XcOBpa5Neudo2xGwWRtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJbr9-000Myk-2M;
	Wed, 12 Jul 2023 15:34:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJbr6-000Mxe-1W
	for linux-um@lists.infradead.org;
	Wed, 12 Jul 2023 15:34:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 91D756182A;
	Wed, 12 Jul 2023 15:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECC1C433C8;
	Wed, 12 Jul 2023 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689176055;
	bh=6oEiutwftI2H8nspsyS0yrH2Djeg/+ZfO4scNbLQ3IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gei2LgMyiqJghONsgzoyfDl4HtLi7rUmCOYicVWqiUHEaEoIiRNLo5rScwVM6oNR9
	 2h8u7j8jt+GphzC/0Pu74OBHptH4nHlKAHNUq46M6yTPdyLsKD1r+eo7VO4mI4cJT0
	 VPwrSE/aFLC1T0TFbSyjhXvxtAZnQ/J8DvXi9kR5gRdmDbra1JqrsWCcKvioxRUwyH
	 SPnhWMlKXN8v0V8bZIBtJqB3WRiWqA3xzeMlJ9mMzhBTm0j9dBOv+NPrRUhq+JvzsT
	 u6JtBNSRxwnkGZoIMgjE5/NUPY2AMFBE8dpYpQ8S7THTMWLzBvdgMWuVOy0g9l8btU
	 mjzbtW+BaSE/A==
Date: Wed, 12 Jul 2023 17:34:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
	linux-um <linux-um@lists.infradead.org>
Subject: Re: [PATCH 01/79] fs: add ctime accessors infrastructure
Message-ID: <20230712-ehevertrag-betonen-ebf69808de1b@brauner>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144507.55591-2-jlayton@kernel.org>
 <03e153ce-328b-f279-2a40-4074bea2bc8f@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <03e153ce-328b-f279-2a40-4074bea2bc8f@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_083416_565003_E54FC852 
X-CRM114-Status: UNSURE (   9.47  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Wed, Jul 12, 2023 at 08:31:55AM -0700, Randy Dunlap wrote:
> Hi Jeff,
> 
> On arch/um/, (subarch i386 or x86_64), hostfs build fails with:
> 
> ../fs/hostfs/hostfs_kern.c:520:36: error: incompatible type for arg
> ument 2 of 'inode_set_ctime_to_ts'
> ../include/linux/fs.h:1499:73: note: expected 'struct timespec64' b
> ut argument is of type 'const struct hostfs_timespec *'

Thanks for notifying us! We fixed this earlier today. The vfs.ctime
branch has been updated with the fix folded into the hostfs patch.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
