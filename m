Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mM4Xv-000JK1-I6
 for linux-um@lists.infradead.org; Fri, 03 Sep 2021 08:27:37 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] um: don't use CONFIG_X86_{32,64} symbols on x86
Date: Fri, 3 Sep 2021 08:27:24 +0000
Message-ID: <f177f8b287f14c93b04542d7ab4a8dfd@AcuMS.aculab.com>
References: <20210902102750.1ddfef4c1915.Icb5c49998c55b87c8584d46894c01b114ae2e661@changeid>
In-Reply-To: <20210902102750.1ddfef4c1915.Icb5c49998c55b87c8584d46894c01b114ae2e661@changeid>
MIME-Version: 1.0
Content-Language: en-US
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
To: 'Johannes Berg' <johannes@sipsolutions.net>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg
> Sent: 02 September 2021 09:28
> 
> The CONFIG_X86_32 and CONFIG_X86_64 symbols are used by
> both "real" x86 architecture builds and ARCH=um today.
> However, clearly most people and places in the code are
> treating it as the architecture Kconfig (technically
> that's just CONFIG_X86) and use it to indicate that the
> architecture is X86 in 32- or 64-bit flavour.
> 
> This has caused a fair amount of issues in the past,
> for example drivers not building because use x86 macros
> or similar under CONFIG_X86_{32,64} ifdef, and then we
> find build reports and add "!UML" to their Kconfig etc.
> 
> However, this is error-prone and a kind of whack-a-mole
> game, even with the build bots reporting things.

I suspect you've just changed the 'mole'.

You've now got lots of lines like:

#if defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML)

Missing off the UML define is going to cause the 32bit code
to get compiled by mistake - which is likely to be more
confusing that the places where you need to do special 'stuff'
for UML.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

