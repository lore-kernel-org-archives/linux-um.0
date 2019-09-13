Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8gkP-0000yT-7p
 for linux-um@lists.infradead.org; Fri, 13 Sep 2019 08:16:07 +0000
Message-ID: <69bf4022f3c6b7af20b2188673d3c0563c340f5e.camel@sipsolutions.net>
Subject: Re: [PATCH v5 0/5] um: virtio support
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 13 Sep 2019 10:15:59 +0200
In-Reply-To: <9e8e9db8-eafb-9132-21a2-762ea09b501a@kot-begemot.co.uk>
References: <20190911125122.20772-1-johannes@sipsolutions.net>
 <2b6ac17c16113892e27e82df9802264ef934d4d8.camel@sipsolutions.net>
 <3ccfa0c9-7b5c-6135-693e-a9700dfdd19f@kot-begemot.co.uk>
 <9e8e9db8-eafb-9132-21a2-762ea09b501a@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

On Fri, 2019-09-13 at 09:14 +0100, Anton Ivanov wrote:

> It does not build as is at the moment, you need to add
> 
> EXPORT_SYMBOL(uml_reserved);
> 
> to ./kernel/um_arch.c
> 
> I could not find that anywhere in the patch series so it is probably 
> lingering in your tree from somewhere else.

Oh, no, but I've been using it built-in rather than as a module, sorry.

> It will be a good idea to respin everything including the patches it 
> depends vs current 5.x head so that we have a "definitive test with 
> this" version to work with.

I guess I'll have to test build it a bit more in various configs :)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

