Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knUTk-0003yA-SX
 for linux-um@lists.infradead.org; Thu, 10 Dec 2020 22:32:05 +0000
Received: by mail-qv1-xf44.google.com with SMTP id p12so3285903qvj.13
 for <linux-um@lists.infradead.org>; Thu, 10 Dec 2020 14:32:04 -0800 (PST)
MIME-Version: 1.0
References: <20201122041356.1454413-1-krisman@collabora.com>
 <87blf35bim.fsf@collabora.com>
In-Reply-To: <87blf35bim.fsf@collabora.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 10 Dec 2020 23:31:52 +0100
Message-ID: <CAFLxGvyR0YAU=-PmGG4t2pSqd_DzsRLYsA63bD5LpyRhi4iReg@mail.gmail.com>
Subject: Re: [PATCH v2] um: ubd: Submit all data segments atomically
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
Cc: Martyn Welch <martyn@collabora.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Wed, Dec 9, 2020 at 2:56 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Gabriel Krisman Bertazi <krisman@collabora.com> writes:
>
> > Internally, UBD treats each physical IO segment as a separate command to
> > be submitted in the execution pipe.  If the pipe returns a transient
> > error after a few segments have already been written, UBD will tell the
> > block layer to requeue the request, but there is no way to reclaim the
> > segments already submitted.  When a new attempt to dispatch the request
> > is done, those segments already submitted will get duplicated, causing
> > the WARN_ON below in the best case, and potentially data corruption.
>
> [...]
>
> > Cc: Christopher Obbard <chris.obbard@collabora.com>
> > Reported-by: Martyn Welch <martyn@collabora.com>
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > Tested-by: Christopher Obbard <chris.obbard@collabora.com>
> > Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> ping. :)

Just pushed my local tree to next. Including your patch. :-)

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

