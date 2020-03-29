Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIfnn-0003aj-JX
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 21:49:08 +0000
Received: by mail-wm1-x343.google.com with SMTP id c81so17718999wmd.4
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 14:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200213132651.20506-1-johannes@sipsolutions.net>
In-Reply-To: <20200213132651.20506-1-johannes@sipsolutions.net>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 23:48:54 +0200
Message-ID: <CAFLxGvx_BvBYNDqxCfBBvciGFCxs8Fw00iDz6RNLVw9GF-eomw@mail.gmail.com>
Subject: Re: [PATCH 0/6] um: external time travel
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
Cc: linux-um <linux-um@lists.infradead.org>

On Thu, Feb 13, 2020 at 2:27 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi,
>
> Here's a respin of this - I've been testing this for a few weeks
> (and some of it months) now and things are working really well,
> so I think it's *almost* ready to go.
>
> The only problem is patch 3 - the vhost-user spec changes *still*
> haven't gotten merged :-(

Since the vhost-user spec is now merged in qemu we can also merge this. :-)
I removed all internal commit tags.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

