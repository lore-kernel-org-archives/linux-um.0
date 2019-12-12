Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-dm6nam10olkn2101.outbound.protection.outlook.com
 ([40.92.41.101] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifGwo-0007Dx-Sa
 for linux-um@lists.infradead.org; Thu, 12 Dec 2019 05:23:36 +0000
From: James McMechan <james_mcmechan@hotmail.com>
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
Date: Thu, 12 Dec 2019 05:23:31 +0000
Message-ID: <DM6PR10MB32259A098E3BED3CF522C851E2550@DM6PR10MB3225.namprd10.prod.outlook.com>
References: <20191209230248.227508-1-brendanhiggins@google.com>
 <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
 <2eecf4dc-eb96-859a-a015-1a4f388b57a2@cambridgegreys.com>
 <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>,
 <392256369.112046.1575966868218.JavaMail.zimbra@nod.at>,
 <DM6PR10MB3225EB0C204572F8D39C0ED5E2550@DM6PR10MB3225.namprd10.prod.outlook.com>
In-Reply-To: <DM6PR10MB3225EB0C204572F8D39C0ED5E2550@DM6PR10MB3225.namprd10.prod.outlook.com>
Content-Language: en-US
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
To: Richard Weinberger <richard@nod.at>, anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes.berg@intel.com>, Brendan Higgins <brendanhiggins@google.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, davidgow <davidgow@google.com>

Fixed up version without html...
Um what is broken, uml seems to be working with the old stack and static linking.

I saw a comment that the vector io stuff breaks uml on static link,
but I was just running one without vector io, I had the pcap library linked in instead.
It was up for about 3 days when I rebooted from mconsole 'cad'
It would seem simplest to just mark vector io as !STATIC in the config...
I was running 5.4.2 with a pretty close to defconfig

I had to twiddle the uml pcap a little to deconflict the headers, and make sure pcap was not linking to dbus.
I have not looked into vector io too closely I seemed to remember it was using host getaddrinfo the only thing in uml doing so I think it was pulling in the glibc, so-so dynamically link networking even when told not to... and that was breaking the startup process by changing memory maps behind the programs back or some such and then segfaulting the process much like the "we will implement async io in userspace behind the processes back" did back in the day.

I would expect it to be possible to remove the getaddrinfo or use kernel functions.
It does not seem to have much in the way of comments, and I don't understand what it is trying to do.
Why would a network protocol need to lookup "protocol/ip address/port num" sets in userspace? it should just be passing everything somewhere...
Is it trying to do dynamic routing of the packets to different transports?

Slight confused but still running,

Jim McMechan
_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

