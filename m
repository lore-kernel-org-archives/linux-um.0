Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
MIME-Version: 1.0
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
In-Reply-To: <1571822941-29776-1-git-send-email-rppt@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2019 06:25:48 -0400
Message-ID: <CAHk-=whd6wNfx2bq7BmN4ouZgt=NQ5pw+3uqPOTbvz_Qb3itFg@mail.gmail.com>
Subject: Re: [PATCH 00/12] mm: remove __ARCH_HAS_4LEVEL_HACK
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Linux-MM <linux-mm@kvack.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch <linux-arch@vger.kernel.org>, linux-c6x-dev@linux-c6x.org, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Jeff Dike <jdike@addtoit.com>, Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-um@lists.infradead.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-um.lists.infradead.org>

On Wed, Oct 23, 2019 at 5:29 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> These patches convert several architectures to use page table folding and
> remove __ARCH_HAS_4LEVEL_HACK along with include/asm-generic/4level-fixup.h.

Thanks for doing this.

The patches look sane from a quick scan, and it's definitely the right
thing to do. So ack on my part, but obviously testing the different
architectures would be a really good thing...

                Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

