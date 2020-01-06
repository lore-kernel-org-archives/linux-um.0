Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioVhx-0008UY-PP
 for linux-um@lists.infradead.org; Mon, 06 Jan 2020 16:58:28 +0000
Subject: Re: Bug#928924: user-mode-linux: xterm functionality broken due to
 wrong path to port-helper
References: <451d491044af46fe1d87d10196e24e8e7b076f26.camel@debian.org>
 <157830351172.48768.9073767232890169518.reportbug@beast>
 <95a2a1cdb323633a0779acaeb0377ed60e7e3afc.camel@debian.org>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <4d26aa36-d2ab-b7f1-6cd6-abf1b158fe0a@kot-begemot.co.uk>
Date: Mon, 6 Jan 2020 16:58:19 +0000
MIME-Version: 1.0
In-Reply-To: <95a2a1cdb323633a0779acaeb0377ed60e7e3afc.camel@debian.org>
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
To: rrs@debian.org, Sjoerd Simons <sjoerd@debian.org>, 928924@bugs.debian.org
Cc: linux-um@lists.infradead.org



On 06/01/2020 16:21, Ritesh Raj Sarraf wrote:
> Control: tag -1 +help
> 
> On Mon, 2020-01-06 at 10:38 +0100, Sjoerd Simons wrote:
>> On my sid system:
>> ```
>> $ strings /usr/bin/linux.uml | grep port-helper
>> /usr/lib//uml/port-helper
>> ```
>>
>> So the path is still incorrect even with newer upstream kernels.
> 
> I spent some time today looking at the new build but I haven't been
> able to ascertain why this isn't setting the correct path.

It is used in a "user" side file - xterm.c

None of these sees "CONFIG_" so it considers it undef-ed which defaults 
to 32 bit.

You need to use some other way to figure out what is the build or to set 
OS_LIB_PATH for this case.

> 
> ```
> $ strings `which  linux.uml` | grep port-helper
> /usr/lib/uml/port-helper
> ```
> 
> First, for context to the readers here, the port-helper binary is
> shipped with uml-utilities package. This package, depending on the
> architecture, installs the binary to a architecture specific location.
> 
> https://sources.debian.org/src/uml-utilities/20070815.2-1/Makefile/#L10
> 
> Which on an amd64 machine is: /usr/lib64/uml/port-helper
> 
> ```
> $ dpkg  -S /usr/lib64/uml/port-helper
> uml-utilities: /usr/lib64/uml/port-helper
> ```
> 
> The UML setup on my box always worked because long back, when I first
> encountered this problem, I had created a symlink of the path to
> /usr/lib/ too. And had completely forgotten about it. My apologies.
> 
> 
> But that said, the current problem is with the UML binary built by the
> kernel sources.
> Problem is that, as mentioned above and other reports too on this bug
> report thread, the path resolved at build time is always
> "/usr/lib/uml/".
> 
> The build configuration and the code are all correct.
> 
> ```
> $ grep 64BIT .config
> CONFIG_64BIT=y
> CONFIG_64BIT_TIME=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> ```
> 
> 
> Snipped from: arch/um/include/shared/os.h
> 
> ```
> #ifdef CONFIG_64BIT
> #define OS_LIB_PATH     "/usr/lib64/"
> #else
> #define OS_LIB_PATH     "/usr/lib/"
> #endif
> ```
> 
> I also checked the generated include headers and they are correct for
> the amd64 .config file.
> 
> ```
> linux-source-5.4/include/generated$ grep 64BIT autoconf.h
> #define CONFIG_64BIT_TIME 1
> #define CONFIG_PHYS_ADDR_T_64BIT 1
> #define CONFIG_64BIT 1
> #define CONFIG_ARCH_DMA_ADDR_T_64BIT 1
> ```
> 
> I'll keep looking as time permits but if anyone else has ideas on what
> I may be doing wrong, please do mention.
> 
> Thanks,
> Ritesh
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

