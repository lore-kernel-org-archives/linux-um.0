Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i1n9m-0002UT-Bn
 for linux-um@lists.infradead.org; Sun, 25 Aug 2019 07:41:47 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1i1n9f-00052l-RL
 for linux-um@lists.infradead.org; Sun, 25 Aug 2019 09:41:39 +0200
Message-ID: <d929dc9c60b46ac222ca847fe8df7c0640713e4a.camel@sipsolutions.net>
Subject: Re: [PATCH] arch: um: implement memory protection
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 25 Aug 2019 09:41:39 +0200
In-Reply-To: <20190823225831.23517-1-johannes@sipsolutions.net>
References: <20190823225831.23517-1-johannes@sipsolutions.net>
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
To: linux-um@lists.infradead.org

On Sat, 2019-08-24 at 00:58 +0200, Johannes Berg wrote:
> 
> Note that you can now enable CONFIG_DEBUG_RODATA_TEST,
> but it's broken as the fixup is broken - it'll just
> crash with
> 
>  Kernel panic - not syncing: Segfault with no mm

It just occurred to me that I need to check what happens if it's
actually userspace talking the fault or something, maybe if it
erroneously tries to copy_o_user() with a read-only kernel address or
so.

Don't want to cause a panic() in that case, after all.

IOW, I'd feel much happier about this if I could make
CONFIG_DEBUG_RODATA_TEST work after all, but I gave up after an hour or
so of poking the exception handlers and trying to figure out how I could
make fixup tables work on UML. It might mean doing copy_from_user() in
assembly, which would be annoying.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

