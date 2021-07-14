Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3YkR-00CSeQ-AX
 for linux-um@lists.infradead.org; Wed, 14 Jul 2021 06:52:00 +0000
Message-ID: <1b269475702f8915defaee1016279917a047b44b.camel@sipsolutions.net>
Subject: Re: [PATCH] um: fix stub location calculation
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 14 Jul 2021 08:51:55 +0200
In-Reply-To: <CABqSeAQWt41yvGCV3AbKuLeHUF0kvQvj6=0of-US4sn_=wxLDg@mail.gmail.com>
References: <20210713234710.ba0da02a609f.I56390429bc78e79e859e374183370c6311535786@changeid>
 <CAFLxGvxuC61cre6hOg2_-qCe6ArRgOYw0E8q-5ECS=mggoqF0g@mail.gmail.com>
 <CABqSeAQWt41yvGCV3AbKuLeHUF0kvQvj6=0of-US4sn_=wxLDg@mail.gmail.com>
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
To: YiFei Zhu <zhuyifei1999@gmail.com>, Richard Weinberger <richard.weinberger@gmail.com>
Cc: linux-um <linux-um@lists.infradead.org>, subashab@codeaurora.org

On Tue, 2021-07-13 at 17:44 -0500, YiFei Zhu wrote:
> 
> The store is optimized away -> the faultinfo is unmodified -> the segv
> handler treats the fault as unfixable -> init dead.

Yeah. I was confused about this in the clone case, but even there of
course the store is important because that's the child's PID in the
parent ... I somehow looked at the code last night and thought it was
only a broken error case.

I'll leave it to Richard to figure out which of the two things to apply,
I guess. And it should probably come with a Cc: stable, which I forgot
on my patch.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

