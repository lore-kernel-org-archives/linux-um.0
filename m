Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3614CE7A87
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+oIrtPirruwd3DN/F68TYDjnNfOMS0VawLNlcGHnIhM=; b=GbR6O7qhkslvwZ
	XSpox811iKbeLfNU91vaPtvuecoJl+8CVbKct20dQUPltsd6PyQsyRHPZrD6GEHciC9hX2CXIhPEh
	ckoeTJbJdSi4PtKailk3+pRZ93Lq4mntgC4CcDNx9/BxdRl2hd+2WQjjDHgvOXzqZrjhBzjQosSM6
	hwX5NCHir9K6r/rZ0vyGjfBiCS7c5DXmXknK0s7wSM4OpBtpvjBT5HZXE055r5JgvQZlejiVVgXwr
	NVLt6RuNd3IRb1L8DA8iMu5IjCTFXEdgu87EoBNai5k52gJ4MlF08q/p1s63ln3HLo0Fx44hTk2jh
	zoJ0DoUuUw5jkor/mlgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjmWE-009lk7-2d;
	Fri, 22 Sep 2023 20:12:54 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjmWB-009lit-0e
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 20:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AjWvbQDfS+toeeD7xcRNuhoejy4gVQV1ZqHgWeWK0Nk=;
	t=1695413569; x=1696623169; b=TwXgKbFNkkKO7JSmqHZ9Isige0P+aEcDActmwhwWoBUMAUw
	r1KyxVyqjbYHR4SFE5Lv1vPbjrZ3fjFFMu9LgtJWVqbMTGw86n0R9iKxHRJKBr+y13AQ3r5/TOYK+
	ukD557DcpDB8V0XLU4sUPi3G+PAX+NVM0cufA02pWAhFyAQ6OEHplgsx0XRAiGb9pX15KcJrYKQRM
	fjjHLt8o0kKe1V8GQlgJcvF90tPvQr0ixSQ48aVm1u+W0P4x2yIPIVUrAEo+zxXgRE4AuTSWXJjmO
	YNfLwSWz0XZPMG3yB/1pzblK9Fwq9ONtmJU0HKsat4aufLX0ZawE1hH0J0/VYutA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjmW7-00Fjor-11;
	Fri, 22 Sep 2023 22:12:47 +0200
Message-ID: <6bc1a06d1b91b2badd388a4e13d467ed4eace651.camel@sipsolutions.net>
Subject: Re: [PATCH] um: clean up mm creation
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Date: Fri, 22 Sep 2023 22:12:45 +0200
In-Reply-To: <9cc73695-b3c7-d194-72e9-9bde142c81f8@cambridgegreys.com>
References: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
	 <88e0568b-6860-9042-7f8b-ab53edb4242e@cambridgegreys.com>
	 <ce18cec1dbacb366f2cf74ebc941c9fbc4b1e116.camel@sipsolutions.net>
	 <9cc73695-b3c7-d194-72e9-9bde142c81f8@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_131251_261652_C46F8533 
X-CRM114-Status: GOOD (  14.73  )
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

On Fri, 2023-09-22 at 21:08 +0100, Anton Ivanov wrote:
> On 22/09/2023 20:41, Johannes Berg wrote:
> > On Fri, 2023-09-22 at 14:41 +0100, Anton Ivanov wrote:
> > > 
> > > It is nearly twice slower than the current approach on a find /usr -type f -exec cat {} > /dev/null \;
> > > 
> > 
> > Btw, I cannot reproduce that at all - seems about the same in my tests?
> > 
> > Is there anything special in your setup?
> > 
> > Or maybe it's because I'm using hostfs? But not sure why that would
> > matter.
> 
> I am using a ubd with ext4 sitting on an nfs server. The host, however, 
> has more than enough memory to cache all of it, so it is pretty much 
> like reading off a ramdisk as it is fully cached.
> 
> It is quite clear in that case.
> 

Did you have your preempt patch applied also, btw? Because I was working
off that now.

But even with PREEMPT turned off, I see basically no difference in such
a benchmark. I was running only over /usr/bin/ because otherwise it's
just too much time on my system overall, but there's basically no
difference in the 4x4 matrix of

 - preempt off / preempt voluntary
 - with / without my patch

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
