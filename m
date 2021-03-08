Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJHjy-000Xzo-5b
 for linux-um@lists.infradead.org; Mon, 08 Mar 2021 15:24:16 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1lJHju-00DShe-Qr
 for linux-um@lists.infradead.org; Mon, 08 Mar 2021 16:24:10 +0100
Message-ID: <6ca43d1bdb6edf3cba2e7a29ee999bef3fc68f9c.camel@sipsolutions.net>
Subject: Re: [PATCH] um: allow not setting extra rpaths in the linux binary
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 08 Mar 2021 16:24:10 +0100
In-Reply-To: <20210308140237.ec2ecc0123db.Ib0c23e3dda8322f9306a9dd04146e797eb0690b2@changeid>
References: <20210308140237.ec2ecc0123db.Ib0c23e3dda8322f9306a9dd04146e797eb0690b2@changeid>
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

On Mon, 2021-03-08 at 14:02 +0100, Johannes Berg wrote:
> +config LD_SCRIPT_DYN_RPATH
> +	bool "set rpath in the binary" if EXPERT
> +	default y
> +	depends on LD_SCRIPT_DYN

Somehow, that seems to trigger Kconfig bug.

The resulting option is not actually visible, although in a menuconfig
search it's visibility is shown as being true, but it's shown
*underneath* STATIC_LINK (Force a static link) which is actually not
visible for me, and ... that's just weird?

If I manually set it in the .config file then it does stick, however, so
it's actually settable that way.

That's actually good enough for me (and in fact, because I was doing it
that way, I didn't even notice the issue at first!), but it's not really
what I expected.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

