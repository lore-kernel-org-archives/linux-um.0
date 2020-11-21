Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgPLw-0000dZ-2y
 for linux-um@lists.infradead.org; Sat, 21 Nov 2020 09:38:46 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1kgPLk-00Btw8-GU
 for linux-um@lists.infradead.org; Sat, 21 Nov 2020 10:38:32 +0100
Message-ID: <1c742320a6c8f8ac6bed8f906433d7d3df979166.camel@sipsolutions.net>
Subject: Re: [PATCH 2/4] um: add a pseudo RTC
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sat, 21 Nov 2020 10:38:31 +0100
In-Reply-To: <20201120222625.6e15df564f9c.I9e5927602a6f5495d3dd574d89e3b138e978bcb4@changeid>
References: <20201120212921.880781-1-johannes@sipsolutions.net>
 <20201120222625.6e15df564f9c.I9e5927602a6f5495d3dd574d89e3b138e978bcb4@changeid>
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

On Fri, 2020-11-20 at 22:29 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This isn't quite the right thing, and especially doesn't
> actually cause wakeups due to CLOCK_REALTIME (if that
> ends up changing due to the host), but it will let us
> test suspend/resume.
> 
> +++ b/arch/um/include/asm/irq.h
> @@ -18,10 +18,11 @@
>  #define XTERM_IRQ 		13
>  #define RANDOM_IRQ 		14
>  #define VIRTIO_IRQ		15
> +#define RTC_IRQ			16
>  
>  #ifdef CONFIG_UML_NET_VECTOR

I missed updating the #else branch of this, so this is wrong.

But since I'll want to have some virtio devices wakeup-enabled and
others not, I think I'm going to rework our IRQ allocation entirely, and
just reserve some maximum number (say 64?), and let virtio and vector
networking dynamically allocate them instead of having to keep track of
all the hard-coded ones all the time ...

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

