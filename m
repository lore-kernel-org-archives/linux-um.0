Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9wdR-0004e2-Ke
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 19:26:10 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1i9wdP-00046V-BE
 for linux-um@lists.infradead.org; Mon, 16 Sep 2019 21:26:03 +0200
Message-ID: <9d109b028f2a78ed3f7f01e8bc1c90af2e8a4a56.camel@sipsolutions.net>
Subject: Re: [PATCH] um: time-travel: rewrite as an event scheduler
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 16 Sep 2019 21:26:02 +0200
In-Reply-To: <1568639197-I5687e9cdda059457fa2771ee06f9b4f399dc6f70@changeid>
References: <1568639197-I5687e9cdda059457fa2771ee06f9b4f399dc6f70@changeid>
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

On Mon, 2019-09-16 at 15:06 +0200, Johannes Berg wrote:
> 
> Finally, I noticed a bug while developing this - if we move
> time forward due to consuming time while reading the clock,
> we might move across the next event and that would cause us
> to go backward in time when we then handle that event. Fix
> that by invoking the whole event machine in this case.

This whole thing with the scheduling from reading the clock interacts
badly with the external time-travel mode, and listening to external
devices, etc.

I'll resend a new version of this that makes reading the clock free if
interrupts are disabled, that simplifies not only this patch, but also
the "external scheduler time-travel mode" significantly.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

