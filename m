Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h4utO-00078R-1f
 for linux-um@lists.infradead.org; Fri, 15 Mar 2019 22:01:31 +0000
Received: by mail-wr1-x442.google.com with SMTP id k1so10595638wre.1
 for <linux-um@lists.infradead.org>; Fri, 15 Mar 2019 15:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <31705653.NnsrL61LRB@blindfold>
In-Reply-To: <31705653.NnsrL61LRB@blindfold>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 15 Mar 2019 23:01:16 +0100
Message-ID: <CAFLxGvy54Fa0Dr9jbqvv2utSi3WvCusAHbYreJ1C=wg2bWtPRg@mail.gmail.com>
Subject: Re: [GIT PULL] UML updates for 5.1-rc1
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Mar 12, 2019 at 4:14 PM Richard Weinberger <richard@nod.at> wrote:
>
> Linus,
>
> The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:
>
>   Linux 5.0 (2019-03-03 15:21:29 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-5.1-rc1
>
> for you to fetch changes up to aea05eb56e47046de1e5b508d40931dca969f1e5:
>
>   um: Fix for a possible OOPS in ubd initialization (2019-03-06 22:39:18 +0100)
>
> ----------------------------------------------------------------
> This pull request contains updates for UML:
>
> - Bugfix for the UML block device driver
>
> ----------------------------------------------------------------
> Anton Ivanov (1):
>       um: Fix for a possible OOPS in ubd initialization
>
> YueHaibing (1):
>       um: Remove duplicated include from vector_user.c
>
>  arch/um/drivers/ubd_kern.c    | 6 +++---
>  arch/um/drivers/vector_user.c | 3 ---
>  2 files changed, 3 insertions(+), 6 deletions(-)

*kind ping* to make sure this PR is not lost. :-)
I guess you skipped this one too after the git.infradead.org outage.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

