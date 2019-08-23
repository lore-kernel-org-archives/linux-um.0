Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i19e0-0006Wk-P5
 for linux-um@lists.infradead.org; Fri, 23 Aug 2019 13:30:21 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1i19dz-0005Dc-FT
 for linux-um@lists.infradead.org; Fri, 23 Aug 2019 15:30:19 +0200
Message-ID: <80288c363d70b517004c61a02e1d5514f2769554.camel@sipsolutions.net>
Subject: Re: [PATCH] arch: um: enable CONFIG_CONSTRUCTORS
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 23 Aug 2019 15:30:18 +0200
In-Reply-To: <20190823130557.15870-1-johannes@sipsolutions.net>
References: <20190823130557.15870-1-johannes@sipsolutions.net>
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

On Fri, 2019-08-23 at 15:05 +0200, Johannes Berg wrote:
> 
> -#ifdef CONFIG_CONSTRUCTORS
> +#if defined(CONFIG_CONSTRUCTORS) && !defined(CONFIG_UML)
>  	ctor_fn_t *fn = (ctor_fn_t *) __ctors_start;

Hmm, no, this doesn't work. I was trying to do this for KASAN, but libc
calls this stuff WAY too early, and so KASAN just crashes.

It *does* get called (only once), but much too early.

Let's see if I can come up with a fix.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

