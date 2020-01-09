Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from target.luon.net ([2a00:8240:5:10::21])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipUaY-0008Hw-N8
 for linux-um@lists.infradead.org; Thu, 09 Jan 2020 09:58:52 +0000
Message-ID: <5caba454fee6e04443a8b51c63c50a39b9b932d8.camel@debian.org>
Subject: Re: Bug#928924: user-mode-linux: xterm functionality broken due to
 wrong path to port-helper
From: Sjoerd Simons <sjoerd@debian.org>
Date: Thu, 09 Jan 2020 10:58:39 +0100
In-Reply-To: <4d26aa36-d2ab-b7f1-6cd6-abf1b158fe0a@kot-begemot.co.uk>
References: <451d491044af46fe1d87d10196e24e8e7b076f26.camel@debian.org>
 <157830351172.48768.9073767232890169518.reportbug@beast>
 <95a2a1cdb323633a0779acaeb0377ed60e7e3afc.camel@debian.org>
 <4d26aa36-d2ab-b7f1-6cd6-abf1b158fe0a@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, rrs@debian.org, 928924@bugs.debian.org
Cc: linux-um@lists.infradead.org

On Mon, 2020-01-06 at 16:58 +0000, Anton Ivanov wrote:
> 
> On 06/01/2020 16:21, Ritesh Raj Sarraf wrote:
> > Control: tag -1 +help
> > 
> > On Mon, 2020-01-06 at 10:38 +0100, Sjoerd Simons wrote:
> > > On my sid system:
> > > ```
> > > $ strings /usr/bin/linux.uml | grep port-helper
> > > /usr/lib//uml/port-helper
> > > ```
> > > 
> > > So the path is still incorrect even with newer upstream kernels.
> > 
> > I spent some time today looking at the new build but I haven't been
> > able to ascertain why this isn't setting the correct path.
> 
> It is used in a "user" side file - xterm.c
> 
> None of these sees "CONFIG_" so it considers it undef-ed which
> defaults 
> to 32 bit.

Is there any reason why the port helper is in the weird `/usr/lib64`
that seems more like a redhat-ism; On Debian if it's proper multi arch
under `/usr/lib/x86_64-linux-gnu/`..

However uml-utilities can't be installed for multiple architectures on
one system anyway (as it ships binaries). So there is little point in
try to being multi-arch-like (or just awkward :p)...

So to me the most practical and straight-forward solution would
probably be to revert the broken kernel patch and change the uml-
utilities package instead to always install in a single spot.

> You need to use some other way to figure out what is the build or to
> set 
> OS_LIB_PATH for this case.
> 
> > ```
> > $ strings `which  linux.uml` | grep port-helper
> > /usr/lib/uml/port-helper
> > ```
> > 
> > First, for context to the readers here, the port-helper binary is
> > shipped with uml-utilities package. This package, depending on the
> > architecture, installs the binary to a architecture specific
> > location.
> > 
> > https://sources.debian.org/src/uml-utilities/20070815.2-1/Makefile/#L10
> > 
> > Which on an amd64 machine is: /usr/lib64/uml/port-helper
> > 
> > ```
> > $ dpkg  -S /usr/lib64/uml/port-helper
> > uml-utilities: /usr/lib64/uml/port-helper
> > ```
> > 
> > The UML setup on my box always worked because long back, when I
> > first
> > encountered this problem, I had created a symlink of the path to
> > /usr/lib/ too. And had completely forgotten about it. My apologies.
> > 
> > 
> > But that said, the current problem is with the UML binary built by
> > the
> > kernel sources.
> > Problem is that, as mentioned above and other reports too on this
> > bug
> > report thread, the path resolved at build time is always
> > "/usr/lib/uml/".
> > 
> > The build configuration and the code are all correct.
> > 
> > ```
> > $ grep 64BIT .config
> > CONFIG_64BIT=y
> > CONFIG_64BIT_TIME=y
> > CONFIG_PHYS_ADDR_T_64BIT=y
> > CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> > ```
> > 
> > 
> > Snipped from: arch/um/include/shared/os.h
> > 
> > ```
> > #ifdef CONFIG_64BIT
> > #define OS_LIB_PATH     "/usr/lib64/"
> > #else
> > #define OS_LIB_PATH     "/usr/lib/"
> > #endif
> > ```
> > 
> > I also checked the generated include headers and they are correct
> > for
> > the amd64 .config file.
> > 
> > ```
> > linux-source-5.4/include/generated$ grep 64BIT autoconf.h
> > #define CONFIG_64BIT_TIME 1
> > #define CONFIG_PHYS_ADDR_T_64BIT 1
> > #define CONFIG_64BIT 1
> > #define CONFIG_ARCH_DMA_ADDR_T_64BIT 1
> > ```
> > 
> > I'll keep looking as time permits but if anyone else has ideas on
> > what
> > I may be doing wrong, please do mention.
> > 
> > Thanks,
> > Ritesh
> > 
> > 
> > _______________________________________________
> > linux-um mailing list
> > linux-um@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-um
> > 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

