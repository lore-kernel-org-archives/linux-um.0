Return-Path: <johannes@sipsolutions.net>
Message-ID: <87441c0a5114f7a1ed904cefc8c4219a3f823779.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] arch: um: support virtual time
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 06 May 2019 10:19:35 +0200
In-Reply-To: <CAMuHMdXi7Yd9p8dahixBbH=kuY1Zmyz3OHCxrH9tKDo23cGHhw@mail.gmail.com> (sfid-20190506_094518_502940_F26CF509)
References: <20190503213249.30008-1-johannes@sipsolutions.net>
	 <20190503213249.30008-3-johannes@sipsolutions.net>
	 <95430ca975e73addc7f65e331488bc280974fd72.camel@sipsolutions.net>
	 <9f844312-dca3-d20e-485b-13c1f249edb0@cambridgegreys.com>
	 <CAMuHMdXi7Yd9p8dahixBbH=kuY1Zmyz3OHCxrH9tKDo23cGHhw@mail.gmail.com>
	 (sfid-20190506_094518_502940_F26CF509)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>
List-ID: <linux-um.lists.infradead.org>

On Mon, 2019-05-06 at 09:45 +0200, Geert Uytterhoeven wrote:
> On Sat, May 4, 2019 at 10:43 PM Anton Ivanov
> <anton.ivanov@cambridgegreys.com> wrote:
> > On 04/05/2019 20:05, Johannes Berg wrote:
> > > On Fri, 2019-05-03 at 21:32 +0000, Johannes Berg wrote:
> > 
> > I can understand your use case for patch 3. What I am not clear is where
> > should that config option live. It should be somewhere under
> > debug/kernel hacking with a sufficient number of big fat warnings so
> > people do not enable it accidentally by mistake.
> 
> I think enabling the config option should not also enable the feature, but
> just add code that allows to enable the feature by a kernel command line
> option, and/or by a special file in debugfs.

Hmm. Might be doable with a command line argument, I don't think having
the kernel boot in "real time" and then continue running at some point
from "virtual time" when enabled via debugfs makes sense, and I also
don't see how you could really switch back and forth without a lot of
effort in the code.

johannes


