Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBO5o-0002Gm-0Q
 for linux-um@lists.infradead.org; Fri, 20 Sep 2019 18:57:21 +0000
Subject: Re: linux-image-5.2.0-2-amd64: breaks UML all versions, both debian
 stock and compiled from source.
References: <156897436056.2001.10040310871991691509.reportbug@sleer.kot.begemot.co.uk>
 <ded0fc52-3631-375f-e4b5-c18e93777c4f@kot-begemot.co.uk>
 <edc683fbb6596f2a35656f8951d2b7a692ca7620.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <dd5de310-86b8-eb66-771f-d1cbaf246da1@kot-begemot.co.uk>
Date: Fri, 20 Sep 2019 19:57:13 +0100
MIME-Version: 1.0
In-Reply-To: <edc683fbb6596f2a35656f8951d2b7a692ca7620.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, Debian Bug Tracking System <submit@bugs.debian.org>
Cc: linux-um@lists.infradead.org

On 20/09/2019 18:53, Johannes Berg wrote:
> On Fri, 2019-09-20 at 15:48 +0100, Anton Ivanov wrote:
>> These are the Start (that is what sbrk(0) returns) and &_end values I
>> get for the two kernels:
>>
>> Linux 4.19 on host - Start 1645867008 end 1631412224 diff 14454784
>>
>> Linux 5.2 on host - Start 93825006145536 end 1631412224 diff 93823374733312
> Does this need some specific configuration for 5.2? I have a system
> running 5.2.8 (compiled a relatively simple kernel for my usage there -
> it's a VM), and it can run my UML linux binary just fine.
That is starting to narrow it down to something in the debian 5.2 config :)
>
> Or perhaps there's some interaction with some other userspace too?

It definitely occurs on a debian system with current stable (buster) 
userspace and the kernel from testing which 5.2 with patches.

It definitely does not occur on a buster system with a buster stock 
kernel which is 4.19 or anything prior to that. Tested on same hardware 
and a couple of similar ones I have around.

I got as far as narrowing down the differences between the two cases to 
__binary_start which is derived from START in the source.

I have not really looked at where to go from that point.


-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

