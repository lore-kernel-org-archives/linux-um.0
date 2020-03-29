Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIffT-0001f6-LV
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 21:40:32 +0000
Received: by mail-wr1-x442.google.com with SMTP id s1so18854724wrv.5
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 14:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200317004507.1513370-1-krisman@collabora.com>
In-Reply-To: <20200317004507.1513370-1-krisman@collabora.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 23:40:19 +0200
Message-ID: <CAFLxGvzGo8CPbH1NAo_d2NYHaJDZjYEELz=dufKtTwcBkZif_A@mail.gmail.com>
Subject: Re: [PATCH 0/2] fixes to the hypervisor ubd thread
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
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Mar 17, 2020 at 1:45 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> While debugging a somewhat related issue, I ran into two issues I
> believe can cause the hypervisor to write garbage to the pipe.
>
> This was find by visual inspection and is only slightly tested.  It
> seems to partially some the problems my test case shows.
>
> Please, let me know what you think

Both patches make sense. Thanks for fixing, applied.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

