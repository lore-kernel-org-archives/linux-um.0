Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12A9C4332F
	for <linux-um@archiver.kernel.org>; Mon, 13 Nov 2023 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Prc72FfUEXYeuSvBkaU9Nf3qRn/cDPgOdTM0LbsfIyI=; b=IHLv9R+sfBIyzB
	PqUoKEulVZ2Pj2nexzp4WZzbp586UR751hKsZyetf0JjquOVsntF+cjB+JpkPQVdzlgyUjOOqpfK3
	eutanXEAIjVGFyl73/nVXTg5Grz4206BM1NtiaiimnoeDVO89DD+GXGUV/nUWYPJZZVsR/b4ZlWkJ
	KU8ivgX1MQzvE7NcfJLNa+DpLMAll0df1dtNM/A9nGuDJLH3ACsTNqAZzT3kECebv87twT7qPfchT
	Ds+/R/tXzexu5/m0RoQ9OKihHH4LIU03yf5A4Qwzt+hjBBFTOxDCXunp1egE65IBu4xvx9fNn5JWA
	dLtKXdjLr0eRvZNQJzsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2VOk-00DlF6-0j;
	Mon, 13 Nov 2023 11:46:34 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2VOf-00DlEk-2q
	for linux-um@lists.infradead.org;
	Mon, 13 Nov 2023 11:46:32 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Mon, 13 Nov 2023 11:46:17 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699875977; bh=/prO9K2nlxADNXyBHI/QTCslbs/zLpwiVgAnjxoJsQY=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 20e5Q2Un7ZNHkHsf4/0J0bLszx2A1GqqesZrcH2inBCj7eGJMwL3SrDVKHhKXS8aSKW/xWVeHcsmOJ1YMCtCBA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699875977; bh=/prO9K2nlxADNXyBHI/QTCslbs/zLpwiVgAnjxoJsQY=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 M73NIEk/upP67Wtn60NbC9q5PRkDlRxOAFD83ndH7xcMRtEE962vl2wsda0BJldcC3TboGzHq9O+aUgREqviUHqU4SfkgzBs4XxvDcjjz8p8m5qR82vy6byxY9mYOfvjAAYPEqSU9bHYADDtU7n8bpivzuT/DD7WBTAlLmT0ynk=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 13 Nov
 2023 12:46:16 +0100
Message-ID: <c83d1520-277f-45a9-beff-3c65e63dfc7c@uni-rostock.de>
Date: Mon, 13 Nov 2023 12:46:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/11] um: Use a simple time travel handler for line
 interrupts
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger
	<richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC: <linux-um@lists.infradead.org>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
 <20231103-bb-timetravel-patches-v1-3-e2c68efcf664@uni-rostock.de>
 <71657ebd4a582b1a3c876de4d778ff67bd29c49d.camel@sipsolutions.net>
 <15d63c81-9e41-4965-b988-c4a934aecc52@uni-rostock.de>
 <9d7509efed4292891b4ffbf063ae58f11af8b742.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <9d7509efed4292891b4ffbf063ae58f11af8b742.camel@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: D39EBCE48F6B649B89CC6D502B50D4E8D7025E4CA190C43F237FB3D2DF467FE42000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231113_034630_845329_348316F6 
X-CRM114-Status: GOOD (  27.37  )
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

Am 10.11.2023 um 18:16 schrieb Johannes Berg:
> ________________________________
>
> On Fri, 2023-11-10 at 17:53 +0100, Benjamin Beichler wrote:
>>> At least in my mental model this is broken because the sender of the
>>> event basically has to prepare the calendar for it happening, which
>>> feels ... odd.
>> Actually, for me, this would make kind of sense.
> I'm not sure I agree, I guess. To me, the sender is just telling someone
> else "here's something going on I want you to look at". That doesn't
> really mean the receiver needs to actually handle it "right away". Maybe
> the receiver implements a model where it's modelling an interrupt
> latency (which _would_ be more realistic), so it only handles the
> message some (small amount of) time later. Maybe it's in a polling model
> right now and has disabled interrupt sources, and just wakes every so
> often to check for messages. Maybe something else.
>
> So I don't really agree that baking a "must be scheduled immediately"
> into any protocol really makes sense.
I think you are mixing here some levels of abstraction. Some entity in 
the "system" needs to
react to an interrupt immediately. In the real world, this is mostly 
done by some kind of interrupt controller
which may latch the interrupt (if they are deactivated from CPU side). 
Of course some more sophisticated
bus protocols (i.e. virtio/vhost in this case) can also signal the 
device to do no interrupts, but in the most
basic case, e.g. a button at a GPIO pin, the device could not handle 
that. Most of the interrupt abstraction
in um is realized via signals, but some more seems (IMHO) to be needed 
from the tt-protocol, if we have external
device simulations. My suggestion was to add the virtual interrupt line 
state change as a message to the calendar.

Of course, you could argue, that the device simulation needs to be 
clever enough (so distributing this task of the
interrupt controller), but even therefore the device simulation need 
some more information to reflect delayed interrupts,
deactivated interrupts and so on.

What confuses me is, that you explicitly use the immediate synchronous 
response model on the interrupts from the vhost/virtio
driver, but you seem to refuse this on other drivers.
>
>> Why couldn't we be more
>> explicit in the time travel protocol to the calendar about interrupts?
>> We could use the ID from the start-msg to identify um instances and
>> tell, in an additional msg, that we are going to trigger an interrupt at
>> the current time to that instance from the device simulation.
> But see above - I basically just don't think the sender of the event is
> the right position to know that information.
Mhh if I apply that to the vhost/virtio simulations, that is, what is 
implicitly modeled by
the exchanged file descriptors and vhost/virtio protocol state.

We may change the whole tt-ext-mode to only accept vhost/virtio drivers, 
but that needs to
be stated explicitly in the documentation. I'm not really in favor of 
that, but if it is documented
it is easier to understand.
>
>> Another way would be, to serve such information (if the device
>> simulation really need it) over the facilities we already established.
>> Why not send the ACK as MSG_OOB or ancillary data?
> Don't think I understand that. Which "facilities" are you referring to
> here?
I hadn't researched that on Friday, but we could use a custom control 
msg (cmsg) on the unix sockets
attached to the (serial) line devices. The device simulation can then 
wait on that ancillary data for
synchronous interrupt handling, as you have proposed for vhost/virtio. 
My first idea was to use
MSG_OOB, which do not exit on Unix-Domain-Sockets. If someone does not 
use uds as transport
we may give a warning.


Benjamin



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
