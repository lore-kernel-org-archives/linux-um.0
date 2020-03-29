Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIfw8-0006dS-34
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 21:57:46 +0000
Received: by mail-wr1-x444.google.com with SMTP id m11so13028260wrx.10
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 14:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200327193626.82329-1-alex.dewar@gmx.co.uk>
In-Reply-To: <20200327193626.82329-1-alex.dewar@gmx.co.uk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 23:57:30 +0200
Message-ID: <CAFLxGvxy8Bc_rb_UKFhxRQ2ttVA1Rk-WqJ=_NYpCUXz2kaq3-A@mail.gmail.com>
Subject: Re: [PATCH] um: Remove some unnecessary NULL checks in vector_user.c
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
To: Alex Dewar <alex.dewar@gmx.co.uk>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Fri, Mar 27, 2020 at 8:38 PM Alex Dewar <alex.dewar@gmx.co.uk> wrote:
>
> kfree() already checks for null pointers, so additional checking is
> unnecessary.
>
> Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>

Applied, thanks!

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

