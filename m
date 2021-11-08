Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk2Cl-00G9si-88
 for linux-um@lists.infradead.org; Mon, 08 Nov 2021 10:48:48 +0000
Date: Mon, 8 Nov 2021 11:48:40 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v0 25/42] arch/um: Check notifier registration return value
Message-ID: <YYkAiFhxVsLaPTqr@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-26-bp@alien8.de>
 <129beb0a860102ba7970ab7497a5a83fe2041e68.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <129beb0a860102ba7970ab7497a5a83fe2041e68.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org

On Mon, Nov 08, 2021 at 11:23:59AM +0100, Johannes Berg wrote:
> Maybe it should just return it? I don't see how this is ever possible,
> since it's an initcall.

If it would return it, you'd see the warning only when booting with
"initcall_debug", I believe.

I can do that if it is preferred...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

