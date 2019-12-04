Return-Path: <johannes@sipsolutions.net>
Message-ID: <165e919acc8e705bca62df62ca8daa5c9b5c447a.camel@sipsolutions.net>
Subject: Re: I get 5.4 fail to start
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 04 Dec 2019 14:09:11 +0100
In-Reply-To: <5aa2eb4fc9721dbd8a1ceaf8fc6710b666128f25.camel@sipsolutions.net>
References: <973c61bb-d1c4-a3ef-fec4-d492fa513d15@cambridgegreys.com>
	 <CAFLxGvyKsT_Yjs9KRndqadYHQeFWpN9yzyCX8BLX6Zzigsg1vw@mail.gmail.com>
	 <4d50a04d-9bef-9c12-3763-50ad80580b9e@cambridgegreys.com>
	 <6c270dbe-a6c3-e2db-01d2-7d2239d6c0ee@cambridgegreys.com>
	 <1054145.106334.1575450216775.JavaMail.zimbra@nod.at>
	 <aaaa5a05-efd3-4f6c-7728-86c8b0f08a7d@cambridgegreys.com>
	 <CAMuHMdVrLPKwXxfyG3-Y5yUF9KPrTzosydxN1rkBFcJXsWi86Q@mail.gmail.com>
	 <a9620d0a-31cd-f208-76de-63406496e4a0@cambridgegreys.com>
	 <86abb3cc-1557-b5de-9c35-fdc67855030c@cambridgegreys.com>
	 <6aaec3f72344246f10b0fb65a08efae5d258be9a.camel@sipsolutions.net>
	 <0bb1c370-8a63-a2e8-afd6-6e95acf9efb2@cambridgegreys.com>
	 <5aa2eb4fc9721dbd8a1ceaf8fc6710b666128f25.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, linux-um <linux-um@lists.infradead.org>
List-ID: <linux-um.lists.infradead.org>

On Wed, 2019-12-04 at 14:00 +0100, Johannes Berg wrote:
> > > Oops. Try to revert it? We don't _really_ need it right now. It did work
> > > on my system, but there's a good chance that there's something gcc/libc
> > > dependent in there.
> > 
> > It tests out fine if I revert it.
> > 
> > I still do not understand how and why it managed to produce this weird 
> > effect with ptrace though.
> 
> I agree that's odd, but since we don't need it, let's revert it anyway
> for now? I won't really have time to investigate it much right now.

Hm. Maybe the __initcall instances in os-Linux should be earlier, and
that mixes up something?

I guess we could try to place the os-Linux/ initcalls into the
.init_call section after all, vs. having the kernel execute those.

johannes


