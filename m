Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6097CF3948
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 14:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQcNl5VqG8FXfCDTMle0wWvxDitPclvHkPGBMo8pUA4=; b=gHWWci8kLrUH0dr+JjCsUGIwGQ
	TAJLRplvR4Ej6BxVY/CwMzK5W7OZiJ+xh2N+x1jBAIVGVwX6T7CIsURtqBbkc823U28akj0K60BM5
	pCm3+OrAPUqS85LdmUawOyUQ6VlNTnuZNh8NZVU4Kd7LTeTEbrWghnfqj+3xLGM5QWjXfk9cv8Haq
	8JDvbCGSYgTpOTSMlXDZis1xn4QQXzdd9WFkWR5gFTOkv+0YS8tuVHOHOoomvo+EWl0zw1aw74khj
	Wl4RCwADbSgPT0RR7Efx7gM1AYiBRetZ3g0tnl4G+eYf3scrfqB7jGaIP5N5iND/b4hk0xepaZA1K
	F+1j4vRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srI6s-0000000AS0B-1cuI;
	Thu, 19 Sep 2024 14:26:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srI3k-0000000ARSU-2vgT
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 14:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=IQcNl5VqG8FXfCDTMle0wWvxDitPclvHkPGBMo8pUA4=;
	t=1726755783; x=1727965383; b=HL0C0couFNv49igd0/+jOQYlfrnn1rSFoIJJb9ej4NurGFt
	8MkAhhxPp1QEqkdWaK6Uj5dj1/dulgMrPa70s+DnMN2ndWUK/Dv8p7RBtrt7yCv5T1mGcoUdEdhr8
	B9fJ8JOJQoLlxPQJemNXh/n/gYqrCgg2sn3AZi9zxx6wVoiCioLO5tcLkLw6hqBiVnkb5skmFxhMs
	cmK0FloEGOdXSzf7Lwk8B9dCCU9yY3OlHWVYe4UpDaSWpkKL5O1iroJPgtALJKcXV5O6XYyTPJb8Y
	C6cJVicZrQXyzla7Qkf4oe/2drTSITr06xOtHJHfKuH7tZm/e3tCGP/Oi0NYMVYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srI3g-00000004Jj6-32QA;
	Thu, 19 Sep 2024 16:23:01 +0200
Message-ID: <b9e99c84ec953cc1459928c103fc4789eacce486.camel@sipsolutions.net>
Subject: Re: [PATCH] um: insert scheduler ticks when userspace does not yield
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, 
	linux-um@lists.infradead.org
Date: Thu, 19 Sep 2024 16:22:57 +0200
In-Reply-To: <3ea4c557-df8f-4312-84f6-8dc0b2c2a5f1@uni-rostock.de>
References: <20240913201756.1223327-1-benjamin@sipsolutions.net>
	 <3ea4c557-df8f-4312-84f6-8dc0b2c2a5f1@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_072304_766090_77F9BA2E 
X-CRM114-Status: GOOD (  20.75  )
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

Hi,

On Thu, 2024-09-19 at 16:11 +0200, Benjamin Beichler wrote:
> Could this also eliminate/address the busy-loop hack in timer_read in
> time.c?

Hmm, I was considering changing the other hack in handle_syscall to
also use this approach.

But, I don't think the timer_read hack can be removed. In the case of
userspace reading the time, it should not see the difference of the
sched_clock. So even though the process would start use CPU time, the
realtime clock should not change and python would continue to busyloop.

> And another question: Why you remove only 1 extra jiffy in the timer=20
> callbacks and not all the extra jiffies? Is there always only 1 or
> could there be multiple?

Oh, there we can absolutely end up inserting multiple jiffies. However,
deliver_alarm will cause "jiffies" to be incremented by one. So by
subtracting only one jiffie we can avoid a situation where sched_clock
moves backwards.

Benjamin

>=20
> regards
>=20
> Benjamin Beichler
>=20
> Am 13.09.2024 um 22:17 schrieb Benjamin Berg:
> > From: Benjamin Berg <benjamin.berg@intel.com>
> >=20
> > In time-travel mode userspace can do a lot of work without any time
> > passing. Unfortunately, this can result in OOM situations as the
> > RCU
> > core code will never be run.
> >=20
> > Work around this by keeping track of userspace processes that do
> > not
> > yield for a lot of operations. When this happens, insert a jiffie
> > into
> > the sched_clock clock to account time against the process and cause
> > the
> > bookkeeping to run.
> >=20
> > As sched_clock is used for tracing, it is useful to keep it in sync
> > between the different VMs. As such, try to remove added ticks again
> > when
> > the actual clock ticks.
>=20


