Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g2BGM-0003rR-FD
 for linux-um@lists.infradead.org; Tue, 18 Sep 2018 08:21:52 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] samples: disable CONFIG_SAMPLES for UML
Date: Tue, 18 Sep 2018 10:21:22 +0200
Message-ID: <2024081.XhWFmWp6tJ@blindfold>
In-Reply-To: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com>
References: <1537243113-1710-1-git-send-email-yamada.masahiro@socionext.com>
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, David Howells <dhowells@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andy Gross <andy.gross@linaro.org>

Am Dienstag, 18. September 2018, 05:58:33 CEST schrieb Masahiro Yamada:
> Some samples require headers installation, so commit 3fca1700c4c3
> ("kbuild: make samples really depend on headers_install") added
> such dependency in the top Makefile.  However, UML fails to build
> with CONFIG_SAMPLES=y because UML does not support headers_install.
> 
> Fixes: 3fca1700c4c3 ("kbuild: make samples really depend on headers_install")
> Reported-by: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Is there anything UML can do better?
Not sure whether an arch like is supposed to install headers at all,
I guess no. :)

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

