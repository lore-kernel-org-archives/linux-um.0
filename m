Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D36C3ABAA
	for <linux-um@archiver.kernel.org>; Mon,  5 May 2025 14:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hmzNdEudKbymXmk5SBtfM0m83H4882rPceG9NmAYYGM=; b=gHd3DwlXrqEJ0Cchlf3bVE9XRR
	F1UGE1vMpAw1+1gzw8EGzQXLdUfM+70HEiijq2Gf/griCdtK9NfXVgX8FELWUsFDfrgxUsYE9MjWy
	1ZjcbR5lUOBNuwb3bLlUYAV+4gYZnwLgr1t4ebXolgwZ+PHqxwAabdlk1uY4+acTE8LIC/bDVj0xE
	vVfaaBoWsGXKWViHR2v5TmDV6kEPQTCOZMN8W/QYfbsVcryWM4Qouz2qXkuN3bkGCgGM6oqyQ2vGI
	+GvZiSewXw2xXF60foo8S4EzTOXNlez1T7uMSTnh8NvPGFvJv122jEHKzz3FGpn2jadAQnlqZaGpW
	9mVFEEgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwRs-00000007Z9k-0Dyb;
	Mon, 05 May 2025 14:05:36 +0000
Received: from out0-222.mail.aliyun.com ([140.205.0.222])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBwQH-00000007Z1C-1srj
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 14:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1746453834; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hmzNdEudKbymXmk5SBtfM0m83H4882rPceG9NmAYYGM=;
	b=nEseUK6JVvxfJnRy2D2XDXoCDLc5BnCnDyG2J9wxJz8qyAN86++UE4tudYCixfUr0Yw9ATA/o+6LWt+jkbhwbOL8tfGgY5I9J1gZ6RNRVeWvYZ61UVWxgVk26j6Oxx1hL+g8emOyyeFo3AOz5R6dTUsCRR2Xq/qFLIzl2Nhjvjc=
Received: from 30.174.84.188(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cf6hGnQ_1746453831 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 05 May 2025 22:03:51 +0800
Message-ID: <bfa07f4d-16a3-476b-9314-b8052ec198b1@antgroup.com>
Date: Mon, 05 May 2025 22:03:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] um: Remove legacy network transport support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, linux-um@lists.infradead.org
References: <20250503051710.3286595-1-tiwei.btw@antgroup.com>
 <CAMuHMdUhWUhHczDG4ihB0cgUG9TTMo6Naszw6oogROnRCrOmKA@mail.gmail.com>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <CAMuHMdUhWUhHczDG4ihB0cgUG9TTMo6Naszw6oogROnRCrOmKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_070357_654783_2EAEFA61 
X-CRM114-Status: GOOD (  12.39  )
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

Hi Geert,

On 2025/5/5 17:20, Geert Uytterhoeven wrote:
> Hi Tiwei,
> 
> On Sat, 3 May 2025 at 07:17, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
>> Tiwei Bie (3):
>>   um: Remove obsolete legacy network transports
>>   um: vector: Eliminate the dependency on uml_net
>>   um: Remove legacy network transport infrastructure
> 
> Thanks for your series!
> 
>>  arch/um/drivers/slirp_kern.c                  | 120 ---
>>  arch/um/drivers/slirp_user.c                  | 124 ---
> 
> It's been a while I used UML, but slirp is what allowed me to run
> UML on a machine at work where I only had normal user access, and do
> root-only things like running Wireshark (then called Ethereal ;-), and
> install and run apps that were not available on the physical machine.
> Do the newer networking options support using networking on a machine
> where you do not have root access?

Yeah, transport like vde supports using networking without root access:

(on host) $ ./linux vec0:transport=vde,vnl=slirp:// ...

(in uml) $ dhclient vec0

PS. I set up vde by installing vdeplug and libvdeplug-slirp on debian 12.

Regards,
Tiwei

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


