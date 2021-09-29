Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVRRB-009zqK-Gk
 for linux-um@lists.infradead.org; Wed, 29 Sep 2021 04:43:22 +0000
Received: by mail-wm1-x334.google.com with SMTP id
 c73-20020a1c9a4c000000b0030d040bb895so732385wme.2
 for <linux-um@lists.infradead.org>; Tue, 28 Sep 2021 21:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210928115146.277bec2328bb.If70926505d16d6c6a229002eb6d3f6838b546175@changeid>
In-Reply-To: <20210928115146.277bec2328bb.If70926505d16d6c6a229002eb6d3f6838b546175@changeid>
From: David Gow <davidgow@google.com>
Date: Wed, 29 Sep 2021 12:43:03 +0800
Message-ID: <CABVgOSns+0CP7zR+ry9cFguSJ3wNC=oHrN3J1=pea+HFpSWfeg@mail.gmail.com>
Subject: Re: [PATCH] uml: x86: add FORCE to user_constants.h
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
Cc: linux-um <linux-um@lists.infradead.org>, Johannes Berg <johannes.berg@intel.com>

On Tue, Sep 28, 2021 at 5:52 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> The build system has started warning when filechk is called
> without FORCE:
>
> arch/x86/um/Makefile:44: FORCE prerequisite is missing
>
> Add FORCE to make sure the file is checked/rebuilt when
> necessary (and to quiet up the warning.)
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---

Thanks -- this gets rid of the warning in KUnit builds, and the fix
makes sense to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

