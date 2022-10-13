Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 13 Oct 2022 10:21:18 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v6 5/7] treewide: use get_random_u32() when possible
Message-ID: <Y0g6/sIJMq/JRe6y@zx2c4.com>
References: <20221010230613.1076905-1-Jason@zx2c4.com>
 <3026360.ZldQQBzMgz@eto.sf-tec.de>
 <20221013101635.GB11818@breakpoint.cc>
 <11986571.xaOnivgMc4@eto.sf-tec.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11986571.xaOnivgMc4@eto.sf-tec.de>
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
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>, kasan-dev@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org

On Thu, Oct 13, 2022 at 01:40:40PM +0200, Rolf Eike Beer wrote:
> Am Donnerstag, 13. Oktober 2022, 12:16:35 CEST schrieb Florian Westphal:
> > Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > > Florian, can you comment and maybe fix it?
> > 
> > Can't comment, do not remember -- this was 5 years ago.
> > 
> > > Or you wanted to move the variable before the loop and keep the random
> > > state between the loops and only reseed when all '1' bits have been
> > > consumed.
> > Probably.  No clue, best to NOT change it to not block Jasons series and
> > then just simplify this and remove all the useless shifts.
> 
> Sure. Jason, just in case you are going to do a v7 this could move to u8 then.

Indeed I think this is one to send individually to netdev@ once the tree
opens there for 6.2.

Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

