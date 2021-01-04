Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwQjI-000356-GW
 for linux-um@lists.infradead.org; Mon, 04 Jan 2021 14:21:07 +0000
Date: Mon, 4 Jan 2021 09:21:00 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.10 20/31] um: allocate a guard page to helper
 threads
Message-ID: <20210104142100.GB3665355@sasha-vm>
References: <20201230130314.3636961-1-sashal@kernel.org>
 <20201230130314.3636961-20-sashal@kernel.org>
 <d17899cc72a31f12da166de6223338b844ee2428.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d17899cc72a31f12da166de6223338b844ee2428.camel@sipsolutions.net>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Wed, Dec 30, 2020 at 03:48:57PM +0100, Johannes Berg wrote:
>On Wed, 2020-12-30 at 08:03 -0500, Sasha Levin wrote:
>>
>> We've been running into stack overflows in helper threads
>> corrupting memory
>
>For the record, that was mostly referring to "while development", so
>while this change makes a few things a bit safer, I don't think there's
>all that much point in backporting to stable; presumably things are
>working OK there for people, and developers will (hopefully) be working
>on mainline anyway.

I'll drop it, thanks!

-- 
Thanks,
Sasha

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

