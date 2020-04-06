Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLVhC-0005r5-AU
 for linux-um@lists.infradead.org; Mon, 06 Apr 2020 17:38:03 +0000
Received: by mail-pf1-x444.google.com with SMTP id v23so70670pfm.1
 for <linux-um@lists.infradead.org>; Mon, 06 Apr 2020 10:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200405213357.b6ce1024b276.I7c370e20580d3122c58df5727ee2d6fb53545576@changeid>
In-Reply-To: <20200405213357.b6ce1024b276.I7c370e20580d3122c58df5727ee2d6fb53545576@changeid>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 6 Apr 2020 10:37:49 -0700
Message-ID: <CAFd5g47m5JHV19FjCgSt=FKWYjG3vUQSJ3oa125xD1cYMH8bww@mail.gmail.com>
Subject: Re: [PATCH] arch: um: fix xor.h include
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
Cc: linux-um <linux-um@lists.infradead.org>, Johannes Berg <johannes.berg@intel.com>, Thomas Meyer <thomas@m3y3r.de>

On Sun, Apr 5, 2020 at 12:34 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> Two independent changes here ended up going into the tree
> one after another, without a necessary rename, fix that.
>
> Reported-by: Thomas Meyer <thomas@m3y3r.de>
> Fixes: f185063bff91 ("um: Move timer-internal.h to non-shared")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Seems pretty straightforward to me.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

