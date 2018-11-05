Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gJn25-0001GG-TY
 for linux-um@lists.infradead.org; Mon, 05 Nov 2018 22:07:42 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: 4.20-rc1 looks broken for UML
Date: Mon, 05 Nov 2018 23:07:18 +0100
Message-ID: <11176055.DIHjKAC0ao@blindfold>
In-Reply-To: <1ae6cae1-25a2-30e8-5078-ac318ce73f33@kot-begemot.co.uk>
References: <4a096c4f-6552-dbcb-676b-a87306dde07a@kot-begemot.co.uk>
 <1ae6cae1-25a2-30e8-5078-ac318ce73f33@kot-begemot.co.uk>
MIME-Version: 1.0
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

Am Montag, 5. November 2018, 16:22:36 CET schrieb Anton Ivanov:
> This looks like something specific to ttys - the io there gets 
> corruption and/or hangs.
> 
> I cannot reproduce it when I ssh in.
> 
> It does not look like it is the new write IRQ bugfix - that works fine 
> over 4.19.
> 
> Still debugging...

Hmm, I don't see this with my Debian userspace.
What exactly is your setup/config?

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

