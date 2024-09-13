Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80247EEE26C
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LXzuQGmcfh9SClYXQxZ5FifdldC8/1JSnY5zGDvdfKU=; b=V4kOougvKjzeWsQHEINb6xmiVR
	BXy8w0eshK2t5eB7rXPBrL0wMxMFxdUkC0ad8gyggULluBn65qMj1A4pewv3eWae45gcvAPtIwBe9
	gPgqLwfCOVYOeweJ+3b98ZZ4OPnH5YQX+uicB5KKlgLJGd+UEorPtQbdIiE0Jvyksq3z5eizOl28E
	wFyHn9/ObcCKJINUpvQAHJzdylUVturZhSFlpO+BdI/o6cTpzQ/7v6YvI8Ml3OCG4g7eMALc6ZHdr
	JK5gsENaYrEV4FU5Rl99YCrvDDODYQnIOyg+FfOj+6rjvIAtw3wMbGs56lRJzZrIMLabTut8suDxx
	Yr41YHOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp5Tt-0000000FuUS-3aOJ;
	Fri, 13 Sep 2024 12:32:57 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp5Tq-0000000FuU2-2tbF
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 12:32:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CAFF563CF3E6;
	Fri, 13 Sep 2024 14:32:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id YSLA5HHOka5I; Fri, 13 Sep 2024 14:32:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6B83F63CF3E8;
	Fri, 13 Sep 2024 14:32:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SlEUMxc2_6je; Fri, 13 Sep 2024 14:32:52 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4D72363CF3E6;
	Fri, 13 Sep 2024 14:32:52 +0200 (CEST)
Date: Fri, 13 Sep 2024 14:32:52 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um <linux-um@lists.infradead.org>
Message-ID: <1595083657.40577.1726230772198.JavaMail.zimbra@nod.at>
In-Reply-To: <40c069b41bb0c50105acd462b4e0950ac14ff248.camel@sipsolutions.net>
References: <20240830153825.1466691-1-benjamin@sipsolutions.net> <CAFLxGvxPM9x9ay7+7Sv4wwPFKM9keZGfy9C2=5Cbk-_BUf88gQ@mail.gmail.com> <0675ab7f16dc0b8f02e4c162f2e42fb66046feed.camel@sipsolutions.net> <1283369340.40411.1726228031802.JavaMail.zimbra@nod.at> <40c069b41bb0c50105acd462b4e0950ac14ff248.camel@sipsolutions.net>
Subject: Re: [PATCH] um: add RCU syscall hack for time-travel
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Topic: add RCU syscall hack for time-travel
Thread-Index: YqvigdwiT+6+NtieR2GmyBUF9AILQg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_053255_038539_A582D3D6 
X-CRM114-Status: GOOD (  24.92  )
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

Hi!

----- Urspr=C3=BCngliche Mail -----
> Von: "Benjamin Berg" <benjamin@sipsolutions.net>
> First, it doesn't seem like my patch actually works, so please do not
> merge it. It actually appears that tree RCU and tiny RCU (which are
> selected depending on the preemption setting) are behaving differently.
>=20
> So now I am wondering if I can come up with a hack that works for both.

Ok!
=20
> On Fri, 2024-09-13 at 13:47 +0200, Richard Weinberger wrote:
>> ----- Urspr=C3=BCngliche Mail -----
>> > Von: "Benjamin Berg" <benjamin@sipsolutions.net>
>> > > While I acknowledge that time-travel itself is a beautiful hack, I'd
>> > > like to keep the hacks
>> > > to keep it working minimal.
>> > > So, the problem here is that RCU callbacks never run and just pile u=
p?
>> >=20
>> > Yes. A simple example of this is doing a "find /". This will allocate =
a
>> > lot of inode information which is only free'ed at a later point.
>> >=20
>> > > I wonder why such a situation does not happen in a nohz_full setup o=
n
>> > > regular systems.
>> >=20
>> > Had to search for a bit. But, I think the boot CPU will still have a
>> > tick even on a NOHZ_FULL setup. see the nohz_full=3D boot parameter.
>> >=20
>> > It does look like the RCU code might try to force scheduling (tiny RCU=
)
>> > or wake up a worker (tree RCU) in these situations. But neither of
>> > these attempts is going to fix the situation as there will be no call
>> > to rcu_sched_clock_irq with time-travel.
>>=20
>> Agreed. I think having a house keeping CPU (thread) will not work in
>> time-travel mode.
>> Kicking RCU whenever a syscall is executed is okay, the question is,
>> are there other scenarios where RCU work can pile up and no syscall is
>> run for a long time? Maybe we need to kick it at other places (page faul=
t
>> handler?)
>> too.
>=20
> Hmm, that is good question. I assume that implies major faults for
> mapped files (or anonymous memory from swap) happening. I suppose, that
> can trigger just about anything in the kernel and could also create
> load on the RCU. Not sure how problematic that is, in our case it was
> python importing a large amount of files and bringing the system to its
> knees in the process.

I had also workloads like heavy network processing without userspace
interaction in mind.
=20
> Anyway, I'll need to reconsider the hack a bit, maybe we can find a
> better solution.

We can also add RCU folks into the loop. But I guess they need a good
introduction first what time-traveling is. :-D

Thanks,
//richard

