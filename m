Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <201105201910.13095.toralf.foerster@gmx.de>
References: <201105191526.31904.toralf.foerster@gmx.de>
	 <1305907458.1465.23.camel@gandalf.stny.rr.com>
	 <1305907896.1465.27.camel@gandalf.stny.rr.com>
	 <201105201910.13095.toralf.foerster@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 20 May 2011 13:44:02 -0400
Message-ID: <1305913442.1465.32.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Darren Hart <dvhart@linux.intel.com>, richard -rw- weinberger <richard.weinberger@gmail.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 2011-05-20 at 19:10 +0200, Toralf F=F6rster wrote:

> Is there's an easy way to check, whether a given checked out git tree=
 contains=20
> a specific commit id ?

You can try:

git log --pretty=3Doneline | grep <SHA1>

-- Steve



--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

