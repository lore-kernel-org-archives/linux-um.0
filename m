Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DAFC4345F
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 07:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L4OcFr6Wq5nOJsUOvDaAmjOCMS9WVXFUfLPu4Nn2G+0=; b=koNodVc4H3GPXfbiAjIA4oOT0A
	Ux30qg34BZKVZUvA1enAaBCOUDpBOnLvrHC1oHcSg45by/01lblGOe/gEDxs4VFP5YsR6TtgNaVG+
	Lyh8F0Q1Ojn77LxhqB/Dw2nxyE+k8s2L8X7uGJwk36fuDa5/0cfaWzYiW4GUxvvSX+tnwmi8guC7t
	iM+bP/zSza26dvSNjomRYfzOkuViWu5eb0puY0bj7rZsb6pPyhItu4aCAjMXKpvB9jfsoppE1r4ko
	dKi9QsLYSc2ad82b65uCl8EWOMHRT61UUbnvqQk1YUatI6z88dKQyr7NPC1XrCMINShpUXFqmswdw
	hDudtbJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzAUj-0000000GG7G-2Qoy;
	Tue, 23 Apr 2024 07:23:13 +0000
Received: from frasgout13.his.huawei.com ([14.137.139.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzAUg-0000000GG4b-1zoQ
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 07:23:12 +0000
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VNtSk6cnkz9xFGQ
	for <linux-um@lists.infradead.org>; Tue, 23 Apr 2024 15:06:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A46E4140489
	for <linux-um@lists.infradead.org>; Tue, 23 Apr 2024 15:22:42 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LBW6YSdmcLXMBg--.38603S2;
	Tue, 23 Apr 2024 08:22:42 +0100 (CET)
Message-ID: <15d5da65079d072856ef5e8d88040df2095bb6b7.camel@huaweicloud.com>
Subject: Re: [PATCH] um: Add winch to winch_handlers before registering
 winch IRQ
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Tue, 23 Apr 2024 09:22:31 +0200
In-Reply-To: <1743ad022502d64042fa7db4d847a988bb90cbdc.camel@sipsolutions.net>
References: <20240307104926.3531358-1-roberto.sassu@huaweicloud.com>
	 <1743ad022502d64042fa7db4d847a988bb90cbdc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: LxC2BwA3LBW6YSdmcLXMBg--.38603S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4UKF47ur4rCryrJF43ZFb_yoW3JFgEgr
	4vk34fG3yDJrs2krs0k34qvr4vga18Kr13JwsIqrW3X34DurZ3JrWSyr9Yvw15G3W5JFZx
	GrZIgF9agr17CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbOkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5iypgABs4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_002310_797979_AD02D23F 
X-CRM114-Status: UNSURE (   9.59  )
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

On Thu, 2024-03-28 at 09:25 +0100, Johannes Berg wrote:
> On Thu, 2024-03-07 at 11:49 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Registering a winch IRQ is racy, an interrupt may occur before the winc=
h is
> > added to the winch_handlers list.
> >=20
> > If that happens, register_winch_irq() adds to that list a winch that is
> > scheduled to be (or has already been) freed, causing a panic later in
> > winch_cleanup().
> >=20
> > Avoid the race by adding the winch to the winch_handlers list before
> > registering the IRQ, and rolling back if um_request_irq() fails.
> >=20
>=20
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thank you! Richard, are you going to pick this up?

Thanks

Roberto


