Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcaZ3-00078B-Fw
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 20:48:30 +0000
Received: by mail-qt1-x82a.google.com with SMTP id 3so9639124qtx.3
 for <linux-um@lists.infradead.org>; Tue, 10 Nov 2020 12:48:27 -0800 (PST)
MIME-Version: 1.0
References: <aa967d60-ba8c-5915-1ee1-b7792e20a77b@kot-begemot.co.uk>
In-Reply-To: <aa967d60-ba8c-5915-1ee1-b7792e20a77b@kot-begemot.co.uk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 10 Nov 2020 21:48:13 +0100
Message-ID: <CAFLxGvxu6dBGC4F53VBoFnLxq2fFBE90SvNQfCp9bXJGYfL+hw@mail.gmail.com>
Subject: Re: The UMID fixes need to be added to stable
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Richard Weinberger <richard@nod.at>, linux-um <linux-um@lists.infradead.org>

On Tue, Oct 20, 2020 at 10:35 AM Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
>
> Hi list, hi Richard,
>
> I figured out the other bug where I was getting weird crashes on older versions - my machine was using larger pid numbers.
>
> IMHO we need to push the two UMID fixes - ba758cfce00a5977ccf019926f8379a96f5ac5f6 and e8a58591afbc7dc279a11454c08fce1281958eef to stable.

Agreed. Feel free to notify stable folks. You are listed in the
maintainers file. :-)

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

