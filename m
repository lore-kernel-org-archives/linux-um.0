Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyUUE-005mpY-Rn
	for linux-um@lists.infradead.org; Tue, 07 Jun 2022 08:22:53 +0000
Message-ID: <6bfd0b100c71413d893c13440c8ea627078147e1.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] um: Assorted console related fixes
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 07 Jun 2022 10:22:43 +0200
In-Reply-To: <20220606181615.0467c5fa@crass-HP-ZBook-15-G2>
References: <20220101215810.13260-1-richard@nod.at>
	 <1f5276f9b2950d34eec89004d2a2322a06145d2b.1646802841.development@efficientek.com>
	 <367534223.127621.1646814902625.JavaMail.zimbra@nod.at>
	 <20220310122156.6de90000@crass-HP-ZBook-15-G2>
	 <CAFLxGvyxugU=kQLpWbpaaggskmw5NXkp3hkpppwyqLQLec8Xbg@mail.gmail.com>
	 <20220606181615.0467c5fa@crass-HP-ZBook-15-G2>
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
To: development@efficientek.com, Richard Weinberger <richard.weinberger@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, linux-um <linux-um@lists.infradead.org>

On Mon, 2022-06-06 at 18:16 -0500, Glenn Washburn wrote:
>  GDB says that the process was terminated with
> SIGKILL, which I'm guessing is why uml_console_exit() is not run.
> 

https://patchwork.ozlabs.org/project/linux-um/patch/20220520194536.1acbb414a2d1.I1d71bab01d45f7f8e446df6e98547a7989338208@changeid/

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

