Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kucmf-000857-GU
 for linux-um@lists.infradead.org; Wed, 30 Dec 2020 14:49:06 +0000
Message-ID: <d17899cc72a31f12da166de6223338b844ee2428.camel@sipsolutions.net>
Subject: Re: [PATCH AUTOSEL 5.10 20/31] um: allocate a guard page to helper
 threads
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 30 Dec 2020 15:48:57 +0100
In-Reply-To: <20201230130314.3636961-20-sashal@kernel.org>
References: <20201230130314.3636961-1-sashal@kernel.org>
 <20201230130314.3636961-20-sashal@kernel.org>
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
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org

On Wed, 2020-12-30 at 08:03 -0500, Sasha Levin wrote:
> 
> We've been running into stack overflows in helper threads
> corrupting memory

For the record, that was mostly referring to "while development", so
while this change makes a few things a bit safer, I don't think there's
all that much point in backporting to stable; presumably things are
working OK there for people, and developers will (hopefully) be working
on mainline anyway.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

