Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE53C3600C
	for <linux-um@archiver.kernel.org>; Tue,  8 Apr 2025 04:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xc3RQHbbWhjaENeV54tCo3uz4MbXYhwQLPGC2Mc716Q=; b=SQ9IFWCtgIx8VbE81JR6sagbHK
	8RxX2M3jPfZ8TBOP2p0PUtvqfV+zOclzroGjMHtdiv/zrjSMj8GOOrFgXif9Sxum4IZkcPnwiHP8f
	InF81MzzH1XkkiSDddmQwEX1qbbZPFKatXAYjNevyuTTSGWkBt9aKibt2/GDN8GDRx44iramv77Mw
	wcnQXNM9mOCCqGATEiha/ngoRNG251Kj+tPEx0xeSDCbCP2QM6z7FVIhwWiq3qrJ4gs7+PqGgdqNm
	qfYvYflpiLfJpvBYT0om8cw33hEfdmuec8m1Vgq46Ua3CsQchR9xtF4U8EwjGcHSxqHwwI+IJfuKO
	p5nK1MDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20j6-00000002hml-1Ua1;
	Tue, 08 Apr 2025 04:38:20 +0000
Received: from out0-222.mail.aliyun.com ([140.205.0.222])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u20j3-00000002hly-3Ljy
	for linux-um@lists.infradead.org;
	Tue, 08 Apr 2025 04:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1744087095; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xc3RQHbbWhjaENeV54tCo3uz4MbXYhwQLPGC2Mc716Q=;
	b=Amw6OeYOXQE2rUfENOatiHCJFpshqP+q2LRiVnHX2qsMJAr/lMDyDOJoCi9IdNpiUZxzbQUJC0qrQqBsJS5tLHZrp26hgfavk1dBfJR80CZSjaxYc8gTlpjpQ/fwqq2pOuF8voj1OQPzB7I3MWRP1kuGerj3R+RkvXLLEtFMt6c=
Received: from 30.174.97.68(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cGd.uV9_1744087093 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 12:38:13 +0800
Message-ID: <621e867f-5427-4062-8783-e474e3dcdb3f@antgroup.com>
Date: Tue, 08 Apr 2025 12:38:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.13 23/28] um: Rewrite the sigio workaround based
 on epoll and tgkill
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 benjamin.berg@intel.com, linux-um@lists.infradead.org
References: <20250407181224.3180941-1-sashal@kernel.org>
 <20250407181224.3180941-23-sashal@kernel.org>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20250407181224.3180941-23-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_213818_037161_02E31003 
X-CRM114-Status: UNSURE (   7.53  )
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

On 2025/4/8 02:12, Sasha Levin wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> [ Upstream commit 33c9da5dfb18c2ff5a88d01aca2cf253cd0ac3bc ]
> 
> The existing sigio workaround implementation removes FDs from the
> poll when events are triggered, requiring users to re-add them via
> add_sigio_fd() after processing. This introduces a potential race
> condition between FD removal in write_sigio_thread() and next_poll
> update in __add_sigio_fd(), and is inefficient due to frequent FD
> removal and re-addition. Rewrite the implementation based on epoll
> and tgkill for improved efficiency and reliability.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> Link: https://patch.msgid.link/20250315161910.4082396-2-tiwei.btw@antgroup.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/um/drivers/random.c       |   2 +-
>  arch/um/drivers/rtc_user.c     |   2 +-
>  arch/um/include/shared/os.h    |   2 +-
>  arch/um/include/shared/sigio.h |   1 -
>  arch/um/kernel/sigio.c         |  26 ---
>  arch/um/os-Linux/sigio.c       | 330 +++++----------------------------
>  6 files changed, 47 insertions(+), 316 deletions(-)

Please drop this patch. Thanks! Details can be found here: 

https://lore.kernel.org/linux-um/ffa0b6af-523d-4e3e-9952-92f5b04b82b3@antgroup.com/

Regards,
Tiwei

