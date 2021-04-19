Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYVVA-00BTV8-Bm
 for linux-um@lists.infradead.org; Mon, 19 Apr 2021 15:07:56 +0000
Received: by mail-pl1-x636.google.com with SMTP id e2so13559482plh.8
 for <linux-um@lists.infradead.org>; Mon, 19 Apr 2021 08:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210417163949.530921-1-zhuyifei1999@gmail.com>
 <9722b8ce233ad4d7020588f9dd60a3037455754d.camel@sipsolutions.net>
 <CABqSeATg2558BgMWMBs3O3vuR9wWS30d=x2iug3S-M1eMFi+qQ@mail.gmail.com>
 <CABqSeATiUxfev8O4ZRdi_jvLEXC2MMuomE_nKv=mG2b_3eP-qA@mail.gmail.com>
 <2a59bd34565615ff0b4dcdd9cdcd2e0d40ed429c.camel@sipsolutions.net>
In-Reply-To: <2a59bd34565615ff0b4dcdd9cdcd2e0d40ed429c.camel@sipsolutions.net>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Mon, 19 Apr 2021 10:07:39 -0500
Message-ID: <CABqSeASwu8AdSm5_-Ma0bk3o3zi9HRrtVmyT4dfx85dH4TpuKg@mail.gmail.com>
Subject: Re: [PATCH] uml/helper: Fix stack alignment
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
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Mon, Apr 19, 2021 at 8:35 AM Benjamin Berg <benjamin@sipsolutions.net> wrote:
> Yeah, printk is only usable from kernel threads. So in other cases
> logging should happen directly. But do note that os_info with its
> current glibc printf implementation seems to also create issues
> sometimes as it may require more stack than available.
>
> In my seccomp patchset, I added a few patches to fix related issues,
> see
>  https://patchwork.ozlabs.org/project/linux-um/list/?series=231980
> specifically
>  * [06/27] um: Don't use vfprintf() for os_info()
>  * [07/27] um: Do not use printk in SIGWINCH helper thread
>  * [09/27] um: Do not use printk in userspace trampoline
>
> Benjamin

I see! Thanks. Good to know there's a patch working to fix this issue.

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

