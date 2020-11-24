Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khfb3-0008Rm-Tl
 for linux-um@lists.infradead.org; Tue, 24 Nov 2020 21:11:34 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1khfb1-00E4yS-1G
 for linux-um@lists.infradead.org; Tue, 24 Nov 2020 22:11:31 +0100
Message-ID: <69ebf6160ddab9903203e76b5749949e5dc863fa.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7 um: IRQ handling cleanups
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 24 Nov 2020 22:11:30 +0100
In-Reply-To: <20201123195621.275470-1-johannes@sipsolutions.net>
References: <20201123195621.275470-1-johannes@sipsolutions.net>
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

On Mon, 2020-11-23 at 20:56 +0100, Johannes Berg wrote:
> The IRQ code seems very confusing, but now that I've had to dig
> through it, I've come up with a number of cleanups. Really what
> I wanted was suspend/resume support (next series), but this is
> all necessary for that, in particular for virtio resume support
> (still WIP).

Btw.

It seems to me that we really ought to implement IRQ masking and
unmasking correctly. I've run into a number of scenarios now where we
can never return from sigio_handler() because an FD is readable (or
writeable) and thus we got SIGIO, but then it doesn't *stop* being
readable (writeable) because the actual interrupt handler isn't run. I
hit this in suspend, but perhaps there are other reasons why we might
never get to the interrupt handler (irq_may_run())?

In any case, I did solve these issues by just doing the restore of
interrupts late enough for now, and probably always munging the epoll
mask is too expensive ... but it's definitely a caveat here.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

