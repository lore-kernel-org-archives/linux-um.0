Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [PATCH 0/3] Kbuild: fix and clean-up arch/um/Makefile
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <086167f3-5ed3-1184-bb6f-6c86a5bd6a77@infradead.org>
Date: Sat, 4 Aug 2018 17:58:41 -0700
MIME-Version: 1.0
In-Reply-To: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-US
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kbuild@vger.kernel.org
Cc: Michal Marek <michal.lkml@markovi.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>

On 08/03/2018 09:47 PM, Masahiro Yamada wrote:
> 1/3 fixes the build failure reported by Randy.
> (I may have seen a similar report before, but I cannot recall it.)
> 
> 2/3 and 3/3 clean-up the Makefile a bit more.
> 
> I'd like to apply this series to kbuild tree.
> Ack from UML folks are appreciated.
> 
> 
> 
> Masahiro Yamada (3):
>   um: fix parallel building with O= option
>   kbuild: add %asm-generic to no-dot-config-targets
>   um: clean up archheaders recipe
> 
>  Makefile         | 2 +-
>  arch/um/Makefile | 9 +--------
>  2 files changed, 2 insertions(+), 9 deletions(-)
> 

for the series:
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

