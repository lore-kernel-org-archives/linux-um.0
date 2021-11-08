Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk2KA-00GByU-6e
 for linux-um@lists.infradead.org; Mon, 08 Nov 2021 10:56:27 +0000
Message-ID: <ce3a494b078ffca5df28475298ba6c491267da98.camel@sipsolutions.net>
Subject: Re: [PATCH v0 25/42] arch/um: Check notifier registration return value
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 08 Nov 2021 11:56:21 +0100
In-Reply-To: <YYkAiFhxVsLaPTqr@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-26-bp@alien8.de>
 <129beb0a860102ba7970ab7497a5a83fe2041e68.camel@sipsolutions.net>
 <YYkAiFhxVsLaPTqr@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org

On Mon, 2021-11-08 at 11:48 +0100, Borislav Petkov wrote:
> On Mon, Nov 08, 2021 at 11:23:59AM +0100, Johannes Berg wrote:
> > Maybe it should just return it? I don't see how this is ever possible,
> > since it's an initcall.
> 
> If it would return it, you'd see the warning only when booting with
> "initcall_debug", I believe.

Oh, I thought we'd fail :)

> I can do that if it is preferred...
> 
No strong opinion either way.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

