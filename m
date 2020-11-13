Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdbTb-0000zZ-Ss
 for linux-um@lists.infradead.org; Fri, 13 Nov 2020 15:59:04 +0000
Message-ID: <934d3df1539e43b7cc4e7fa2a22d806215ed5b8c.camel@sipsolutions.net>
Subject: Re: [PATCH] um: "borrow" cmpxchg from x86 tree in UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 13 Nov 2020 16:58:59 +0100
In-Reply-To: <e22c7628-29a7-6dea-1707-948f89334a79@cambridgegreys.com>
References: <20201113115437.14325-1-anton.ivanov@cambridgegreys.com>
 <e22c7628-29a7-6dea-1707-948f89334a79@cambridgegreys.com>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: richard@nod.at

On Fri, 2020-11-13 at 13:48 +0000, Anton Ivanov wrote:
> 
> I think that was it. Or to be more exact, I hope that was it.
> 
> I went a few times through asm-generic and that looks like all the
> bits which are worth implementing for a uniprocessor architecture as a
> replacement for their generic equivalents.

It seems that word-at-a-time.h with CONFIG_DCACHE_WORD_ACCESS might 
be worthwhile as well?

Also perhaps bug.h; there are a lot of BUG_ON/WARN_ON and similar
things, and especially the _ONCE part looks better there?

ftrace is probably not worth the effort ...

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

