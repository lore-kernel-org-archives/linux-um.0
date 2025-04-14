Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE049C369B2
	for <linux-um@archiver.kernel.org>; Mon, 14 Apr 2025 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pJ/36NqTPbfU92mLQwOP/jkuDkZAtiM1YNatxAkLpzM=; b=pwsDL+AVZJMrNgC5dTL3W2LpcD
	cFzwuaohqKzkTFwdJDwNpGMwGrPcgZoxInF651q+otu8QmY+irSo/aMSWIEFBYqV2ipz+T55mBB18
	ichfCjrfcsT8bQ4L3sp21SJYmnmXJyU+QRrVaC/W6H5ux83FgHqeSBDmuRZ2xII9u0v6YmOLzVgUI
	hKPhRBbSBMn8w4xKzGqZkNpPGFvQTnM0VGJI80+Km0YuXV3tH7YNILgV8BtPRTFq93rfz8dvPpHSK
	8iOVS86xhKFDCUoJLZ26Ch7/GzHYaCTMNpC6vXYdT0H1SOMnvyTDTO8K6cLUskUvTQxwp5Rqni4Nh
	7pblcakw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4OQo-000000035BH-0QBy;
	Mon, 14 Apr 2025 18:21:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4OJL-000000033gh-3hXy
	for linux-um@bombadil.infradead.org;
	Mon, 14 Apr 2025 18:13:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=pJ/36NqTPbfU92mLQwOP/jkuDkZAtiM1YNatxAkLpzM=; b=dzSCGL7Szdc4KTgwrVRHBaxS1o
	rmMPX72z2Ph1B/x7b58EZ8ngWIX7cDyHRa2SzdR6nC1hFOGQos/44y06FY15vd6wQOjgV3fxmkKGk
	bYkr5YqOOi9ozHs+wO+ebA701S7p3okKaysfZNzy995LOWjl9Po3U5AEkQZbgsnxSDhL3lG2cjwRm
	icivkRnnb3njIZfaOgCUPyqD9UVkMc+AmwUaJHXz3a2P+69LVF5Ms6c4TqTpWrZc+CK6U5qaKV1Ik
	9dDL4QsuwH3bKJ1dDYJMXvBrJkyB4qotRKmYjTE+bE4Lj/zzr5ItI4sLJDnGBbNsy6QoRtJtsrVbj
	GGRmHmDw==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4OIc-0000000DFZe-15DV;
	Mon, 14 Apr 2025 18:12:51 +0000
Message-ID: <8d70668e-fd0e-4cd5-b33f-16f3250b90b8@infradead.org>
Date: Mon, 14 Apr 2025 11:12:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Apr 14 (UML [2])
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-um@lists.infradead.org
References: <20250414171511.6c7c80af@canb.auug.org.au>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250414171511.6c7c80af@canb.auug.org.au>
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



On 4/14/25 12:15 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20250411:
> 


on i386 defconfig:

../arch/um/kernel/um_arch.c:480:6: warning: no previous prototype for 'text_poke_sync' [-Wmissing-prototypes]
  480 | void text_poke_sync(void)
      |      ^~~~~~~~~~~~~~


on x86_64 defconfig:

../arch/um/kernel/um_arch.c:480:6: warning: no previous prototype for 'text_poke_sync' [-Wmissing-prototypes]
  480 | void text_poke_sync(void)
      |      ^~~~~~~~~~~~~~
/usr/lib64/gcc/x86_64-suse-linux/14/../../../../x86_64-suse-linux/bin/ld: arch/x86/kernel/module.o: in function `write_relocate_add':
/home/rdunlap/lnx/next/linux-next-20250414/UM64/arch/x86/um/../kernel/module.c:209:(.text+0x1e7): undefined reference to `smp_text_poke_sync_each_cpu'


-- 
~Randy


