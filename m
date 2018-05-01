Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fDcu1-0007nH-0j
 for linux-um@lists.infradead.org; Tue, 01 May 2018 21:33:38 +0000
Received: by mail-wr0-x22d.google.com with SMTP id p18-v6so11930148wrm.1
 for <linux-um@lists.infradead.org>; Tue, 01 May 2018 14:33:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d5c5b0e3-2794-6599-744a-7ca9e87df56e@kot-begemot.co.uk>
References: <e58ff1a0-df76-7213-08d5-1f796a6a3956@cambridgegreys.com>
 <1708862.d7yAjbcJLQ@blindfold>
 <40d875d4-8071-85e1-bad9-83995c9ebf8b@cambridgegreys.com>
 <4362422.B3hMBL5bEi@blindfold>
 <d5c5b0e3-2794-6599-744a-7ca9e87df56e@kot-begemot.co.uk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 1 May 2018 23:33:24 +0200
Message-ID: <CAFLxGvwGOv7gBTK35o6=2yjo1Ao5U0e0KSuqfONJ0YqubnugnQ@mail.gmail.com>
Subject: Re: Question about process.c
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
Cc: linux-um@lists.infradead.org

Anton,

On Tue, May 1, 2018 at 4:43 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> OK.
>
> I will park it until I have a large timeslot to play with it and analyze
> it properly.

Can you please use reply-all and not top-post?

I did some research.
The force flush has its roots in uml-patch-2.4.9-4, in form of
flush_tlb_kernel_vm().
We have kind of a changelog:
http://user-mode-linux.sourceforge.net/old/changelog-uml-patch-2.4.9-4.bz2.html
"Fixed the process segfaults that happened when the system was swapping"

In uml-patch-2.4.9-8 it gained further changes.
"Fixed and cleaned up the tlb flush code".

I think it is high noon to review/rethink that code...

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

