Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibs5Z-000802-Js
 for linux-um@lists.infradead.org; Mon, 02 Dec 2019 20:14:34 +0000
Received: by mail-wr1-x443.google.com with SMTP id z3so835692wru.3
 for <linux-um@lists.infradead.org>; Mon, 02 Dec 2019 12:14:32 -0800 (PST)
MIME-Version: 1.0
References: <973c61bb-d1c4-a3ef-fec4-d492fa513d15@cambridgegreys.com>
In-Reply-To: <973c61bb-d1c4-a3ef-fec4-d492fa513d15@cambridgegreys.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 2 Dec 2019 21:14:19 +0100
Message-ID: <CAFLxGvyKsT_Yjs9KRndqadYHQeFWpN9yzyCX8BLX6Zzigsg1vw@mail.gmail.com>
Subject: Re: I get 5.4 fail to start
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um <linux-um@lists.infradead.org>

On Thu, Nov 28, 2019 at 6:27 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> Hi all,
>
> I get 5.4 fail to start. 5.4 gives:
>
> Checking that ptrace can change system call numbers...check_ptrace :
> child exited with exitcode 6, while expecting 0; status 0x67f
> Aborted
>
> And stops right at the very start.
>
> I do not recall anything there changing in the 5.2 - 5.4 timeframe so
> this is weird.

Hmm, I don't see this failure. What is your host kernel, your uml
kernel .config and commandline?

I agree that the macro usage is odd but why is it failing now?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

