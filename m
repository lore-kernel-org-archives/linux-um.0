Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2B2CE79C4
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fMEOtJG6/2Cv60iM32GzDFU4WCaFKjuB9vw1NwhFIAs=; b=OPoE1JWUwAej2M
	vLuYZRcKS4arGC0whWkSwNQG16SuXVh4PRCbCo0oQnUGulrPV0Q5PVY3zXa237LecFaF3oIy0R0Qk
	o1A7aDa7L3wdFBWdqm62LkD/CSkujbzyrhlGBhJEsA3iqapDbbhwfD6FeFALCo1kIfQkeNAI0CX74
	JqgShkCtThTfyymQrwluOeakxp8jZS00fv9mQJQp72OqpxfXPLSFebp/QckrhIzHUTIBLYgL628rl
	NnqZ23DO1OwDZIX4/sT59JJ+inNEhnUCfHK6/QxXWVJrqYF27XkU35PGHfmr7cYqXVrvC4J3oMxKY
	eFh38/OeX78Cj7YdatXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiuam-002eDS-04;
	Wed, 20 Sep 2023 10:38:00 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiuaj-002eBy-1p
	for linux-um@lists.infradead.org;
	Wed, 20 Sep 2023 10:37:59 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-284-5wXb8dyyPl6tQ9ufCu5NpA-1; Wed, 20 Sep 2023 11:37:47 +0100
X-MC-Unique: 5wXb8dyyPl6tQ9ufCu5NpA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 20 Sep
 2023 11:37:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 20 Sep 2023 11:37:43 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, "John Paul Adrian
 Glaubitz" <glaubitz@physik.fu-berlin.de>
CC: Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox
	<willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ankur Arora
	<ankur.a.arora@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"x86@kernel.org" <x86@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "mgorman@suse.de" <mgorman@suse.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "jon.grimm@amd.com"
	<jon.grimm@amd.com>, "bharata@amd.com" <bharata@amd.com>,
	"raghavendra.kt@amd.com" <raghavendra.kt@amd.com>,
	"boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
	"konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "jgross@suse.com"
	<jgross@suse.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, "linux-m68k@lists.linux-m68k.org"
	<linux-m68k@lists.linux-m68k.org>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
	<johannes@sipsolutions.net>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, Brian Cain <bcain@quicinc.com>,
	"linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Ivan Kokshaysky
	<ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>
Subject: RE: Arches that don't support PREEMPT
Thread-Topic: Arches that don't support PREEMPT
Thread-Index: AQHZ6x5UxOltR8DhjkKxVhgmNJa7b7AjhK8w
Date: Wed, 20 Sep 2023 10:37:42 +0000
Message-ID: <c3d5937c27824f7f879012cdeb876a14@AcuMS.aculab.com>
References: <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
In-Reply-To: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_033757_876539_5F173EA1 
X-CRM114-Status: GOOD (  13.67  )
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

From: Linus Torvalds
> Sent: 19 September 2023 18:25
> 
> On Tue, 19 Sept 2023 at 06:48, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> >
> > As Geert poined out, I'm not seeing anything particular problematic with the
> > architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> > something about organizing KConfig files.
> 
> It can definitely be problematic.
> 
> Not the Kconfig file part, and not the preempt count part itself.
> 
> But the fact that it has never been used and tested means that there
> might be tons of "this architecture code knows it's not preemptible,
> because this architecture doesn't support preemption".

Do distos even build x86 kernels with PREEMPT_FULL?
I know I've had issues with massive latencies caused graphics driver
forcing write-backs of all the framebuffer memory.
(I think it is a failed attempt to fix a temporary display corruption.)

OTOH SMP support and CONFIG_RT will test most of the code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
