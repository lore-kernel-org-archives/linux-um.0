Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyaqi-008EU4-Vt
	for linux-um@lists.infradead.org; Tue, 07 Jun 2022 15:10:30 +0000
Received: by mail-vs1-xe2c.google.com with SMTP id f1so4452171vsv.5
        for <linux-um@lists.infradead.org>; Tue, 07 Jun 2022 08:10:27 -0700 (PDT)
Date: Tue, 7 Jun 2022 10:10:18 -0500
From: Glenn Washburn <development@efficientek.com>
Subject: Re: [PATCH 0/4] um: Assorted console related fixes
Message-ID: <20220607101018.7ebe76d4@crass-HP-ZBook-15-G2>
In-Reply-To: <6bfd0b100c71413d893c13440c8ea627078147e1.camel@sipsolutions.net>
References: <20220101215810.13260-1-richard@nod.at>
	<1f5276f9b2950d34eec89004d2a2322a06145d2b.1646802841.development@efficientek.com>
	<367534223.127621.1646814902625.JavaMail.zimbra@nod.at>
	<20220310122156.6de90000@crass-HP-ZBook-15-G2>
	<CAFLxGvyxugU=kQLpWbpaaggskmw5NXkp3hkpppwyqLQLec8Xbg@mail.gmail.com>
	<20220606181615.0467c5fa@crass-HP-ZBook-15-G2>
	<6bfd0b100c71413d893c13440c8ea627078147e1.camel@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, linux-um <linux-um@lists.infradead.org>

On Tue, 07 Jun 2022 10:22:43 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Mon, 2022-06-06 at 18:16 -0500, Glenn Washburn wrote:
> >  GDB says that the process was terminated with
> > SIGKILL, which I'm guessing is why uml_console_exit() is not run.
> > 
> 
> https://patchwork.ozlabs.org/project/linux-um/patch/20220520194536.1acbb414a2d1.I1d71bab01d45f7f8e446df6e98547a7989338208@changeid/

Great! I've tested that this solves the SIGKILL issue and that stty
reports the same values before and after running a UML instance.

However, the flags re not the same (before 32770 and after 34818, in
decimal). It seems that the O_NONBLOCK flag is not being restored to
its original value (off).

So now the terminal is not messed up, but the flags are still an issue
for me because having stdin/stdout in non-blocking mode breaks some of
my scripts using uml.

Glenn

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

