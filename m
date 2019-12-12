Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifIgX-0000u8-8D
 for linux-um@lists.infradead.org; Thu, 12 Dec 2019 07:14:55 +0000
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
References: <20191209230248.227508-1-brendanhiggins@google.com>
 <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
 <2eecf4dc-eb96-859a-a015-1a4f388b57a2@cambridgegreys.com>
 <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
 <392256369.112046.1575966868218.JavaMail.zimbra@nod.at>
 <DM6PR10MB3225EB0C204572F8D39C0ED5E2550@DM6PR10MB3225.namprd10.prod.outlook.com>
 <DM6PR10MB32259A098E3BED3CF522C851E2550@DM6PR10MB3225.namprd10.prod.outlook.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <3f4af81b-72e5-b197-ef25-aaf5aae0e604@cambridgegreys.com>
Date: Thu, 12 Dec 2019 07:14:43 +0000
MIME-Version: 1.0
In-Reply-To: <DM6PR10MB32259A098E3BED3CF522C851E2550@DM6PR10MB3225.namprd10.prod.outlook.com>
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
To: James McMechan <james_mcmechan@hotmail.com>, Richard Weinberger <richard@nod.at>
Cc: Johannes Berg <johannes.berg@intel.com>, Brendan Higgins <brendanhiggins@google.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, davidgow <davidgow@google.com>

On 12/12/2019 05:23, James McMechan wrote:
> Fixed up version without html...
> Um what is broken, uml seems to be working with the old stack and static linking.
> 
> I saw a comment that the vector io stuff breaks uml on static link,
> but I was just running one without vector io, I had the pcap library linked in instead.
> It was up for about 3 days when I rebooted from mconsole 'cad'
> It would seem simplest to just mark vector io as !STATIC in the config...
> I was running 5.4.2 with a pretty close to defconfig
> 
> I had to twiddle the uml pcap a little to deconflict the headers, and make sure pcap was not linking to dbus.
> I have not looked into vector io too closely I seemed to remember it was using host getaddrinfo the only thing in uml doing so I think it was pulling in the glibc, so-so dynamically link networking even when told not to... and that was breaking the startup process by changing memory maps behind the programs back or some such and then segfaulting the process much like the "we will implement async io in userspace behind the processes back" did back in the day.
> 
> I would expect it to be possible to remove the getaddrinfo or use kernel functions.

If you just try to do 1:1 replacement with the legacy functions you stop 
being v6 compliant. You after that need to go through quite a lot of 
hoops and extra code to get that back.

You cannot use kernel functions - this is on the host userspace side of UML.

> It does not seem to have much in the way of comments, and I don't understand what it is trying to do.
> Why would a network protocol need to lookup "protocol/ip address/port num" sets in userspace? it should just be passing everything somewhere...
> Is it trying to do dynamic routing of the packets to different transports?

It is using shared code for (at present) tap (two forms - one optimized 
for throughput, one using a tap/socket pair optimized for packets per 
second), raw sockets, gre, l2tpv3 (both raw and over udp) and one 
flavour unix domain sockets.

Both gre and l2tpv3 support v4 and v6.

While it is possible to replace getaddrinfo with a sequence of 
gethostbyname, etc it will:

1. Grow the size of the code by at least 100 lines if not more. If I 
take care of all corner cases which getaddrinfo() does - more.

2. Defeat one of the purposes of the exercise - to make it easy to add 
new socket transports.

3. There is no guarantee that the glibc guys will not make gethostbyname 
and friends fallback to getaddrinfo internally one day (in fact I am 
surprised they have not done it yet).

> 
> Slight confused but still running,
> 
> Jim McMechan
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

