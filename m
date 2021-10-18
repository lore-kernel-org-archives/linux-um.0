Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: linux-next: Tree for Oct 18 ('make' error on ARCH=um)
References: <20211018203023.036d8362@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a1b2bdda-d1cf-807b-6a84-73a3e347639c@infradead.org>
Date: Mon, 18 Oct 2021 14:14:59 -0700
MIME-Version: 1.0
In-Reply-To: <20211018203023.036d8362@canb.auug.org.au>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>

On 10/18/21 2:30 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20211015:
> 

UML (arch=um) with SUBARCH of i386 or x86_64,
using gcc, not clang:

make[1]: Entering directory '/work/lnx/next/linux-next-20211018/UM64'
../scripts/Makefile.clang:19: *** Specify CROSS_COMPILE or add '--target=' option to scripts/Makefile.clang.  Stop.
make[1]: Leaving directory '/work/lnx/next/linux-next-20211018/UM64'
make: *** [Makefile:226: __sub-make] Error 2


Just use a make target of defconfig:

make ARCH=um SUBARCH=x86_64 O=UM64 defconfig

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

