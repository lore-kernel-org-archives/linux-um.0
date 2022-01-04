Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4fiP-00Aroo-7C
 for linux-um@lists.infradead.org; Tue, 04 Jan 2022 09:02:46 +0000
Message-ID: <25e9d4e4f8655bee5dc5e8a017c83d743effa4e7.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] um: irq: Restore O_ASYNC upon exit
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 04 Jan 2022 10:02:41 +0100
In-Reply-To: <20220101215810.13260-5-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
 <20220101215810.13260-5-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com

On Sat, 2022-01-01 at 22:58 +0100, Richard Weinberger wrote:
> Just like with O_NONBLOCK, make sure UML clears O_ASYNC
> upon exit when it set it.
> 

"when it set it" isn't really quite true - you always clear it, should
it be similar to the O_NONBLOCK version to see the old mode?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

