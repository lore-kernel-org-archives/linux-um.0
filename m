Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28868C3DA6E
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 09:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vbhqa7VI0MGZ+ApnVMFZMipyQIrdZYjzaekA4egbg+k=; b=mOcB4cCYmA4lrfzyoZQzLSJAx3
	FOUwhacz0oDyrS6irdDhD4hz6kRwIGHBl3BfJXCSgaSDJODriRDsHEGh/hkvxVL2jn3ZfksMEDvUU
	MGrC747FkzSE2VxN+PlIhHT+L2WxUiyAANehiDWmhHDDbPo8d95uSHucqfoA7aY+DaiY3AjWpWMDB
	MmboBkpsqJXz/CR6FlBklNA85xqAJZUZev4z66JEV2u5N5+xaLMADNSwsEwWbiE8xp3rWAzOPNZb7
	rE8S7AyE9poTyjBkP/z/rkRxJ7XZcX0NZvlkU9oNoppryze4TAw6Z/WKte63EZcEBxaYgQtoCQTSb
	OBhJXYGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLgK3-00GMMH-0P;
	Fri, 05 Jan 2024 09:16:59 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLgK1-00GMKS-08
	for linux-um@lists.infradead.org;
	Fri, 05 Jan 2024 09:16:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7F3A6626FAFE;
	Fri,  5 Jan 2024 10:16:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id d1VAXm4O0aey; Fri,  5 Jan 2024 10:16:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1172B6342D56;
	Fri,  5 Jan 2024 10:16:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x0hmMQvelink; Fri,  5 Jan 2024 10:16:54 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id DF5EE626FAFE;
	Fri,  5 Jan 2024 10:16:54 +0100 (CET)
Date: Fri, 5 Jan 2024 10:16:54 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, 
	Richard Weinberger <richard.weinberger@gmail.com>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <206862006.201007.1704446214699.JavaMail.zimbra@nod.at>
In-Reply-To: <29561023e97b362aa81aba2a33931897bea59bdd.camel@sipsolutions.net>
References: <20231110110348.1815612-1-benjamin@sipsolutions.net> <20231110110348.1815612-5-benjamin@sipsolutions.net> <CAFLxGvxads6JaAgm2MvXKKJrJiYGk1oLa2EDC0YLemcQ866cvg@mail.gmail.com> <a75fb1e3b92f748a81e032b5138e2cdccc4d2c92.camel@sipsolutions.net> <29561023e97b362aa81aba2a33931897bea59bdd.camel@sipsolutions.net>
Subject: Re: [PATCH v3 04/11] um: Don't use vfprintf() for os_info()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Don't use vfprintf() for os_info()
Thread-Index: BCwz3m5NB0JnF87AtTWXIEm3zWJElw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_011657_239181_357CF133 
X-CRM114-Status: GOOD (  10.55  )
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

----- Urspr=C3=BCngliche Mail -----
> Von: "Johannes Berg" <johannes@sipsolutions.net>
> An: "Benjamin Berg" <benjamin@sipsolutions.net>, "Richard Weinberger" <ri=
chard.weinberger@gmail.com>
> CC: "linux-um" <linux-um@lists.infradead.org>
> Gesendet: Freitag, 5. Januar 2024 09:56:11
> Betreff: Re: [PATCH v3 04/11] um: Don't use vfprintf() for os_info()

> On Fri, 2024-01-05 at 09:12 +0100, Benjamin Berg wrote:
>> > Another option is giving the helper threads more memory, we don't have
>> > that many.
>> > Did you explore this option already?
>>=20
>> I had not really considered that.
>>=20
>> One thing though is that userspace_tramp calls os_info while working
>> with the stub stack. So that also means setting STUB_DATA_PAGES to 2.
>> But, I suspect we may want to do that anyway eventually to fit the ever
>> increasing mcontext size for all the AVX512 registers and such.
>=20
> That'll probably happen eventually regardless ...
>=20
>> As I said, I think that is fine to do.
>=20
> But I'm not sure it's a good solution to give more stack space to the
> threads and think/hope that glibc won't make more assumptions about the
> amount of space it can use ... who knows if it uses alloca() inside
> somewhere, for example? After all, userspace stacks are multiple
> megabytes by default?

For thread stacks things are a bit different.

glibc is in general more heap than stack greedy, it uses malloc() almost ev=
erywhere.
For pthreads the minimal stack size on x86 is 16k (_SC_THREAD_STACK_MIN).
Donating four pages to each helper thread seems okay to me.
And if I understand _SC_THREAD_STACK_MIN correctly, this is the minimal sta=
ck
size the glibc library can deal with.

Thanks,
//richard

