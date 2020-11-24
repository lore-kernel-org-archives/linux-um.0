Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khTTd-0002x8-IC
 for linux-um@lists.infradead.org; Tue, 24 Nov 2020 08:15:08 +0000
Subject: Re: [PATCH 0/7 um: IRQ handling cleanups
References: <20201123195621.275470-1-johannes@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <3812c8af-edc1-a2ff-96e5-0ad96e85411b@kot-begemot.co.uk>
Date: Tue, 24 Nov 2020 08:14:52 +0000
MIME-Version: 1.0
In-Reply-To: <20201123195621.275470-1-johannes@sipsolutions.net>
Content-Language: en-US
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org



On 23/11/2020 19:56, Johannes Berg wrote:
> The IRQ code seems very confusing, 

Tell me about it :)

> but now that I've had to dig
> through it, I've come up with a number of cleanups. Really what
> I wanted was suspend/resume support (next series), but this is
> all necessary for that, in particular for virtio resume support
> (still WIP).

Excellent. I will try to find some time to review it before the end of the day.

I have tried some of what you did when working on timers/epoll - namely turning off the HZ-like nanosleep in time.c. I could not get it to work at the time. So I dropped it from the final version of the patches.

> 
> johannes
> 
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

