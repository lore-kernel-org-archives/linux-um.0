Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848BFC4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bgOjHbjf57JodzRiqE47Tkd7OrS5VRxBiRcvrOt7E5M=; b=Lk5kWEZSxnTP0G
	68vBuKPR3H8BqpgKx7TBEoR3Y+mVkbztlrNmK7fMPK2nrp5hzihyyJDSxR2aeAWCAE+LmEpkKB8kf
	ljPg5pet8WMVDG4cFUdAMR+l/gwrAGDnycYN2tCsfAbtl7OtBpKkuv9L9qUiGgICtdjAFjfo+BU4+
	NDQRz7mWpfQHwv1SM6aHam8tm4QMxsY8V38h8r5iZ/9cfMfkZQjhGTLTkAGouFQ0PmmUccGmsC/ON
	Qw7YbOIMuRlg74xsR/9f9TC+Uk2KUULuW4TCqHmTBoH8cSr4qCdF/w2OL5r21YAgOFSLtZqoAsDTU
	BtqNB0ONq17gA+SQ3UTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1V7i-0097kA-0i;
	Fri, 10 Nov 2023 17:16:50 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1V7f-0097jq-1t
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 17:16:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JUKnaVFPsM8FzBqLBhjTtC1UoYH8lYjc+1O1rDqd284=;
	t=1699636605; x=1700846205; b=wGM9RA5emDs0N5ekrVMLA41h9H4g8I8yCCK3nfV3dih9yaE
	CyMOUEuePwL4MmLEfkbA0j+MI+Y1oye92GltI0XeRFhO2WBX2Jnk2ENIwo2oesBuuSDS2Wcgn7pNU
	htziCgk4+Rpofj+Vzv23y6TkhHn4hOqTtzueGhpwT6OL6dxTvPpOqq4BkBiOjA65v4Cs0nLPqnQtm
	f6EDy6CtjrRW+lX1QURPcJrL3k+qtSMUbpXzWPjPlIBzAx/OOau5prmx+SU5Jd0FaFTe5Usj5qqN4
	z+KjkOudQqUpWdpEiQp4yk2jn3nF3mSdfeHjwfrZyWhjIJMCko14MnfQ/bEsJpdQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1V7W-000000036YB-1TGX;
	Fri, 10 Nov 2023 18:16:38 +0100
Message-ID: <9d7509efed4292891b4ffbf063ae58f11af8b742.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 03/11] um: Use a simple time travel handler for line
 interrupts
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Fri, 10 Nov 2023 18:16:37 +0100
In-Reply-To: <15d63c81-9e41-4965-b988-c4a934aecc52@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-3-e2c68efcf664@uni-rostock.de>
	 <71657ebd4a582b1a3c876de4d778ff67bd29c49d.camel@sipsolutions.net>
	 <15d63c81-9e41-4965-b988-c4a934aecc52@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_091648_149489_6434C4B0 
X-CRM114-Status: GOOD (  17.76  )
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

On Fri, 2023-11-10 at 17:53 +0100, Benjamin Beichler wrote:
> > 
> > At least in my mental model this is broken because the sender of the
> > event basically has to prepare the calendar for it happening, which
> > feels ... odd.

> Actually, for me, this would make kind of sense.

I'm not sure I agree, I guess. To me, the sender is just telling someone
else "here's something going on I want you to look at". That doesn't
really mean the receiver needs to actually handle it "right away". Maybe
the receiver implements a model where it's modelling an interrupt
latency (which _would_ be more realistic), so it only handles the
message some (small amount of) time later. Maybe it's in a polling model
right now and has disabled interrupt sources, and just wakes every so
often to check for messages. Maybe something else.

So I don't really agree that baking a "must be scheduled immediately"
into any protocol really makes sense.

> Why couldn't we be more 
> explicit in the time travel protocol to the calendar about interrupts?
> We could use the ID from the start-msg to identify um instances and 
> tell, in an additional msg, that we are going to trigger an interrupt at 
> the current time to that instance from the device simulation.

But see above - I basically just don't think the sender of the event is
the right position to know that information.

> Another way would be, to serve such information (if the device 
> simulation really need it) over the facilities we already established. 
> Why not send the ACK as MSG_OOB or ancillary data?

Don't think I understand that. Which "facilities" are you referring to
here?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
