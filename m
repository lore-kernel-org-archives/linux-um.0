Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5C1C36008
	for <linux-um@archiver.kernel.org>; Wed, 26 Mar 2025 06:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/T3Kh+CI+OoKs7XO02rtBiBJMo6dFg/0JDjRmBnZNv4=; b=BcWNnAW98sGjRCHIY6Uz+5I2Kg
	M7M/odxanjiUHLt314MbZ1ZQ8ykpla8X/uAvucvmp5GEY/ti0XaLjEwZhcA1d2K/o2LExLaCZb7H4
	rR511Eh2lZBIZvTaiB+8QBGzgCzcYSfQGozDJDdDUmjjQqHfCxQHa4JoCPE9bdD1abcCO5MB4xzEX
	XNRFSI07MPOx+bStuariBp4jWCAVbLnqxgTsvC7k+G+XT6EreAsNu45PhF/Pi+PoLUn9IvGsSyZmx
	B7NzHpGJbLzUsGsqrc7/M1ppD4ry92rLJhwlIX4fGJlLciePbAsCa7zsIp9xU92tq4eW56tHzhwgn
	8xju4PwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKev-00000007hdc-1mJj;
	Wed, 26 Mar 2025 06:54:41 +0000
Received: from out0-220.mail.aliyun.com ([140.205.0.220])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKer-00000007hci-1c0x
	for linux-um@lists.infradead.org;
	Wed, 26 Mar 2025 06:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742972073; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/T3Kh+CI+OoKs7XO02rtBiBJMo6dFg/0JDjRmBnZNv4=;
	b=Gncy84mpepMRWxbWtVMfIsC6eBSt2HdIweRWAl2S/barircBHd96lKpF4rDDKv2PG14ftTSG4BRbbkdfZKe7XS76Y7ZzGgbhBHVF/iJQqpIuj5Uy2JAcTigQfsrpmEATlb6BuaIrYcLKXkboqgiIoN57ux2HXTSSn86JEtwuBwk=
Received: from 30.230.81.73(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.c3dNgJv_1742972067 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 26 Mar 2025 14:54:32 +0800
Message-ID: <22d09a9d-d00a-40ca-80e1-86fb07caa0a6@antgroup.com>
Date: Wed, 26 Mar 2025 14:54:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] um: Prohibit the VM_CLONE flag in
 run_helper_thread()
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
References: <20250319135523.97050-1-tiwei.btw@antgroup.com>
 <20250319135523.97050-5-tiwei.btw@antgroup.com>
 <495e4b66edcc65ba9630cf1bbbb119b971af2df6.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <495e4b66edcc65ba9630cf1bbbb119b971af2df6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_235437_886508_6B57CD0D 
X-CRM114-Status: UNSURE (   7.12  )
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

On 2025/3/20 16:32, Johannes Berg wrote:
> On Wed, 2025-03-19 at 21:55 +0800, Tiwei Bie wrote:
>> Directly creating helper threads with VM_CLONE using clone can
>> compromise the thread safety of errno. Since all these helper
>> threads have been converted to use os_run_helper_thread(), let's
>> prevent using this flag in run_helper_thread().
>>
> 
> I notice that now there's only one user left, the SIGWINCH handler,
> maybe we could change that too? Anyway not related to this patch, of
> course.

After taking a closer look, changing the SIGWINCH handler seems to
be tricky. It requires setting itself up as a session leader and
configuring the controlling terminal. So it seems that it can't be
turned into a real thread..

Regards,
Tiwei

