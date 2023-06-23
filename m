Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D94FEB64D7
	for <linux-um@archiver.kernel.org>; Fri, 23 Jun 2023 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TeRq4HAAX9e3WEc3aMOqXV4dK0JiNYPd6t7QtrLS6G4=; b=K4ljwO650aW7Kx
	q0L7aJfXRM1SxExt90oKsUG3P5ICbywZrRL6XCoMJOeUxtDEaGp3g2uddri/r+A5oON8Fu3x7duqD
	9H5zFUPL8EgIKY8hVgjs/1CEaxmxqd8v0qbbywGs9NJ5E02RotZUoS4qp9n4Pe6macRDDQVtvTdJI
	1vlHIjAo+/G5Iz+eF2UCRo0RpYmI4N1qdeT/uglj4GMK/KYN3l8oFXvHSmIXecjcVsFBaaPe34rqB
	xpetm6gocnfJIo/G9LRkO5Km/PY3fQL4fEmeWccxPsg+i3vA1C4nYW9UWov2unogOlNjLympa2c+r
	3kTt69ooD4KxPSQ/v/rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCgPk-003bSH-1z;
	Fri, 23 Jun 2023 13:01:24 +0000
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCgPe-003bRP-2T
	for linux-um@lists.infradead.org;
	Fri, 23 Jun 2023 13:01:23 +0000
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1687525262; bh=/T2kcAhNkW+AjXltW63b942OOWOdxOT1SEFTFtiUekk=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 kgmR2ifSxZp8mqXUQFpUOxgzIgJuSfHaEC/57Un+7zTlwaFNzIMLuHvnU2Ao375k4lybhe2dSS4JSvxDiUoADg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1687525262; bh=/T2kcAhNkW+AjXltW63b942OOWOdxOT1SEFTFtiUekk=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 HjHSl/7wgK5OLlUY4ATDK6ZdlqAH6aYhDTS5mFRWltFX0z0xSELVPYFx9k0FJ/Y0K9DOtd9ClPXv/ma6g/wxAUmtWN0Yenka27VCaaCJKq2lzES0WUrILI0GxKH9TdyzCls6o9WQIlpo/W1NKc03tMirB6HZ8lbdPu4Jg3LrIpg=
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 23 Jun 2023 13:01:01 GMT
Received: from [139.30.201.15] (139.30.201.15) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 23 Jun
 2023 15:01:00 +0200
Message-ID: <6d5b75a6-38e2-05ce-988c-0f568999baa6@uni-rostock.de>
Date: Fri, 23 Jun 2023 15:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: UML for arm64
Content-Language: de-DE
To: Rob Herring <robh@kernel.org>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>
References: <20230622192247.GA2278576-robh@kernel.org>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <20230622192247.GA2278576-robh@kernel.org>
X-Originating-IP: [139.30.201.15]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: A2679A518A00E07C66EB7E07888215A994CC9840B7F0039F3BF716F886E9F0E92000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230623_060122_090292_2C19FCF8 
X-CRM114-Status: UNSURE (   5.78  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

> Hi all,
> 
> I'm interested in getting UML working on Arm. Is anyone aware of any
> efforts to do this already? I've not found anything searching around. Or
> perhaps a port to any other arch as I'd imagine any 2nd arch will
> require some refactorin
I am also quite interested in such a port. We may help with some testing 
or even more, if it fits my schedule.

 From my longer digging in the code, I can only confirm, that several 
parts are primarily thought from x86-ISA standpoint and already the 
switch to amd64 is flimsy at some places.


> Thanks,
> Rob
> 
Regards

Benjamin


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
