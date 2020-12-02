Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkQNm-0005tP-H4
 for linux-um@lists.infradead.org; Wed, 02 Dec 2020 11:33:15 +0000
Message-ID: <7cee8105ff3a771fc0c3f7a4e4849da4ca2912a1.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] um: simplify IRQ handling code
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 02 Dec 2020 12:32:57 +0100
In-Reply-To: <b93242b0-5088-4534-8f8e-1d92b68eb9f4@kot-begemot.co.uk>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
 <20201123205446.6370687fa983.I811873233b8d71fbde9154b84c85b498521e3b12@changeid>
 <96e31171-965d-c1d7-282e-b1b0bec6b73f@kot-begemot.co.uk>
 <4ebc9f4069082c1fa3606fc636f15c664bc0af60.camel@sipsolutions.net>
 <02516224-6caf-c947-3410-0fcdc6e7204e@kot-begemot.co.uk>
 <6cbfb799d0889dc2d34d7c773a42305d025c615b.camel@sipsolutions.net>
 <b93242b0-5088-4534-8f8e-1d92b68eb9f4@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

On Wed, 2020-12-02 at 11:31 +0000, Anton Ivanov wrote:
> 
> I think we should just handle EPOLLHUP and do an IRQ + fd disable if it HUPS.
> 
> This way a close will always be handled correctly regardless of where and how it closed.

Yes, but that's sort of a separate thing?

Also, we probably should disable SIGIO if the IRQ is freed, otherwise
the FD can keep interrupting us but we don't find anything in the epoll
set ... But again, a separate cleanup?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

