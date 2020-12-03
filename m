Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kklVY-0001iN-OA
 for linux-um@lists.infradead.org; Thu, 03 Dec 2020 10:06:41 +0000
Subject: Re: [PATCH v7 0/5] um: suspend/resume support
References: <20201202195808.244645-1-johannes@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <858ef5b7-b3db-fabe-3fc6-01ca3a6b39da@kot-begemot.co.uk>
Date: Thu, 3 Dec 2020 10:06:33 +0000
MIME-Version: 1.0
In-Reply-To: <20201202195808.244645-1-johannes@sipsolutions.net>
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


On 02/12/2020 19:58, Johannes Berg wrote:
> Here's a respin, for one since I wanted to use pause() instead of
> the strange select(0, NULL, NULL, NULL, NULL), but also fixing some
> signal handling bugs in the suspend/resume code.
>
> johannes
>
>
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

Works nicely and I will ACK them shortly.

I will see if I can add some WOL functionality to the vector drivers.

It is definitely possible for the ones which use a raw socket - you leave them as capable of generating a SIGIO, but load a "sleeptime" BPF filter which allows only the types of packets that are entitled to wake you up - WOL magic, ARP, unicast to your own MAC, etc. IIRC ethtool has a list of all the possible options. When you wake up, you swap back the old filter (if there was any).

Brgds,

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

