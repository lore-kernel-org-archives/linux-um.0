Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knoly-0001B9-2n
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 20:12:14 +0000
Message-ID: <8bf26fa61b51080c1a861de1a95d292a6c93cf0a.camel@sipsolutions.net>
Subject: Re: [PATCH v4 6/7] um: swithch futex ops to cmpxchg
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 11 Dec 2020 21:12:06 +0100
In-Reply-To: <20201211174559.26010-7-anton.ivanov@cambridgegreys.com>
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
 <20201211174559.26010-7-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at

Typo in the subject :)

> As a result of switching from emulated to true atomic cmpxchg
> we can use cmpxchg in the corresponding um futex op.

But this seems odd - maybe just reorder the patches so the futex code
can directly have this squashed in?

johannes



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

